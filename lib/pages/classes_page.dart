import 'package:classplan_new/logic/crud_classes.dart';
import 'package:classplan_new/models/class.dart';
import 'package:classplan_new/models/class_database.dart';
import 'package:classplan_new/pages/class_details_page.dart';
// ignore: unused_import
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  @override
  void initState() {
    super.initState();
    //on page load read existing classes
    readClasses(context);
  }

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final classesDatabase = context.watch<ClassDatabase>();
    List<ClassObj> currentClasses = classesDatabase.classList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista klas"),
        titleTextStyle: onPrimaryColorHeaderTextStyle(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createClass(context, textController),
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: currentClasses.length,
        itemBuilder: (context, index) {
          //get every class
          final classObj = currentClasses[index];

          //return every class as a card
          return Card(
            elevation: 5,
            surfaceTintColor: Theme.of(context).colorScheme.primary,
            child: ListTile(
              title: Text(
                classObj.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                classObj.careTeacher == ''
                    ? "Wychowawca: Nie podano"
                    : "Wychowawca: $classObj",
              ),
              trailing: Icon(Icons.groups),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ClassDetailsPage(
                            className: classObj.name,
                            classId: classObj.id,
                            careTeacher: classObj.careTeacher,
                          ),
                    ),
                  ),
            ),
          );
        },
      ),
    );
  }
}
