import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalidine_form/models/device.dart';
import 'package:yalidine_form/models/wilaya.dart';
import 'package:yalidine_form/providers/add_device_provider.dart';
import 'package:yalidine_form/utils/colors.dart';
import 'package:yalidine_form/utils/constants.dart';
import 'package:yalidine_form/utils/texts.dart';
import 'package:yalidine_form/widgets/custom_dropdown.dart';
import 'package:yalidine_form/widgets/waiting_dialog.dart';
import 'package:yalidine_form/widgets/wilaya_dropdown.dart';

class AddDeviceScreen extends ConsumerStatefulWidget {
  const AddDeviceScreen({Key? key}) : super(key: key);

  static const routeName = '/add-device';

  @override
  ConsumerState<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends ConsumerState<AddDeviceScreen> {
  final _formKey = GlobalKey<FormState>();
  WaitingDialog? waitingDialog;

  Device _selectedDevice = Device();
  Wilaya _selectedWilaya = Wilaya();

  @override
  Widget build(BuildContext context) {
    _selectedDevice = ref.watch(addDeviceProvider).selectedDevice;
    _selectedWilaya = ref.watch(addDeviceProvider).selectedWilaya;

    waitingDialog = WaitingDialog(context: context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Texts.addDeviceScreen,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      WilayaDropDown(
                        title: Texts.wilaya,
                        dropdownList: AppConstants().wilayasDropdownItems,
                        selectedValue: _selectedWilaya,
                        onChanged: (Wilaya? w) =>
                            ref.read(addDeviceProvider).changeWilaya(w!),
                      ),
                      AppConstants().spacer,
                      CustomDropDown(
                        title: Texts.commune,
                        dropdownList: AppConstants().communesDropdownItems(_selectedWilaya),
                        selectedValue: _selectedDevice.commune.toString(),
                        validatorErrorText: '',
                        onChanged: (String? value) =>
                            ref.read(addDeviceProvider).changeCommune(value!),
                      ),
                      AppConstants().spacer,
                      CustomDropDown(
                        title: Texts.model,
                        dropdownList: AppConstants().modelsDropdownItems,
                        selectedValue: _selectedDevice.model.toString(),
                        validatorErrorText: Texts.selectModelFormError,
                        onChanged: (String? value) =>
                            ref.read(addDeviceProvider).changeModel(value!),
                      ),
                      AppConstants().spacer,
                      CustomDropDown(
                        title: Texts.brand,
                        dropdownList: AppConstants().brandsDropdownItems,
                        selectedValue: _selectedDevice.brand.toString(),
                        validatorErrorText: Texts.selectBrandFormError,
                        onChanged: (String? value) =>
                            ref.read(addDeviceProvider).changeBrand(value!),
                      ),
                      AppConstants().spacer,
                      CustomDropDown(
                        title: Texts.state,
                        dropdownList: AppConstants().statesDropdownItems,
                        selectedValue: _selectedDevice.state.toString(),
                        validatorErrorText: Texts.selectStateFormError,
                        onChanged: (String? value) =>
                            ref.read(addDeviceProvider).changeState(value!),
                      ),
                      AppConstants().spacer,
                      CustomDropDown(
                        title: Texts.color,
                        dropdownList: AppConstants().colorsDropdownItems,
                        selectedValue: _selectedDevice.color.toString(),
                        validatorErrorText: Texts.selectColorFormError,
                        onChanged: (String? value) =>
                            ref.read(addDeviceProvider).changeColor(value!),
                      ),
                      AppConstants().spacer,
                    ],
                  ),
                ),
              ),
              AppConstants().spacer,
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: _addDevice,
                  child: const Text(Texts.submit),
                ),
              ),
              AppConstants().bigSpacer,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addDevice() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    waitingDialog!.showDialogLoading(
      title: Texts.waitingForInsertionTheDevice,
    );

    CoolAlertType coolAlertType = CoolAlertType.success;
    String alertTitle = Texts.congratulation;
    String alertText = Texts.deviceInsertedWithSuccess;


    if(!await ref.read(addDeviceProvider).addDevice()){
      coolAlertType = CoolAlertType.error;
      alertTitle = Texts.error;
      alertText = Texts.errorWhenAddDevice;
    }

    waitingDialog!.close();

    CoolAlert.show(
      context: context,
      type: coolAlertType,
      title: alertTitle,
      text: alertText,
      backgroundColor: AppColors.white,
      confirmBtnText: Texts.close,
      confirmBtnColor: AppColors.primary,
    );

    // save data
    _formKey.currentState!.save();


    ref.read(addDeviceProvider).init();
    //
    // try {
    //   if (_authMode == AuthMode.login)
    //     await Provider.of<Auth>(context, listen: false).login(
    //         _authData['email'].toString(), _authData['password'].toString());
    //   else
    //     await Provider.of<Auth>(context, listen: false).signUp(
    //         _authData['email'].toString(), _authData['password'].toString());
    // } on HttpException catch (error) {
    //   const errorMessage = 'Authentication Failed...';
    //   _showErrorDialog(errorMessage);
    // } catch (error) {
    //   print(error);
    //   const errorMessage = 'Could not authenticate you right now...';
    //   _showErrorDialog(errorMessage);
    // }
  }
}
