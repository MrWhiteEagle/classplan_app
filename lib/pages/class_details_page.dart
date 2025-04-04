import 'package:classplan_new/pages/student_details_page.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/models/class_database.dart';

class ClassDetailsPage extends StatefulWidget {
  final int classId;

  const ClassDetailsPage({super.key, required this.classId});

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ClassDatabase>(
      context,
      listen: false,
    ).fetchClassDetails(widget.classId);
    Provider.of<StudentDatabase>(
      context,
      listen: false,
    ).readStudents(widget.classId);
  }

  GlobalKey sortButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 30),
        onPressed: () => addStudentDialog(context, widget.classId),
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
      body: Consumer<ClassDatabase>(
        builder: (context, classDatabase, child) {
          //fetching class is asynchronous and the body builds immediately, so the normal page waits, until the fetched class is not null
          if (classDatabase.fetchedClass == null) {
            return Center(child: CircularProgressIndicator());
          }
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
                      'Klasa ${classDatabase.fetchedClass?.name}',
                      textAlign: TextAlign.center,
                      style: onPrimaryBoldTextStyle(context),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextButton.icon(
                              label: Text(
                                "Wychowawca",
                                style: onPrimaryBoldContainerTextStyle(
                                  context,
                                ).copyWith(fontSize: 18),
                              ),
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              iconAlignment: IconAlignment.end,
                              onPressed: () => editCareTeacherDialog(context),
                            ),
                            Text(
                              classDatabase.fetchedClass!.careTeacher == ''
                                  ? "Nie podano"
                                  : classDatabase.fetchedClass!.careTeacher,
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
                            //one time consumer for accessing the fetched student list for class
                            Consumer<StudentDatabase>(
                              builder: (context, studentDatabase, child) {
                                return Text(
                                  studentDatabase.studentList.length.toString(),
                                  style: secondaryBoldContainerTextStyle(
                                    context,
                                  ).copyWith(fontSize: 15),
                                );
                              },
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
                //consumer for student list for class (everything here uses data from the db)
                child: Consumer<StudentDatabase>(
                  builder: (context, studentDatabase, child) {
                    debugPrint('Student List loaded!');
                    return ListView.builder(
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
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              title: Text(
                                '${studentDatabase.studentList[index].name} ${studentDatabase.studentList[index].lastName}',
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
                                        ? studentDatabase
                                            .studentList[index]
                                            .points
                                            .join(" ")
                                        : 'Brak Aktywności',
                                    style: primaryBoldTextStyle(
                                      context,
                                    ).copyWith(
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
                                  ).then(
                                    (_) => studentDatabase.readStudents(
                                      widget.classId,
                                    ),
                                  ),
                            ),
                          ),
                        );
                      },
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

deletionConfirmationStudent() {}
