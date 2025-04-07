import 'package:classplan_new/models/class_database.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//dialog for adding a new student
void addStudentDialog(BuildContext context, int classId) {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("Dodaj ucznia"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Imię:", style: higherContentTextStyle(context)),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Imię ucznia",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              Text("Nazwisko:", style: higherContentTextStyle(context)),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  hintText: "Nazwisko ucznia",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                nameController.clear();
                lastNameController.clear();
              },
              child: Text(
                "Anuluj",
                style: onSurfaceTextStyle(context).copyWith(fontSize: 18),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Provider.of<StudentDatabase>(context, listen: false).addStudent(
                  nameController.text,
                  lastNameController.text,
                  classId,
                );
                Navigator.pop(context);
                nameController.clear();
                lastNameController.clear();
              },
              child: Text(
                "Dodaj",
                style: primaryBoldTextStyle(context).copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
  );
}

editCareTeacherDialog(BuildContext context) {
  final careTeacherNameCtrl = TextEditingController();
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(
            'Zmień wychowawcę',
            style: primaryBoldTextStyle(context).copyWith(fontSize: 20),
          ),
          icon: Icon(
            Icons.manage_accounts,
            color: Theme.of(context).colorScheme.primary,
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: careTeacherNameCtrl,
                decoration: InputDecoration(
                  hintText: 'Imie i nazwisko wychowawcy',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                careTeacherNameCtrl.clear();
              },
              child: Text(
                "Anuluj",
                style: onSurfaceTextStyle(context).copyWith(fontSize: 18),
              ),
            ),
            MaterialButton(
              onPressed: () {
                final newClass =
                    Provider.of<ClassDatabase>(
                      context,
                      listen: false,
                    ).fetchedClass;
                newClass!.careTeacher = careTeacherNameCtrl.text;
                Provider.of<ClassDatabase>(
                  context,
                  listen: false,
                ).updateClass(newClass);
                careTeacherNameCtrl.clear();
                Navigator.pop(context);
              },
              child: Text(
                "Zapisz",
                style: primaryBoldTextStyle(context).copyWith(fontSize: 18),
              ),
            ),
          ],
        ),
  );
}
