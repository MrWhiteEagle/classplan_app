import 'package:classplan_new/logic/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:classplan_new/models/student.dart';

class StudentDatabase extends ChangeNotifier{
  final IsarService isarService = IsarService();

  final List<Student> studentList = [];

  //CREATE
  Future<void> addStudent(String studentName, String lastName, Id classId) async{
    final newStudent = Student()
    ..name = studentName
    ..lastName = lastName
    ..classIds.add(classId);
    await isarService.isar.writeTxn(()=> isarService.isar.students.put(newStudent));
    readStudents();
  }

  //READ ALL STUDENTS
  Future<void> readStudents() async{
    List<Student> fetchedStudents = await isarService.isar.students.where().findAll();
    studentList.clear();
    studentList.addAll(fetchedStudents);
    notifyListeners();
  }

  //READ STUDENTS BY CLASSID
  Future<void> readStudentsByClassId(Id classId) async{
    List<Student> fetchedStudents = await isarService.isar.students.filter().classIdsElementEqualTo(classId).findAll();
    studentList.clear();
    studentList.addAll(fetchedStudents);
    notifyListeners();
  }

  //UPDATE STUDENT
  Future<void> updateStudent(Id studentId, String newName, String newLastName, String newPhoneNumber, String newParentPhoneNumber, String newParentPhoneNumber2) async{
    final existingStudent = await isarService.isar.students.get(studentId);
    if(existingStudent != null){
      existingStudent.name = newName;
      existingStudent.lastName = newLastName;
      existingStudent.phoneNumber = newPhoneNumber;
      existingStudent.parentPhoneNumber = newParentPhoneNumber;
      existingStudent.parentPhoneNumber2 = newParentPhoneNumber2;
      await isarService.isar.writeTxn(()=> isarService.isar.students.put(existingStudent));
    }
  }

  //DELETE STUDENT
  Future<void> deleteStudent(Id studentId) async{
    await isarService.isar.writeTxn(()=> isarService.isar.students.delete(studentId));
    readStudents();
  }
}