import 'package:classplan_new/models/student.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';

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
                                  onPressed: () => Navigator.pop(context),
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
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Zapisz"),
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
                    Text("Aktywność"),
                    Text(
                      student.points.isNotEmpty
                          ? "${student.points}"
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
}
