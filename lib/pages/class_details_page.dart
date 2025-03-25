import 'package:classplan_new/pages/student_details_page.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/models/class_database.dart';

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
  }

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Informacje o klasie id: ${widget.classId}"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              addStudentDialog(
                context,
                nameController,
                lastNameController,
                widget.classId,
              );
            },
          ),
          IconButton(
            onPressed: () {
              Provider.of<StudentDatabase>(
                context,
                listen: false,
              ).deleteClassFromAllStudents(widget.classId);
              Provider.of<ClassDatabase>(
                context,
                listen: false,
              ).deleteClass(widget.classId);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Consumer<StudentDatabase>(
        builder: (context, studentDatabase, child) {
          studentDatabase.readStudents(widget.classId);
          return Column(
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
                            Text(studentDatabase.studentList.length.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: studentDatabase.studentList.length,
                  itemBuilder: (context, index) {
                    final student = studentDatabase.studentList[index];
                    return Card(
                      surfaceTintColor: Theme.of(context).colorScheme.primary,
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          '${student.name} ${student.lastName}',
                          style: higherContentTextStyle(context),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Aktywność: '),
                            Text(
                              student.points.isNotEmpty
                                  ? student.points.join(" ")
                                  : 'Brak Aktywności',
                              style: higherContentTextStyle(context).copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
          );
        },
      ),
    );
  }
}

//dialog for adding a new student
void addStudentDialog(
  BuildContext context,
  TextEditingController nameController,
  TextEditingController lastNameController,
  int classId,
) {
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
              child: const Text("Anuluj"),
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
              child: Text("Dodaj", style: higherContentTextStyle(context)),
            ),
          ],
        ),
  );
}
