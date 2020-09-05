import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:python_app/contants/globals.dart';
import 'package:python_app/routes.dart';
import 'package:python_app/service/camera_service.dart';
import 'package:python_app/service/camera_service_impl.dart';
import 'package:python_app/service/flush_service.dart';
import 'package:python_app/service/flush_service_impl.dart';
import 'package:python_app/service/navigation_service.dart';
import 'package:python_app/service/navigation_service_impl.dart';
import 'package:python_app/store/camera/camera_store.dart';
import 'package:python_app/ui/util/const.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

void setupLocator() {
  locator.registerSingleton<NavigationService>(NavigationServiceImpl());
  locator.registerSingleton<FlushService>(FlushServiceImpl());
  locator.registerSingleton<CameraService>(CameraServiceImpl());
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
          title: 'Emotion Picker',
          theme: Constants.lightTheme,
          darkTheme: Constants.darkTheme,
          initialRoute: Routes.initCamera,
          routes: Routes.routes,
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          navigatorKey: locator<NavigationService>().key,
        ));
  }
}
