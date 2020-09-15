import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emusic/store/camera/camera_store.dart';
import 'package:emusic/store/gallery/gallery_store.dart';
import 'package:emusic/ui/camera/gallery_camera_screen.dart';
import 'package:emusic/ui/editing/editing_screen.dart';
import 'package:emusic/ui/greeting/greeting_screen.dart';
import 'package:emusic/ui/home/screens/main_screen.dart';

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
