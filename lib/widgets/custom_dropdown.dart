import 'package:flutter/material.dart';
import 'package:yalidine_form/utils/colors.dart';
import 'package:yalidine_form/utils/fonts.dart';
import 'package:yalidine_form/utils/sizer.dart';
import 'package:yalidine_form/utils/texts.dart';

class CustomDropDown extends StatelessWidget {
  String title;
  List<DropdownMenuItem<String>> dropdownList;
  String selectedValue;
  String validatorErrorText;
  Function(String?)? onChanged;

  CustomDropDown({
    this.title = '',
    this.dropdownList = const [
      DropdownMenuItem<String>(
        value: '',
        child: Text(
          '',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: AppFontsSize.defaultFontSize,
          ),
        ),
      )
    ],
    this.selectedValue = '',
    this.validatorErrorText = '',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.darkGrey,
              fontSize: AppFontsSize.defaultFontSize,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<String>(
            onChanged: onChanged,
            value: selectedValue,
            items: dropdownList,
            validator: (value) =>
            value!.isEmpty ? validatorErrorText : null,
            menuMaxHeight: Sizer.screenHeight(context) * 0.4,
            // style: const TextStyle(
            //   color: AppColors.white,
            //   fontSize: AppFontsSize.defaultFontSize,
            // ),
          ),
        ),
      ],
    );
  }
}
