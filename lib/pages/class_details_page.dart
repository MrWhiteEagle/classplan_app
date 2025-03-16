import 'package:classplan_new/logic/crud_classes.dart';
import 'package:classplan_new/logic/crud_students.dart';
import 'package:classplan_new/pages/student_details_page.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:classplan_new/models/student.dart';
import 'package:classplan_new/models/student_database.dart';

class ClassDetailsPage extends StatefulWidget {
  final String className;
  final int classId;
  final String careTeacher;

  const ClassDetailsPage({
    super.key,
    required this.className,
    required this.classId,
    required this.careTeacher,
  });

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {
  @override
  void initState() {
    super.initState();
    readStudentsFromClass(context, widget.classId);
  }

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final studentDatabase = context.watch<StudentDatabase>();
    List<Student> currentStudents = studentDatabase.studentList;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Informacje o klasie"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              createStudent(
                context,
                nameController,
                lastNameController,
                widget.classId,
              );
            },
          ),
          IconButton(
            onPressed: () {
              deleteClass(context, widget.classId);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Klasa ${widget.className}',
                  textAlign: TextAlign.center,
                  style: onPrimaryColorHeaderTextStyle(context),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Wychowawca", textAlign: TextAlign.left),
                        Text(
                          widget.careTeacher == ''
                              ? "Nie podano"
                              : widget.careTeacher,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Liczba uczniów"),
                        Text(currentStudents.length.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: currentStudents.length,
              itemBuilder: (context, index) {
                final student = currentStudents[index];
                return Card(
                  surfaceTintColor: Theme.of(context).colorScheme.primary,
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                      '${student.name} ${student.lastName}',
                      style: higherContentTextStyle(context),
                    ),
                    subtitle: Text(
                      student.points.isNotEmpty
                          ? 'Aktywność: ${student.points}'
                          : 'Brak aktywności',
                      textAlign: TextAlign.right,
                    ),
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return StudentDetailsPage(
                                studentId: student.studentId,
                              );
                            },
                          ),
                        ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
