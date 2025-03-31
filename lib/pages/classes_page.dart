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
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista klas"),
        titleTextStyle: onPrimaryTextStyle(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createClass(context, textController),
        child: Icon(Icons.add),
      ),
      //Consumer causes rebuild on every classDatabase entry change
      body: Consumer<ClassDatabase>(
        builder: (context, classDatabase, child) {
          //Read classes on every rebuild
          classDatabase.readClasses();
          return ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: classDatabase.classList.length,
            itemBuilder: (context, index) {
              //get every class iteration
              final classObj = classDatabase.classList[index];

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
                        : "Wychowawca: ${classObj.careTeacher}",
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
          );
        },
      ),
    );
  }
}

void createClass(BuildContext context, TextEditingController textController) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("Nazwij nową klasę:"),
          content: TextField(controller: textController),
          actions: [
            MaterialButton(
              child: const Text("Anuluj"),
              onPressed: () {
                Navigator.pop(context);
                textController.clear();
              },
            ),
            MaterialButton(
              child: Text("Utwórz", style: higherContentTextStyle(context)),
              onPressed: () {
                //Add class to database
                Provider.of<ClassDatabase>(
                  context,
                  listen: false,
                ).addClass(textController.text, '');
                Navigator.pop(context);
                textController.clear();
              },
            ),
          ],
        ),
  );
}
