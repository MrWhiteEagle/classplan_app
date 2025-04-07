// ignore: unused_import
import 'package:classplan_new/logic/settings.json';
import 'package:classplan_new/models/class_database.dart';
import 'package:classplan_new/models/grade_database.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/appBars/appBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBar(title: "Ustawienia"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Resetuj Klasy i uczniów: ",
                    style: onSurfaceTextStyle(context),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Provider.of<ClassDatabase>(
                        context,
                        listen: false,
                      ).resetClassDatabase();
                      await Provider.of<StudentDatabase>(
                        context,
                        listen: false,
                      ).resetStudentDatabase();
                      await Provider.of<GradeDatabase>(
                        context,
                        listen: false,
                      ).resetGradeDatabase();
                    },
                    child: Icon(Icons.delete_forever_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
