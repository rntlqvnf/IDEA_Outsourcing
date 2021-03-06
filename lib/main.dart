import 'package:bot_toast/bot_toast.dart';
import 'package:emusic/service/http_client_service.dart';
import 'package:emusic/service/http_client_service_impl.dart';
import 'package:emusic/service/socket_service.dart';
import 'package:emusic/service/socket_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:emusic/contants/globals.dart';
import 'package:emusic/routes.dart';
import 'package:emusic/service/flush_service.dart';
import 'package:emusic/service/flush_service_impl.dart';
import 'package:emusic/service/navigation_service.dart';
import 'package:emusic/service/navigation_service_impl.dart';
import 'package:emusic/ui/theme.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) => runApp(MyApp()));
}

void setupLocator() {
  locator.registerSingleton<HttpClientService>(HttpClientServiceImpl());
  locator.registerSingleton<NavigationService>(NavigationServiceImpl());
  locator.registerSingleton<FlushService>(FlushServiceImpl());
  locator.registerSingleton<SocketService>(SocketServiceImpl());
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
      title: 'eMusic',
      theme: BaseTheme.lightTheme,
      darkTheme: BaseTheme.darkTheme,
      initialRoute: Routes.greeting,
      routes: Routes.routes,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      navigatorKey: locator<NavigationService>().key,
    );
  }
}
