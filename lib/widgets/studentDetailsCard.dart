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
      surfaceTintColor: Theme.of(context).colorScheme.primary,
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
                  style: higherContentTextStyle(context).copyWith(fontSize: 23),
                ),
                SizedBox(width: 10),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(value: 0, child: Text("Dane osobowe")),
                        PopupMenuItem(value: 1, child: Text("Kontakt")),
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
                              title: Text("Edytuj Dane Osobowe"),
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
                                    style: higherContentTextStyle(context),
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
                              title: Text("Edytuj Kontakt"),
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
                                    style: higherContentTextStyle(context),
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
                    Text("Numer telefonu"),
                    Text(
                      student.phoneNumber != ''
                          ? student.phoneNumber
                          : "Nie podano",
                      style: higherContentTextStyle(
                        context,
                      ).copyWith(fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton.icon(
                      label: Text("Aktywność"),
                      icon: Icon(Icons.add_circle_outline),
                      onPressed:
                          () => showActivityEditDialog(context, pointlist),
                    ),
                    Text(
                      student.points.isNotEmpty
                          ? student.points.join(" ")
                          : "Brak Aktywności",
                      style: higherContentTextStyle(
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
              title: Text("Zmień aktywność"),
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
                            pointlist.add('+');
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        TextButton.icon(
                          label: Text("Wyczyść"),
                          onPressed: () {
                            pointlist.clear();
                            setState(() {});
                          },
                          icon: Icon(Icons.clear),
                        ),
                        IconButton(
                          onPressed: () {
                            pointlist.add('-');
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: Theme.of(context).colorScheme.primary,
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
                    style: higherContentTextStyle(
                      context,
                    ).copyWith(fontSize: 14),
                  ),
                ),
              ],
            );
          },
        ),
  );
}
