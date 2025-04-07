import 'package:classplan_new/models/grade.dart';
import 'package:classplan_new/models/grade_database.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/createGrade.dart';
import 'package:classplan_new/widgets/gradeDetails.dart';
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
  //global key for finding the sort button for custom menu
  GlobalKey sortButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    //initial fetch student details for the page
    Provider.of<StudentDatabase>(
      context,
      listen: false,
    ).fetchStudentDetails(widget.studentId);

    //initial fetch of student grades for the page
    Provider.of<GradeDatabase>(
      context,
      listen: false,
    ).readStudentGrades(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    //everything on this page uses the student database
    return Consumer<StudentDatabase>(
      builder: (context, studentDatabase, child) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
            title: Text(
              studentDatabase.fetchedStudent != null
                  ? 'Informacje o uczniu'
                  //error - student is null appbar indicator
                  : 'Błąd, Nie można załadować informacji',
              style: onPrimaryBoldTextStyle(context),
            ),
            actions: [
              IconButton(
                onPressed:
                    () => deletionConfirmationDialog(
                      context,
                      studentDatabase.fetchedStudent!.studentId,
                      '${studentDatabase.fetchedStudent!.name} ${studentDatabase.fetchedStudent!.lastName}',
                    ),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              TextButton.icon(
                key: sortButtonKey,
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (sortButtonKey.currentContext != null) {
                      final RenderBox buttonRender =
                          sortButtonKey.currentContext!.findRenderObject()
                              as RenderBox;
                      final Offset offset = buttonRender.localToGlobal(
                        Offset.zero,
                      );

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
                                () => Provider.of<GradeDatabase>(
                                  context,
                                  listen: false,
                                ).readStudentGrades(widget.studentId),
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Po Nazwie',
                              style: primaryTextStyle(
                                context,
                              ).copyWith(fontSize: 15),
                            ),
                            onTap:
                                () =>
                                    Provider.of<GradeDatabase>(
                                      context,
                                      listen: false,
                                    ).sortGradesByTitle(),
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Po Typie',
                              style: primaryTextStyle(
                                context,
                              ).copyWith(fontSize: 15),
                            ),
                            onTap:
                                () =>
                                    Provider.of<GradeDatabase>(
                                      context,
                                      listen: false,
                                    ).sortGradesByType(),
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
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body:
              //check for null student
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
                                  //pass along the student object
                                  student: studentDatabase.fetchedStudent!,
                                ),
                                const SizedBox(height: 30),
                                Text(
                                  "Informacje dodatkowe",
                                  textAlign: TextAlign.center,
                                  style: primaryBoldTextStyle(
                                    context,
                                  ).copyWith(fontSize: 22),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Numer Telefonu Matki",
                                  style: onSurfaceTextStyle(context),
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
                                  style: secondaryBoldContainerTextStyle(
                                    context,
                                  ).copyWith(fontSize: 13),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Numer telefonu ojca",
                                  style: onSurfaceTextStyle(context),
                                ),
                                Text(
                                  studentDatabase
                                              .fetchedStudent!
                                              .parentPhoneNumber2 !=
                                          ''
                                      ? studentDatabase
                                          .fetchedStudent!
                                          .parentPhoneNumber2
                                      : "Nie podano",
                                  style: secondaryBoldContainerTextStyle(
                                    context,
                                  ).copyWith(fontSize: 13),
                                ),
                                const SizedBox(height: 50),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.tertiaryContainer,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadowColor:
                                      Theme.of(context).colorScheme.tertiary,
                                  elevation: 7,
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Oceny",
                                        textAlign: TextAlign.left,
                                        style: onPrimaryBoldContainerTextStyle(
                                          context,
                                        ).copyWith(fontSize: 18),
                                      ),
                                      TextButton.icon(
                                        onPressed:
                                            () => createGradeAlert(
                                              context,
                                              studentDatabase.fetchedStudent!,
                                            ),
                                        label: Text(
                                          "Dodaj",
                                          style:
                                              onPrimaryBoldContainerTextStyle(
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
                                      ),
                                    ],
                                  ),
                                ),
                                Consumer<GradeDatabase>(
                                  builder: (context, studentDatabase, child) {
                                    return Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            studentDatabase
                                                .fetchedGradeList
                                                .length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            child: Card(
                                              surfaceTintColor:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      studentDatabase
                                                              .fetchedGradeList[index]
                                                              .grade +
                                                          studentDatabase
                                                              .fetchedGradeList[index]
                                                              .gradeAdd,
                                                      style:
                                                          primaryBoldTextStyle(
                                                            context,
                                                          ),
                                                    ),
                                                    Text(
                                                      studentDatabase
                                                          .fetchedGradeList[index]
                                                          .title,
                                                      style: secondaryTextStyle(
                                                        context,
                                                      ),
                                                    ),
                                                    returnGradeTypeOnCard(
                                                      studentDatabase
                                                          .fetchedGradeList[index]
                                                          .type,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap:
                                                () => gradeDetailsDialog(
                                                  context,
                                                  studentDatabase
                                                      .fetchedGradeList[index],
                                                  widget.studentId,
                                                ),
                                          );
                                        },
                                      ),
                                    );
                                  },
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

String fetchedGradeTypeToString(GradeType type) {
  switch (type) {
    case GradeType.test:
      return 'Test';
    case GradeType.quiz:
      return 'Kartkówka';
    case GradeType.activity:
      return 'Aktywność';
    case GradeType.lesson:
      return 'P.N.L';
    case GradeType.other:
      return 'Inne';
  }
}

Text returnGradeTypeOnCard(GradeType type) {
  switch (type) {
    case GradeType.test:
      return Text(
        'T',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.red,
        ),
      );
    case GradeType.quiz:
      return Text(
        'K',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.green,
        ),
      );
    case GradeType.activity:
      return Text(
        'A',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.blue,
        ),
      );
    case GradeType.lesson:
      return Text(
        'P.N.L.',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.lightBlue,
        ),
      );
    case GradeType.other:
      return Text(
        'I',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.deepPurple,
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
