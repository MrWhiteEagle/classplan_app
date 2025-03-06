import 'package:classplan_new/models/class.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ClassDatabase extends ChangeNotifier{
  static late Isar isar;
  //INITIALIZE
  static Future<void> initalize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      //db items schema
      [ClassObjSchema],
      //directory (default documents directory)
      directory: dir.path
      );
  }

  //List of classes
  final List<ClassObj> classList = [];


  //CREATE
  Future<void> addClass(String className) async{
    //create a new class
    final newClass = ClassObj()..name = className;

    //save to db
    await isar.writeTxn(() => isar.classObjs.put(newClass));

    //re-read from db
    readClasses();
  }


  //READ
  Future<void> readClasses() async{
    List<ClassObj> fetchedClasses = await isar.classObjs.where().findAll();
    classList.clear();
    classList.addAll(fetchedClasses);
    notifyListeners();

  }


  //UPDATE

  Future<void> updateClass(int id, String newName) async {
    //get content of existing class
    final existingClass = await isar.classObjs.get(id);

    //if a class is not null, change its content to the new one, and save it in the db.
    if(existingClass != null){
      existingClass.name = newName;
      await isar.writeTxn(()=> isar.classObjs.put(existingClass));
    }
  }

  //DELETE
  Future<void> deleteClass (int id) async{
    await isar.writeTxn(()=> isar.classObjs.delete(id));
    await readClasses();
  }
}
