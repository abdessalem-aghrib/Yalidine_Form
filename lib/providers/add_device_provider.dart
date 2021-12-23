import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalidine_form/models/device.dart';
import 'package:yalidine_form/models/wilaya.dart';
import 'package:yalidine_form/utils/constants.dart';

final addDeviceProvider = ChangeNotifierProvider.autoDispose<AddDeviceProvider>(
    (ref) => AddDeviceProvider());

class AddDeviceProvider extends ChangeNotifier {
  // Variables
  Wilaya _selectedWilaya = AppConstants.wilayas[15];
  Device _selectedDevice = Device(
    idUser: '',
    wilaya: AppConstants.wilayas[15].name,
    commune: AppConstants.wilayas[15].communes[0],
    model: AppConstants().models[0],
    brand: AppConstants().brands[0],
    state: AppConstants().states[0],
    color: AppConstants().colors[0],
  );

  // Getters
  Device get selectedDevice => _selectedDevice;

  Wilaya get selectedWilaya => _selectedWilaya;

  // Functions
  init() {
    _selectedDevice = Device(
      idUser: '',
      model: AppConstants().models[0],
      brand: AppConstants().brands[0],
      state: AppConstants().states[0],
      color: AppConstants().colors[0],
      wilaya: _selectedWilaya.name,
      commune: _selectedWilaya.communes[0],
    );

    notifyListeners();
  }

  changeModel(String newModel) {
    _selectedDevice.model = newModel;

    notifyListeners();
  }

  changeBrand(String newBrand) {
    _selectedDevice.brand = newBrand;

    notifyListeners();
  }

  changeState(String newState) {
    _selectedDevice.state = newState;

    notifyListeners();
  }

  changeColor(String newColor) {
    _selectedDevice.color = newColor;

    notifyListeners();
  }

  changeWilaya(Wilaya newWilaya) {
    _selectedWilaya = newWilaya;
    _selectedDevice.wilaya = newWilaya.name;
    _selectedDevice.commune = newWilaya.communes[0];

    notifyListeners();
  }

  changeCommune(String newCommune) {
    _selectedDevice.commune = newCommune;

    notifyListeners();
  }

  Future<bool> addDevice() {
    CollectionReference devicesRef =
        FirebaseFirestore.instance.collection('devices');

    return devicesRef.add(_selectedDevice.toJson()).then(
      (value) {
        print('device added with id = ${value.id}');
        return true;
      },
    ).catchError(
      (error) => false,
    );
  }
}
