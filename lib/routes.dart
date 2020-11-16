import 'package:emusic/ui/camera/camera_screen.dart';
import 'package:emusic/ui/gallery/gallery_screen.dart';
import 'package:emusic/ui/main_menu/main_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emusic/store/gallery/gallery_store.dart';
import 'package:emusic/ui/editing/editing_screen.dart';
import 'package:emusic/ui/greeting/greeting_screen.dart';
import 'package:emusic/ui/home/main_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/home';
  static const String camera = '/camera';
  static const String editing = '/camera/image/editing';
  static const String greeting = '/homescreen';
  static const String mainMenu = '/mainMenu';
  static const String gallery = '/gallery';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => MainScreen(),
    camera: (BuildContext context) => CameraScreen(),
    editing: (BuildContext context) => EditingScreen(),
    greeting: (BuildContext context) => GreetingScreen(),
    mainMenu: (BuildContext context) => MultiProvider(providers: [
          Provider<GalleryStore>(create: (_) => GalleryStore()),
        ], child: MainMenuScreen()),
    gallery: (BuildContext context) => GalleryScreen(),
  };
}
