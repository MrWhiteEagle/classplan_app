import 'package:classplan_new/logic/crud_classes.dart';
import 'package:classplan_new/models/class.dart';
import 'package:classplan_new/models/class_database.dart';
import 'package:classplan_new/pages/class_details_page.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:classplan_new/widgets/appBar.dart';
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
      appBar: UniversalAppBar(title: "Klasy"),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>createClass(context, textController),
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
          surfaceTintColor: Theme.of(context).colorScheme.secondary,
          shadowColor: Theme.of(context).colorScheme.primary,
          child: ListTile(
            title: Text(classObj.name),
            trailing: IconButton(
              icon: Icon(Icons.edit_note),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ClassDetailsPage(className: classObj.name, classId: classObj.id,))),
              ),
          ),
        );
        
      })
    );
  }


}