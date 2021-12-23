import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:yalidine_form/api/pdf_api.dart';
import 'package:yalidine_form/models/device.dart';
import 'package:yalidine_form/utils/texts.dart';

class PdfDeviceApi {
  static Future<File> generate(List<Device> devices, DateTime date) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildTitle(),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTable(devices),
      ],
      footer: (context) => buildFooter(date),
    ));

    return PdfApi.saveDocument(
        name:
            'myDevices_${date.day}${date.month}${date.year}${date.hour}${date.minute}.pdf',
        pdf: pdf);
  }

  static Widget buildTitle() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Texts.extractionPdfTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  static Widget buildTable(List<Device> devices) {
    final headers = [
      Texts.model,
      Texts.brand,
      Texts.color,
      Texts.state,
      Texts.wilaya,
      Texts.commune,
      Texts.qrcode,
    ];

    List<TableRow> data = devices.map((device) {
      String qr =
          '${Texts.model} : ${device.model}\n${Texts.brand} : ${device.brand}\n${Texts.color} : ${device.color}\n${Texts.state} : ${device.state}\n${Texts.wilaya} : ${device.wilaya}\n${Texts.commune} : ${device.commune}';

      return TableRow(
        verticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      Texts.model,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' : ${device.model.toString()}',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      Texts.brand,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' : ${device.brand.toString()}',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      Texts.color,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' : ${device.color.toString()}',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      Texts.state,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' : ${device.state.toString()}',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      Texts.wilaya,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' : ${device.wilaya.toString()}',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      Texts.commune,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' : ${device.commune.toString()}',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 100,
                width: 100,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: qr,
                ),
              ),
            ]),
          ),
        ],
      );
    }).toList();

    return Table(
      children: [
        TableRow(
          verticalAlignment: TableCellVerticalAlignment.middle,
          decoration: const BoxDecoration(color: PdfColors.grey300),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                Texts.deviceDescription,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                Texts.qrcode,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ...data,
      ],
    );
  }

  static Widget buildFooter(DateTime date) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            _buildDate(date),
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      );

  static String _buildDate(DateTime date) {
    String day = date.day > 9 ? date.day.toString() : '0${date.day}';
    String month = date.month > 9 ? date.month.toString() : '0${date.month}';
    String year = date.year.toString();
    String hour = date.hour > 9 ? date.hour.toString() : '0${date.hour}';
    String minute =
        date.minute > 9 ? date.minute.toString() : '0${date.minute}';

    return '${Texts.the} $day-$month-$year ${Texts.at} $hour:$minute';
  }
}
