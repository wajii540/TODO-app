import 'package:flutter/material.dart';
import 'package:todo_app_ui/screens.dart/dashboard_screen.dart';
import 'package:todo_app_ui/screens.dart/login_screen.dart';
import 'package:todo_app_ui/screens.dart/registor_screen.dart';
import 'package:todo_app_ui/screens.dart/splash.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: DashboardScreen(),
    );
  }
}
