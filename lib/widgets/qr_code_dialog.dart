import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalidine_form/models/device.dart';
import 'package:yalidine_form/utils/colors.dart';
import 'package:yalidine_form/utils/constants.dart';
import 'package:yalidine_form/utils/fonts.dart';
import 'package:yalidine_form/utils/sizer.dart';
import 'package:yalidine_form/utils/texts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDialog {
  late BuildContext _context;

  double _screenHeight = 0;
  double _screenWidth = 0;

  QRCodeDialog({required context}) {
    _context = context;
    _screenHeight = Sizer.screenHeight(context);
    _screenWidth = Sizer.screenWidth(context);
  }

  showCustomDatePickerDialog({
    Device? device,
  }) async {
    late QrValidationResult qrValidationResult;

    return showDialog(
      context: _context,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(true),
        child: AlertDialog(
          title: const Center(
            child: Text(
              Texts.qrCodeOfDevice,
              style: TextStyle(
                fontSize: AppFontsSize.titleDialogFontSize,
                color: AppColors.primary,
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppConstants.bigBorderRadius),
            ),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          contentPadding: const EdgeInsets.all(
            AppConstants.defaultPadding,
          ),
          actionsPadding: const EdgeInsets.all(
            AppConstants.defaultPadding,
          ),
          content: Container(
            constraints: BoxConstraints(
              maxHeight: _screenHeight * 0.4,
              minHeight: _screenHeight * 0.2,
              maxWidth: _screenWidth,
              minWidth: _screenWidth,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer(
                  builder: (ctx, _, __) {
                    String qr =
                        '${Texts.model} : ${device!.model}\n${Texts.brand} : ${device.brand}\n${Texts.color} : ${device.color}\n${Texts.state} : ${device.state}\n${Texts.wilaya} : ${device.wilaya}\n${Texts.commune} : ${device.commune}';

                    qrValidationResult = QrValidator.validate(
                      data: qr,
                      version: QrVersions.auto,
                      errorCorrectionLevel: QrErrorCorrectLevel.L,
                    );

                    if (qrValidationResult.status == QrValidationStatus.error) {
                      return const Text(
                        Texts.errorWhenGenerateQrCode,
                      );
                    }

                    return QrImage(
                      data: qr,
                      version: QrVersions.auto,
                      size: _screenWidth * 0.75,
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () => Navigator.pop(_context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      Texts.close,
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)
    );
  }
}
