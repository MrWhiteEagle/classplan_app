import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:classplan_new/models/student.dart';

class StudentDatabase extends ChangeNotifier{
  static late Isar isar;
  //INITIALIZE
  static Future<void> initalize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      directory: dir.path,
      [StudentSchema],
      );
  }

  final List<Student> studentList = [];

  //CREATE
  Future<void> addStudent(String studentName, String lastName, Id classId) async{
    final newStudent = Student()
    ..name = studentName
    ..lastName = lastName
    ..classIds.add(classId);
    await isar.writeTxn(()=> isar.students.put(newStudent));
    readStudents();
  }

  //READ ALL STUDENTS
  Future<void> readStudents() async{
    List<Student> fetchedStudents = await isar.students.where().findAll();
    studentList.clear();
    studentList.addAll(fetchedStudents);
    notifyListeners();
  }

  //READ STUDENTS BY CLASSID
  Future<void> readStudentsByClassId(Id classId) async{
    List<Student> fetchedStudents = await isar.students.filter().classIdsElementEqualTo(classId).findAll();
    studentList.clear();
    studentList.addAll(fetchedStudents);
    notifyListeners();
  }

  //UPDATE STUDENT
  Future<void> updateStudent(Id studentId, String newName, String newLastName, String newPhoneNumber, String newParentPhoneNumber, String newParentPhoneNumber2) async{
    final existingStudent = await isar.students.get(studentId);
    if(existingStudent != null){
      existingStudent.name = newName;
      existingStudent.lastName = newLastName;
      existingStudent.phoneNumber = newPhoneNumber;
      existingStudent.parentPhoneNumber = newParentPhoneNumber;
      existingStudent.parentPhoneNumber2 = newParentPhoneNumber2;
      await isar.writeTxn(()=> isar.students.put(existingStudent));
    }
  }

  //DELETE STUDENT
  Future<void> deleteStudent(Id studentId) async{
    await isar.writeTxn(()=> isar.students.delete(studentId));
    readStudents();
  }
}