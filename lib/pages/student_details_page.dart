import 'package:classplan_new/logic/crud_students.dart';
import 'package:classplan_new/models/student.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/studentDetailsCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDetailsPage extends StatefulWidget {
  final int studentId;

  const StudentDetailsPage({super.key, required this.studentId});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final parentPhoneNumberController = TextEditingController();
  final parent2PhoneNumberController = TextEditingController();

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
                            StudentDetailsCard(
                              student: student,
                              nameController: nameController,
                              lastNameController: lastNameController,
                              phoneNumberController: phoneNumberController,
                              parentPhoneNumberController:
                                  parentPhoneNumberController,
                              parent2PhoneNumberController:
                                  parent2PhoneNumberController,
                            ),
                            const SizedBox(height: 30),
                            const Text(
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
                            const SizedBox(height: 50),
                            const Text(
                              "Oceny",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Flexible(
                              child: ListView.builder(
                                padding: EdgeInsets.all(10),
                                itemCount: student.gradesIdentifiers.length,
                                itemBuilder: (context, index) {
                                  final gradeIds = student.gradesIdentifiers;
                                  final grades = student.grades;

                                  return Card(
                                    elevation: 5,
                                    child: Column(
                                      children: [
                                        Text(gradeIds[index]),
                                        Text(grades[index]),
                                      ],
                                    ),
                                  );
                                },
                              ),
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
