import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:python_app/routes.dart';
import 'package:python_app/store/camera/camera_store.dart';
import 'package:python_app/ui/util/const.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<CameraStore>(create: (_) => CameraStore()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Constants.appName,
          theme: Constants.lightTheme,
          darkTheme: Constants.darkTheme,
          initialRoute: Routes.initCamera,
          routes: Routes.routes,
        ));
  }
}
