
import 'package:blocapptest/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigation/router_generator.dart';
import 'utils/prefs_service.dart';

Future<void>  main() async{
  setupDI();
  PrefsService.init();
  runApp(const MaterialApp(
      initialRoute: '/login',
      onGenerateRoute: RouteGenerator.generateRoute
  ));
}
