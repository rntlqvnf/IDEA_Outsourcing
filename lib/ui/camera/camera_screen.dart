import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<Map<String, String>> installedApps;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getApps() async {
    List<Map<String, String>> _installedApps;

    _installedApps = await AppAvailability.getInstalledApps();
    print(await AppAvailability.checkAvailability("com.jiangdg.usbcamera"));
    print(await AppAvailability.isAppEnabled("com.jiangdg.usbcamera"));

    setState(() {
      installedApps = _installedApps;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (installedApps == null)
      getApps()
          .then((value) => AppAvailability.launchApp("com.jiangdg.usbcamera"));

    return Container();
  }
}
