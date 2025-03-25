// ignore: unused_import
import 'package:classplan_new/logic/settings.json';
import 'package:classplan_new/models/class_database.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/appBar.dart';
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
                    style: contentTextStyle(context),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<ClassDatabase>(
                        context,
                        listen: false,
                      ).resetClassDatabase();
                      Provider.of<StudentDatabase>(
                        context,
                        listen: false,
                      ).resetStudentDatabase();
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
