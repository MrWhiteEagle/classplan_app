import 'package:classplan_new/models/class_database.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ClassDatabase.initalize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClassDatabase()),
        ChangeNotifierProvider(create: (context) => StudentDatabase()),
      ],
      child: ClassPlanApp(),
    )
  );
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