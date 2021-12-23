import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yalidine_form/utils/colors.dart';
import 'package:yalidine_form/utils/constants.dart';
import 'package:yalidine_form/utils/fonts.dart';

class WaitingDialog {
  late BuildContext _context;
  bool _dialogIsOpen = false;

  WaitingDialog({required context}) {
    _context = context;
  }

  // TODO : fix design
  showDialogLoading({String title = ''}) async {
    title;
    _dialogIsOpen = true;
    return showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(
          false,
        ),
        child: AlertDialog(
          titlePadding: const EdgeInsets.all(10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppFontsSize.defaultFontSize,
                  ),
                ),
              ),
              AppConstants().spacer,
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  void close() {
    if (_dialogIsOpen) {
      Navigator.pop(_context);
      _dialogIsOpen = false;
    }
  }
}
