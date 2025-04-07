import 'package:classplan_new/models/grade.dart';
import 'package:classplan_new/models/grade_database.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/alerts/gradeDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentGradeTile extends StatelessWidget {
  const StudentGradeTile({
    super.key,
    required this.studentId,
    required this.grade,
  });

  final int studentId;
  final Grade grade;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 3,
          ),
        ),
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    grade.grade + grade.gradeAdd,
                    style: primaryBoldTextStyle(context),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Text(
                  grade.title,
                  style: primaryBoldTextStyle(context).copyWith(fontSize: 20),
                ),
              ),
              returnGradeTypeOnCard(grade.type),
              IconButton(
                onPressed: () async {
                  final newGrade = grade;
                  if (newGrade.wasRecorded == false) {
                    newGrade.wasRecorded = true;
                  } else {
                    newGrade.wasRecorded = false;
                  }
                  await Provider.of<GradeDatabase>(
                    context,
                    listen: false,
                  ).updateGrade(studentId, newGrade);
                },
                icon: wasRecordedIcon(grade.wasRecorded),
              ),
            ],
          ),
        ),
      ),
      onTap: () => gradeDetailsDialog(context, grade, studentId),
    );
  }
}

Icon wasRecordedIcon(bool wasRecorded) {
  if (wasRecorded == true) {
    return Icon(Icons.done, color: Colors.green);
  } else {
    return Icon(Icons.close, color: Colors.red);
  }
}

Container returnGradeTypeOnCard(GradeType type) {
  switch (type) {
    case GradeType.test:
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 207, 14, 0),
            width: 3,
          ),
        ),
        child: Text(
          'T',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: const Color.fromARGB(255, 173, 12, 0),
          ),
        ),
      );
    case GradeType.quiz:
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 0, 151, 5),
            width: 3,
          ),
        ),
        child: Text(
          'K',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: const Color.fromARGB(255, 0, 116, 4),
          ),
        ),
      );
    case GradeType.activity:
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 0, 140, 255),
            width: 3,
          ),
        ),
        child: Text(
          'A',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: const Color.fromARGB(255, 0, 112, 204),
          ),
        ),
      );
    case GradeType.lesson:
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 0, 194, 201),
            width: 3,
          ),
        ),
        child: Text(
          'P',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: const Color.fromARGB(255, 0, 155, 160),
          ),
        ),
      );
    case GradeType.other:
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 96, 36, 199),
            width: 3,
          ),
        ),
        child: Text(
          'I',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: const Color.fromARGB(255, 75, 28, 156),
          ),
        ),
      );
  }
}

Future deletionConfirmationDialog(context, int studentId, String studentname) {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
          title: Text(
            'Usuwanie ucznia',
            style: errorBoldTextStyle(context).copyWith(fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Czy na pewno chcesz usunąć $studentname?',
                style: onSurfaceTextStyle(context).copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Anuluj',
                style: onSurfaceTextStyle(context).copyWith(fontSize: 18),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                await Provider.of<GradeDatabase>(
                  context,
                  listen: false,
                ).deleteAllStudentGrades(studentId);
                await Provider.of<StudentDatabase>(
                  context,
                  listen: false,
                ).deleteStudent(studentId);
                Navigator.pop(context);
              },
              label: Text(
                'Usuń',
                style: errorBoldTextStyle(context).copyWith(fontSize: 18),
              ),
              icon: Icon(
                Icons.delete_forever,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
  );
}
