import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yalidine_form/api/pdf_api.dart';
import 'package:yalidine_form/api/pdf_device_api.dart';
import 'package:yalidine_form/models/device.dart';
import 'package:yalidine_form/providers/add_device_provider.dart';
import 'package:yalidine_form/providers/all_devices_provider.dart';
import 'package:yalidine_form/utils/colors.dart';
import 'package:yalidine_form/utils/constants.dart';
import 'package:yalidine_form/utils/fonts.dart';
import 'package:yalidine_form/utils/texts.dart';
import 'package:yalidine_form/widgets/qr_code_dialog.dart';
import 'package:yalidine_form/widgets/waiting_dialog.dart';

class AllDevicesScreen extends ConsumerWidget {
  static const routeName = '/all-devices';

  CollectionReference devicesRef =
      FirebaseFirestore.instance.collection('devices');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Texts.allDevicesScreen),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: devicesRef.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    Texts.errorWhenGettingDevices,
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: AppFontsSize.defaultFontSize,
                    ),
                  ),
                );
              } else {
                List<Device> devices = [];

                if (snapshot.data != null) {
                  devices = snapshot.data!.docs
                      .map(
                        (e) =>
                            Device.fromJson(e.data() as Map<String, dynamic>),
                      )
                      .toList();
                }

                ref.read(allDevicesProvider).init(
                      devices: devices,
                    );

                return const DevicesList();
              }
          }
        },
      ),
    );
  }
}

class DevicesList extends ConsumerWidget {
  const DevicesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Device> devices = ref.watch(allDevicesProvider).devices;

    QRCodeDialog _deviceDetailDialog = QRCodeDialog(context: context);

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (ctx, index) => Card(
                elevation: 2,
                child: ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Icon(
                      AppConstants().deviceIcon(devices[index]),
                    ),
                  ),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      '${devices[index].model} ${devices[index].brand} ${devices[index].color}',
                    ),
                  ),
                  subtitle: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      '${devices[index].wilaya} ${devices[index].commune} - ${Texts.state} : ${devices[index].state}',
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      _deviceDetailDialog.showCustomDatePickerDialog(
                        device: devices[index],
                      );
                    },
                    child: const Icon(
                      FontAwesomeIcons.qrcode,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FloatingActionButton.extended(
              onPressed: () async {
                WaitingDialog waitingDialog = WaitingDialog(context: context);
                waitingDialog.showDialogLoading(
                  title: Texts.waitingForExtract,
                );

                // begin extraction
                final date = DateTime.now();

                final pdfFile = await PdfDeviceApi.generate(devices,date);

                waitingDialog.close();

                PdfApi.openFile(pdfFile);


              },
              label: const Text(
                Texts.extract,
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
              icon: const Icon(FontAwesomeIcons.filePdf),
              backgroundColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
