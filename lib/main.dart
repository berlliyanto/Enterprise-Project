import 'package:flutter/material.dart';
import 'package:flutter_admin_ena/constant.dart';
import 'package:flutter_admin_ena/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LOGIN',
      onGenerateRoute: Routes.generateRoute,
      initialRoute: myLogin,
    );
  }
}