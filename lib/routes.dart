import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/constant.dart';
import 'package:flutter_admin_ena/dashboard.dart';
import 'package:flutter_admin_ena/login.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case myLogin:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case myDashboard:
        return MaterialPageRoute(builder: (context) => dashboard(name: " ",level: " ",));
      default:
    }
    return MaterialPageRoute(
      builder: ((context) {
        return const Scaffold(
          body: Center(
            child: Text("No Pages"),
          ),
        );
      }),
    );
  }
}
