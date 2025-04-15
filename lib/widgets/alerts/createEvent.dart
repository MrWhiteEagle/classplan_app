import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';

void createEvent(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          titleTextStyle: primaryBoldTextStyle(context).copyWith(fontSize: 20),
          title: Text('Utwórz wydarzenie', textAlign: TextAlign.center),
          icon: Icon(
            Icons.calendar_month,
            color: Theme.of(context).colorScheme.primary,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DatePickerDialog(
                firstDate: DateTime(1, 1, 2024),
                lastDate: DateTime(1, 1, 2026),
              ),
              SizedBox(height: 30),
              Text('Tytuł'),
              TextField(),
              SizedBox(height: 30),
              Text('Opis'),
              TextField(),
            ],
          ),
        ),
  );
}
