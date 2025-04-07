import 'package:classplan_new/models/grade_database.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/alerts/createGrade.dart';
import 'package:classplan_new/widgets/appBars/student_details_page_appbar.dart';
import 'package:classplan_new/widgets/studentDetailsCard.dart';
import 'package:classplan_new/widgets/student_grade_tile.dart';
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
          appBar: StudentDetailsPageAppBar(
            sortButtonKey: sortButtonKey,
            student: studentDatabase.fetchedStudent,
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
                                          return StudentGradeTile(
                                            studentId: widget.studentId,
                                            grade:
                                                studentDatabase
                                                    .fetchedGradeList[index],
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
