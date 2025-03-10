import 'package:classplan_new/themes/app_theme.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
      ),
      body: ListView(
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
          )
        ],
      ),
    );
  }
}