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
    Provider.of<StudentDatabase>(
      context,
      listen: false,
    ).fetchStudentDetails(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentDatabase>(
      builder: (context, studentDatabase, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              studentDatabase.fetchedStudent != null
                  ? 'Informacje o uczniu'
                  //error - student is null appbar indicator
                  : 'Błąd, Nie można załadować informacji',
              style: onPrimaryColorHeaderTextStyle(context),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body:
              studentDatabase.fetchedStudent != null
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
                                  student: studentDatabase.fetchedStudent!,
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
                                  studentDatabase
                                              .fetchedStudent!
                                              .parentPhoneNumber !=
                                          ''
                                      ? studentDatabase
                                          .fetchedStudent!
                                          .parentPhoneNumber
                                      : "Nie podano",
                                  style: higherContentTextStyle(
                                    context,
                                  ).copyWith(fontSize: 13),
                                ),
                                SizedBox(height: 20),
                                Text("Numer telefonu ojca"),
                                Text(
                                  studentDatabase
                                              .fetchedStudent!
                                              .parentPhoneNumber2 !=
                                          ''
                                      ? studentDatabase
                                          .fetchedStudent!
                                          .parentPhoneNumber2
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
                                    itemCount:
                                        studentDatabase
                                            .fetchedStudent!
                                            .gradesIdentifiers
                                            .length,
                                    itemBuilder: (context, index) {
                                      final gradeIds =
                                          studentDatabase
                                              .fetchedStudent!
                                              .gradesIdentifiers;
                                      final grades =
                                          studentDatabase
                                              .fetchedStudent!
                                              .grades;

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
      },
    );
  }
}
