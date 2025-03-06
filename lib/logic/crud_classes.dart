import 'package:classplan_new/models/class_database.dart';
import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Create class button function
void createClass(BuildContext context, TextEditingController textController){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Nazwij nową klasę:"),
        content: TextField(
          controller: textController,
        ),
        actions: [
          
          MaterialButton(
            child: const Text("Anuluj"),
            onPressed: () => Navigator.pop(context),
          ),
          MaterialButton(
            child: Text("Utwórz", style: higherContentTextStyle(context)),
            onPressed: () {
              //Add class to database
              context.read<ClassDatabase>().addClass(textController.text);
              Navigator.pop(context);
            }),

        ],
      ));
  }

void readClasses(BuildContext context){
  context.read<ClassDatabase>().readClasses();

}