import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:python_app/store/camera/camera_store.dart';
import 'package:python_app/store/gallery/gallery_store.dart';
import 'package:python_app/ui/camera/gallery_camera_screen.dart';
import 'package:python_app/ui/editing/editing_screen.dart';
import 'package:python_app/ui/greeting/greeting_screen.dart';
import 'package:python_app/ui/home/screens/main_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/home';
  static const String camera = '/camera';
  static const String image = '/camera/image';
  static const String editing = '/camera/image/editing';
  static const String greeting = '/homescreen';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => MainScreen(),
    camera: (BuildContext context) => MultiProvider(
          providers: [
            Provider<CameraStore>(create: (_) => CameraStore()),
            Provider<GalleryStore>(create: (_) => GalleryStore()),
          ],
          child: GalleryCameraScreen(),
        ),
    image: (BuildContext context) => ImageScreen(),
    editing: (BuildContext context) => EditingScreen(),
    greeting: (BuildContext context) => GreetingScreen()
  };
}
