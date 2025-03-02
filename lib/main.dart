import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const ClassPlanApp());
}

class ClassPlanApp extends StatelessWidget {
  const ClassPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: lightMode,
      darkTheme: darkMode,
      
    );
  }
}