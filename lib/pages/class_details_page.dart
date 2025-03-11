import 'package:classplan_new/logic/crud_classes.dart';
import 'package:classplan_new/logic/crud_students.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:classplan_new/models/student.dart';
import 'package:classplan_new/models/student_database.dart';

class ClassDetailsPage extends StatefulWidget {
  final String className;
  final int classId;

  const ClassDetailsPage({
    super.key,
    required this.className,
    required this.classId,
    });

  @override
  State<ClassDetailsPage> createState() => _ClassDetailsPageState();
}

class _ClassDetailsPageState extends State<ClassDetailsPage> {

  @override
  void initState() {
    super.initState();
    readStudentsFromClass(context, widget.classId);
  }
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final studentDatabase = context.watch<StudentDatabase>();
    List<Student> currentStudents = studentDatabase.studentList;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              createStudent(context, nameController, lastNameController, widget.classId);
            },
          ),
          IconButton(
            onPressed: ()=>deleteClass(context, widget.classId),
            icon: Icon(Icons.delete),)
        ],
        centerTitle: false,
        title: Text(widget.className),

      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Text(
                  'Klasa ${widget.className}',
                  style: onPrimaryColorHeaderTextStyle(context),
                ),
              ],),
          ),
          ListView.builder(
            itemCount: currentStudents.length,
            itemBuilder: (context, index){
              final student = currentStudents[index];
              return Card(
                child: ListTile(
                  title: Text('${student.name} ${student.lastName}'),
                  subtitle: Text('Numer telefonu: ${student.phoneNumber}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      deleteStudent(context, student.studentId);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}