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
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              surfaceTintColor:
                                  Theme.of(context).colorScheme.primary,
                              child: Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      student.name,
                                      style: higherContentTextStyle(
                                        context,
                                      ).copyWith(fontSize: 23),
                                    ),
                                    Text(
                                      student.lastName,
                                      style: higherContentTextStyle(
                                        context,
                                      ).copyWith(fontSize: 23),
                                    ),
                                    SizedBox(height: 100),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Numer telefonu"),
                                            Text(
                                              student.phoneNumber != ''
                                                  ? student.phoneNumber
                                                  : "Nie podano",
                                              style: higherContentTextStyle(
                                                context,
                                              ).copyWith(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text("Aktywność"),
                                            Text(
                                              student.points.isNotEmpty
                                                  ? "${student.points}"
                                                  : "Brak Aktywności",
                                              style: higherContentTextStyle(
                                                context,
                                              ).copyWith(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        //TO-DO ADD CLASS LISTING
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Informacje dodatkowe",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 50),
                            Text(
                              "Numer Telefonu Matki",
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              student.parentPhoneNumber != ''
                                  ? student.parentPhoneNumber
                                  : "Nie podano",
                              style: higherContentTextStyle(
                                context,
                              ).copyWith(fontSize: 13),
                            ),
                            SizedBox(height: 20),
                            Text("Numer telefonu ojca"),
                            Text(
                              student.parentPhoneNumber2 != ''
                                  ? student.parentPhoneNumber2
                                  : "Nie podano",
                              style: higherContentTextStyle(
                                context,
                              ).copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
              //Handle student being null by indicating a loading indicator and an error text appbar
              : Center(child: CircularProgressIndicator()),
    );
  }
}
