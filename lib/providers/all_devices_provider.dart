import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yalidine_form/models/device.dart';
import 'package:yalidine_form/utils/constants.dart';

final allDevicesProvider = ChangeNotifierProvider.autoDispose<AllDevicesProvider>(
    (ref) => AllDevicesProvider());

class AllDevicesProvider extends ChangeNotifier {
  // Variables
  List<Device> _devices = [];


  // Getters
  List<Device> get devices => _devices;


  // Functions
  init({List<Device> devices = const []}) {
    _devices = devices;
  }
}
