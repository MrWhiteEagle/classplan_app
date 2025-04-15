import 'package:classplan_new/pages/student_details_page.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/alerts/classDetailsDialog.dart';
import 'package:classplan_new/widgets/appBars/class_details_page_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:classplan_new/logic/db/student_database.dart';
import 'package:classplan_new/logic/db/class_database.dart';

class ClassDetailsPage extends StatefulWidget {
  const ClassDetailsPage({super.key, required this.classId});
  final int classId;

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {
  @override
  void initState() {
    super.initState();
    //clear last fetched class and fetch this one
    Provider.of<ClassDatabase>(context, listen: false).fetchedClass = null;
    Provider.of<ClassDatabase>(
      context,
      listen: false,
    ).fetchClassDetails(widget.classId);
    //clear list of previous students and fetch this one
    Provider.of<StudentDatabase>(context, listen: false).studentList.clear();
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
        child: Icon(
          Icons.add,
          size: 30,
          color: Theme.of(context).colorScheme.tertiaryContainer,
        ),
        onPressed: () => addStudentDialog(context, widget.classId),
      ),
      appBar: ClassDetailsPageAppBar(
        classId: widget.classId,
        sortButtonKey: sortButtonKey,
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
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
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
                                  style: tertiaryBoldContainerTextStyle(
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
                                '[${studentDatabase.studentList[index].internalId}] ${studentDatabase.studentList[index].name} ${studentDatabase.studentList[index].lastName}',
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
                                  ).then((_) {
                                    debugPrint('CLASS ID IS ${widget.classId}');
                                    studentDatabase.studentList.clear();
                                    studentDatabase.readStudents(
                                      widget.classId,
                                    );
                                  }),
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
