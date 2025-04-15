import 'package:classplan_new/logic/isar_service.dart';
import 'package:classplan_new/models/class.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class ClassDatabase extends ChangeNotifier {
  final IsarService isarService = IsarService();

  //List of classes
  final List<ClassObj> classList = [];

  ClassObj? fetchedClass;

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

  //SORT CLASS LIST ALPHABETICALLY
  void sortClassesAlpha() {
    classList.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void sortClassesRevAlpha() {
    sortClassesAlpha();
    List<ClassObj> sorted = classList.reversed.toList();
    classList.clear();
    classList.addAll(sorted);
    notifyListeners();
  }

  Future<void> fetchClassDetails(Id classId) async {
    final classDetails = await isarService.isar.classObjs.get(classId);
    debugPrint('fetched class $classDetails');
    if (classDetails != null) {
      debugPrint('fetched class name: ${classDetails.name}');
      fetchedClass = classDetails;
    } else {
      debugPrint('class fetch failed!!!!!!!!!');
    }
    notifyListeners();
  }

  //UPDATE
  Future<void> updateClass(ClassObj newClass) async {
    //?Implement spellchecking careteacher
    await isarService.isar.writeTxn(
      () => isarService.isar.classObjs.put(newClass),
    );
    notifyListeners();
  }

  //DELETE
  Future<void> deleteClass(int id) async {
    await isarService.isar.writeTxn(
      () => isarService.isar.classObjs.delete(id),
    );
    await readClasses();
  }

  //RESET CLASS DATABASE
  Future<void> resetClassDatabase() async {
    fetchedClass = null;
    classList.clear();
    await isarService.isar.writeTxn(() => isarService.isar.classObjs.clear());
    notifyListeners();
  }
}
