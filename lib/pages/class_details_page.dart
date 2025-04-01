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
    Provider.of<StudentDatabase>(
      context,
      listen: false,
    ).readStudents(widget.classId);
  }

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  GlobalKey sortButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 30),
        onPressed:
            () => addStudentDialog(
              context,
              nameController,
              lastNameController,
              widget.classId,
            ),
      ),
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: false,
        title: Text(
          "Informacje o klasie",
          style: onPrimaryBoldTextStyle(context),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.onPrimary,
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
          TextButton.icon(
            key: sortButtonKey,
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (sortButtonKey.currentContext != null) {
                  final RenderBox buttonRender =
                      sortButtonKey.currentContext!.findRenderObject()
                          as RenderBox;
                  final Offset offset = buttonRender.localToGlobal(Offset.zero);

                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      offset.dx,
                      offset.dy + buttonRender.size.height,
                      offset.dx + buttonRender.size.width,
                      offset.dy + buttonRender.size.height * 2,
                    ),
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    items: [
                      PopupMenuItem(
                        child: Text(
                          'Domyślne',
                          style: primaryTextStyle(
                            context,
                          ).copyWith(fontSize: 15),
                        ),
                        onTap:
                            () => Provider.of<StudentDatabase>(
                              context,
                              listen: false,
                            ).readStudents(widget.classId),
                      ),
                      PopupMenuItem(
                        child: Text(
                          'Po imieniu',
                          style: primaryTextStyle(
                            context,
                          ).copyWith(fontSize: 15),
                        ),
                        onTap:
                            () =>
                                Provider.of<StudentDatabase>(
                                  context,
                                  listen: false,
                                ).sortStudentsAlpha(),
                      ),
                      PopupMenuItem(
                        child: Text(
                          'Po nazwisku',
                          style: primaryTextStyle(
                            context,
                          ).copyWith(fontSize: 15),
                        ),
                        onTap:
                            () =>
                                Provider.of<StudentDatabase>(
                                  context,
                                  listen: false,
                                ).sortStudentsLastNameAlpha(),
                      ),
                    ],
                  );
                } else {
                  debugPrint('Button not laid out');
                }
              });
            },
            label: Text(
              'Sortuj',
              style: onPrimaryTextStyle(context).copyWith(fontSize: 15),
            ),
            icon: Icon(
              Icons.sort,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: Consumer<StudentDatabase>(
        builder: (context, studentDatabase, child) {
          debugPrint('Student List loaded!');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Klasa ${widget.className}',
                      textAlign: TextAlign.center,
                      style: onPrimaryBoldTextStyle(context),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Wychowawca",
                              textAlign: TextAlign.left,
                              style: onPrimaryBoldContainerTextStyle(
                                context,
                              ).copyWith(fontSize: 18),
                            ),
                            Text(
                              widget.careTeacher == ''
                                  ? "Nie podano"
                                  : widget.careTeacher,
                              textAlign: TextAlign.left,
                              style: onPrimaryBoldContainerTextStyle(
                                context,
                              ).copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Liczba uczniów",
                              style: onPrimaryBoldContainerTextStyle(
                                context,
                              ).copyWith(fontSize: 18),
                            ),
                            Text(
                              studentDatabase.studentList.length.toString(),
                              style: secondaryBoldContainerTextStyle(
                                context,
                              ).copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Lista uczniów',
                    textAlign: TextAlign.center,
                    style: onPrimaryBoldTextStyle(context),
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: studentDatabase.studentList.length,
                  itemBuilder: (context, index) {
                    final student = studentDatabase.studentList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          title: Text(
                            '${student.name} ${student.lastName}',
                            style: higherContentTextStyle(context),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Aktywność: ',
                                style: primaryBoldTextStyle(
                                  context,
                                ).copyWith(fontSize: 15),
                              ),
                              Text(
                                student.points.isNotEmpty
                                    ? student.points.join(" ")
                                    : 'Brak Aktywności',
                                style: primaryBoldTextStyle(context).copyWith(
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

deletionConfirmationStudent() {}
