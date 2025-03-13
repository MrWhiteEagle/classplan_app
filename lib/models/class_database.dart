import 'package:classplan_new/logic/isar_service.dart';
import 'package:classplan_new/models/class.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class ClassDatabase extends ChangeNotifier {
  final IsarService isarService = IsarService();

  //List of classes
  final List<ClassObj> classList = [];

  //CREATE
  Future<void> addClass(String className) async {
    //create a new class
    final newClass = ClassObj()..name = className;

    //save to db
    await isarService.isar.writeTxn(
      () => isarService.isar.classObjs.put(newClass),
    );

    //re-read from db
    readClasses();
  }

  //READ ALL CLASSES
  Future<void> readClasses() async {
    List<ClassObj> fetchedClasses =
        await isarService.isar.classObjs.where().findAll();
    classList.clear();
    classList.addAll(fetchedClasses);
    notifyListeners();
  }

  //UPDATE

  Future<void> updateClass(int id, String newName) async {
    //get content of existing class
    final existingClass = await isarService.isar.classObjs.get(id);

    //if a class is not null, change its content to the new one, and save it in the db.
    if (existingClass != null) {
      existingClass.name = newName;
      await isarService.isar.writeTxn(
        () => isarService.isar.classObjs.put(existingClass),
      );
    }
  }

  //DELETE
  Future<void> deleteClass(int id) async {
    await isarService.isar.writeTxn(
      () => isarService.isar.classObjs.delete(id),
    );
    await readClasses();
  }

  //ADD STUDENT
  Future<void> addStudent(int id, int studentId) async {
    final existingClass = await isarService.isar.classObjs.get(id);
    if (existingClass != null) {
      existingClass.students.add(studentId);
      await isarService.isar.writeTxn(
        () => isarService.isar.classObjs.put(existingClass),
      );
      notifyListeners();
    }
  }
}
