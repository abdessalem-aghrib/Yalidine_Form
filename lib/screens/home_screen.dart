import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yalidine_form/screens/add_device_screen.dart';
import 'package:yalidine_form/screens/all_devices_screen.dart';
import 'package:yalidine_form/utils/colors.dart';
import 'package:yalidine_form/utils/texts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Texts.homeScreen),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // TODO : check connection before
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddDeviceScreen.routeName),
              child: const Text(Texts.addDevice),
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AllDevicesScreen.routeName),
              child: const Text(Texts.allDevices),
            ),
          ],
        ),
      ),
    );
  }
}
