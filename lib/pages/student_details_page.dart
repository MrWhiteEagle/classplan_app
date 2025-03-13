import 'package:classplan_new/logic/crud_students.dart';
import 'package:classplan_new/models/student.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDetailsPage extends StatefulWidget {
  final int studentId;

  const StudentDetailsPage({super.key, required this.studentId});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  @override
  void initState() {
    super.initState();
    fetchStudentDetails(context, widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    final studentDatabase = context.watch<StudentDatabase>();
    final Student? student = studentDatabase.fetchedStudent;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          student != null
              ? 'Informacje o uczniu'
              //error - student is null appbar indicator
              : 'Błąd, Nie można załadować informacji',
          style: onPrimaryColorHeaderTextStyle(context),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body:
          student != null
              ? Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  surfaceTintColor: Theme.of(context).colorScheme.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: higherContentTextStyle(context),
                      ),
                      Text(
                        student.lastName,
                        style: higherContentTextStyle(context),
                      ),
                      SizedBox(height: 20),
                      Text("Aktywność"),
                      Text(
                        student.points.isNotEmpty
                            ? "${student.points}"
                            : "Brak Aktywności",
                        style: higherContentTextStyle(context),
                      ),
                      SizedBox(height: 50),
                      Text(
                        "Informacje dodatkowe",
                        style: higherContentTextStyle(context),
                      ),
                      Text(
                        student.phoneNumber == ''
                            ? 'Numer Kontaktowy:   Brak'
                            : 'Numer Kontaktowy:   ${student.phoneNumber}',
                      ),
                      Text(
                        student.parentPhoneNumber == ''
                            ? 'Numer Kontaktowy Matki:   Brak'
                            : 'Numer Kontaktowy Matki:   ${student.parentPhoneNumber}',
                      ),
                      Text(
                        student.parentPhoneNumber2 == ''
                            ? 'Numer Kontaktowy Ojca:   Brak'
                            : 'Numer Kontaktowy Ojca:   ${student.parentPhoneNumber}',
                      ),
                      //TO-DO ADD CLASS LISTING
                    ],
                  ),
                ),
              )
              //Handle student being null by indicating a loading indicator and an error text appbar
              : Center(child: CircularProgressIndicator()),
    );
  }
}
