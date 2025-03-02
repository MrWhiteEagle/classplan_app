import 'package:classplan_new/logic/settings.json';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/appBar.dart';
import 'package:flutter/material.dart';

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
                    "Język:",
                    style: contentTextStyle(context)
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