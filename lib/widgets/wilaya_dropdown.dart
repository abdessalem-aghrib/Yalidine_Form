import 'package:flutter/material.dart';
import 'package:yalidine_form/models/wilaya.dart';
import 'package:yalidine_form/utils/colors.dart';
import 'package:yalidine_form/utils/fonts.dart';
import 'package:yalidine_form/utils/sizer.dart';
import 'package:yalidine_form/utils/texts.dart';

class WilayaDropDown extends StatelessWidget {
  String title;
  List<DropdownMenuItem<Wilaya>> dropdownList;
  Wilaya? selectedValue;
  Function(Wilaya?)? onChanged;

  WilayaDropDown({
    this.title = '',
    this.dropdownList = const [],
    this.selectedValue,
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
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<Wilaya>(
            onChanged: onChanged,
            value: selectedValue,
            items: dropdownList,
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
