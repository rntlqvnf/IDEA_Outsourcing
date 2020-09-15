import 'package:flutter/cupertino.dart';
import 'package:emusic/service/navigation_service.dart';

class NavigationServiceImpl implements NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  get key => navigatorKey;

  @override
  void pop({Object arguments}) {
    return navigatorKey.currentState.pop();
  }

  @override
  Future pushNamed(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  @override
  Future pushNamedAndRemoveAll(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}
