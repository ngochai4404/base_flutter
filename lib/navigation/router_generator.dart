import 'dart:io';

import 'package:blocapptest/main.dart';
import 'package:blocapptest/mobox_screen.dart';
import 'package:blocapptest/presentation/home/ui/home_screen.dart';
import 'package:blocapptest/presentation/login/ui/login_screen.dart';
import 'package:blocapptest/presentation/map/ui/map_screen.dart';
import 'package:blocapptest/presentation/pdf/ui/web/pdf_screen.dart'
    as PdfWebScreen;
import 'package:blocapptest/presentation/pdf/ui/mobile/pdf_screen.dart'
    as PdfMobileScreen;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/pdf':
        return MaterialPageRoute(
            builder: (_) => (kIsWeb)
                ? PdfWebScreen.PdfScreen()
                : PdfMobileScreen.PdfScreen());
      case '/map':
        // Validation of correct data type
        //   if (args is String) {
        //     return MaterialPageRoute(
        //       builder: (_) => SecondPage(
        //         data: args,
        //       ),
        //     );
        //   }
        return MaterialPageRoute(builder: (_) => MapScreen());
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
