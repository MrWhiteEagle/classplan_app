import 'package:classplan_new/logic/isar_service.dart';
import 'package:classplan_new/models/class_database.dart';
import 'package:classplan_new/models/grade_database.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService().initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClassDatabase()),
        ChangeNotifierProvider(create: (context) => StudentDatabase()),
        ChangeNotifierProvider(create: (context) => GradeDatabase()),
      ],
      child: ClassPlanApp(),
    ),
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

      // darkTheme: darkMode,
    );
  }
}
