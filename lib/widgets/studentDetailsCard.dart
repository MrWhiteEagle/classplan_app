import 'package:classplan_new/models/grade.dart';
import 'package:classplan_new/models/grade_database.dart';
import 'package:classplan_new/models/student.dart';
import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDetailsCard extends StatelessWidget {
  const StudentDetailsCard({
    super.key,
    required this.student,
    required this.phoneNumberController,
    required this.parentPhoneNumberController,
    required this.parent2PhoneNumberController,
    required this.nameController,
    required this.lastNameController,
  });

  final Student student;

  final TextEditingController phoneNumberController;
  final TextEditingController parentPhoneNumberController;
  final TextEditingController parent2PhoneNumberController;
  final TextEditingController nameController;
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    List<String> pointlist = List.from(student.points);
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 7,
      shadowColor: Theme.of(context).colorScheme.tertiaryContainer,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${student.name} ${student.lastName}',
                  style: onPrimaryBoldTextStyle(context).copyWith(fontSize: 30),
                ),
                SizedBox(width: 10),
                PopupMenuButton(
                  shadowColor: Theme.of(context).colorScheme.tertiaryContainer,
                  elevation: 2,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 0,
                          child: Text(
                            "Dane osobowe",
                            style: onPrimaryTextStyle(
                              context,
                            ).copyWith(fontSize: 20),
                          ),
                        ),
                        PopupMenuItem(
                          value: 1,
                          child: Text(
                            "Kontakt",
                            style: onPrimaryTextStyle(
                              context,
                            ).copyWith(fontSize: 20),
                          ),
                        ),
                      ],
                  onSelected: (value) {
                    value == 0
                        ? showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              icon: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: Text(
                                "Edytuj Dane Osobowe",
                                style: primaryBoldTextStyle(context),
                              ),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Imię"),
                                  TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: student.name,
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text("Nazwisko"),
                                  TextField(
                                    controller: lastNameController,
                                    decoration: InputDecoration(
                                      hintText: student.lastName,
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Anuluj"),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Provider.of<StudentDatabase>(
                                      context,
                                      listen: false,
                                    ).updateStudent(
                                      student.studentId,
                                      student.classIds,
                                      nameController.text,
                                      lastNameController.text,
                                      student.phoneNumber,
                                      student.parentPhoneNumber,
                                      student.parentPhoneNumber2,
                                      student.points,
                                    );
                                  },
                                  child: Text(
                                    "Zapisz",
                                    style: primaryBoldContainerTextStyle(
                                      context,
                                    ).copyWith(fontSize: 17),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                        : showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              icon: Icon(
                                Icons.phone,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              title: Text(
                                "Edytuj Kontakt",
                                style: primaryBoldTextStyle(context),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Numer Telefonu Ucznia"),
                                  TextField(
                                    controller: phoneNumberController,
                                    decoration: InputDecoration(
                                      hintText: student.phoneNumber,
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text("Numer Telefonu Matki"),
                                  TextField(
                                    controller: parentPhoneNumberController,
                                    decoration: InputDecoration(
                                      hintText: student.parentPhoneNumber,
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Text("Numer Telefonu Ojca"),
                                  TextField(
                                    controller: parent2PhoneNumberController,
                                    decoration: InputDecoration(
                                      hintText: student.parentPhoneNumber2,
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                MaterialButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Anuluj"),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Provider.of<StudentDatabase>(
                                      context,
                                      listen: false,
                                    ).updateStudent(
                                      student.studentId,
                                      student.classIds,
                                      student.name,
                                      student.lastName,
                                      phoneNumberController.text,
                                      parentPhoneNumberController.text,
                                      parent2PhoneNumberController.text,
                                      student.points,
                                    );
                                  },
                                  child: Text(
                                    "Zapisz",
                                    style: primaryBoldTextStyle(
                                      context,
                                    ).copyWith(fontSize: 17),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                  },
                ),
              ],
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Numer telefonu",
                      style: onPrimaryBoldContainerTextStyle(
                        context,
                      ).copyWith(fontSize: 18),
                    ),
                    Text(
                      student.phoneNumber != ''
                          ? student.phoneNumber
                          : "Nie podano",
                      style: onPrimaryContainerTextStyle(
                        context,
                      ).copyWith(fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton.icon(
                      label: Text(
                        "Aktywność",
                        style: onPrimaryBoldContainerTextStyle(
                          context,
                        ).copyWith(fontSize: 18),
                      ),
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      onPressed:
                          () => showActivityEditDialog(context, pointlist),
                    ),
                    Text(
                      student.points.isNotEmpty
                          ? student.points.join(" ")
                          : "Brak Aktywności",
                      style: onPrimaryContainerTextStyle(
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
    );
  }

  Future showActivityEditDialog(
    BuildContext context,
    List<String> pointlist,
  ) => showDialog(
    context: context,
    builder:
        (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              icon: Icon(
                Icons.add_circle_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                "Zmień aktywność",
                style: primaryBoldTextStyle(context),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        //WATCH FOR DEBBUGING hardcoded width might fuck up grid spacing on different resolutions (but might not)
                        width: 230,
                        height: 250,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 300),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: pointlist.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                ),
                            itemBuilder: (context, index) {
                              return GridTile(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    pointlist[index] == '+'
                                        ? Icons.add
                                        : Icons.remove,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            pointlist.add('-');
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                        ),
                        TextButton.icon(
                          label: Text(
                            "Wyczyść",
                            style: secondaryBoldTextStyle(
                              context,
                            ).copyWith(fontSize: 16),
                          ),
                          onPressed: () {
                            pointlist.clear();
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            pointlist.add('+');
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pointlist.clear();
                  },
                  child: Text("Anuluj"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    pointlist = activityGradeCheck(
                      context,
                      pointlist,
                      student.studentId,
                    );
                    Provider.of<StudentDatabase>(
                      context,
                      listen: false,
                    ).updateStudent(
                      student.studentId,
                      student.classIds,
                      student.name,
                      student.lastName,
                      student.phoneNumber,
                      student.parentPhoneNumber,
                      student.parentPhoneNumber2,
                      pointlist,
                    );
                  },
                  child: Text(
                    "Zapisz",
                    style: primaryBoldTextStyle(context).copyWith(fontSize: 17),
                  ),
                ),
              ],
            );
          },
        ),
  );
}

List<String> activityGradeCheck(context, List<String> pointlist, studentId) {
  //count of positive marks in list
  int positiveCount = 0;
  //list of positive indexes
  List<int> posIndex = [];
  //count and save positive indexes in list
  for (int i = 0; i < pointlist.length; i++) {
    if (pointlist[i] == '+') {
      positiveCount++;
      posIndex.add(i);
    }
  }
  //if positive count exceeds or is 5, count the grades to be added
  if (positiveCount >= 5) {
    int gradesToAdd = positiveCount ~/ 5;
    int toDelete = gradesToAdd * 5;
    //reverse the list to delete backwards, so the indexes dont switch mid-deletion
    posIndex.sort((a, b) => b.compareTo(a));
    for (int i = 0; i < toDelete; i++) {
      pointlist.removeAt(posIndex[i]);
    }
    debugPrint('Grades to add: $gradesToAdd, new pointlist: $pointlist');
    for (int i = 0; i < gradesToAdd; i++) {
      Provider.of<GradeDatabase>(
        context,
        listen: false,
      ).createGrade(studentId, 'Plusy', GradeType.activity, '5', '');
    }
  } else {
    debugPrint('No grades to add');
  }
  return pointlist;
}
