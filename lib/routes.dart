import 'package:flutter/material.dart';
import 'package:python_app/ui/camera/camera_screen.dart';
import 'package:python_app/ui/home/screens/main_screen.dart';
import 'package:python_app/ui/init_screen/init_camera_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/home';
  static const String camera = '/camera';
  static const String initCamera = '/homescreen';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => MainScreen(),
    camera: (BuildContext context) => CameraApp(),
    initCamera: (BuildContext context) => InitCameraScreen()
  };
}
