import 'package:flutter/material.dart';
import 'package:python_app/camera/camera_screen.dart';
import 'package:python_app/screens/main_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/home';
  static const String camera = '/camera';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => MainScreen(),
    camera: (BuildContext context) => CameraApp()
  };
}
