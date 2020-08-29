import 'package:flutter/material.dart';
import 'package:python_app/routes.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      initialRoute: Routes.initCamera,
      routes: Routes.routes,
    );
  }
}
