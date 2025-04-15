import 'package:classplan_new/logic/db/event_database.dart';
import 'package:classplan_new/logic/isar_service.dart';
import 'package:classplan_new/logic/db/class_database.dart';
import 'package:classplan_new/logic/db/grade_database.dart';
import 'package:classplan_new/logic/db/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        ChangeNotifierProvider(create: (context) => EventDatabase()),
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
      locale: Locale('pl', 'PL'),
      supportedLocales: [Locale('pl', 'PL')],
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: lightMode,
      // darkTheme: darkMode,
    );
  }
}
