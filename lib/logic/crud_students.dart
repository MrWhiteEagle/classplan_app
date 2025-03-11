import 'package:classplan_new/models/student_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Create student button method
void createStudent(BuildContext context, TextEditingController nameController, TextEditingController lastNameController, int classId){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Dodaj ucznia"),
        content: Column(
          children: [
            Text("Imię:", style: higherContentTextStyle(context),),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Imię ucznia",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height:15,),
            Text("Nazwisko:", style: higherContentTextStyle(context),),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                hintText: "Nazwisko ucznia",
                border: OutlineInputBorder(),
              ),
            ),
          ]
        ),
        actions: [
          MaterialButton(
            onPressed: (){
              Navigator.pop(context);
              nameController.clear();
              lastNameController.clear();
            },
            child: const Text("Anuluj"),),
          MaterialButton(
            onPressed: (){
              context.read<StudentDatabase>().addStudent(nameController.text, lastNameController.text, classId);
              Navigator.pop(context);
              nameController.clear();
              lastNameController.clear();
            },
            child: Text("Dodaj", style: higherContentTextStyle(context),),),
        ],),
      );
}

//Read students from class method
void readStudentsFromClass(BuildContext context, int classId){
  context.read<StudentDatabase>().readStudentsByClassId(classId);
}

//Read all students from database method
void readAllStudents(BuildContext context){
  context.read<StudentDatabase>().readStudents();
}

//Delete student method
void deleteStudent(BuildContext context, int studentId){
  context.read<StudentDatabase>().deleteStudent(studentId);
}
