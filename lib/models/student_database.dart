import 'package:classplan_new/logic/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:classplan_new/models/student.dart';

class StudentDatabase extends ChangeNotifier {
  final IsarService isarService = IsarService();

  final List<Student> studentList = [];
  Student? fetchedStudent;

  //CREATE
  Future<void> addStudent(
    String studentName,
    String lastName,
    Id classId,
  ) async {
    final newStudent =
        Student()
          ..name = studentName
          ..lastName = lastName
          ..classIds.add(classId);
    await isarService.isar.writeTxn(
      () => isarService.isar.students.put(newStudent),
    );
    readStudents(classId);
  }

  //READ STUDENTS BY CLASSID OR ALL
  Future<void> readStudents(Id? classId) async {
    if (classId == null) {
      //if no classID specified, fetches all studcents
      List<Student> fetchedStudents =
          await isarService.isar.students.where().findAll();
      studentList.clear();
      studentList.addAll(fetchedStudents);
      notifyListeners();
    } else {
      //classID specified, fetched students from that class
      List<Student> fetchedStudents =
          await isarService.isar.students
              .filter()
              .classIdsElementEqualTo(classId)
              .findAll();
      studentList.clear();
      studentList.addAll(fetchedStudents);
      notifyListeners();
    }
  }

  //FETCH STUDENT DETAILS BY ID
  Future<void> fetchStudentDetails(Id studentId) async {
    final studentDetails = await isarService.isar.students.get(studentId);
    if (studentDetails != null) {
      fetchedStudent = studentDetails;
      notifyListeners();
    }
  }

  //UPDATE STUDENT
  Future<void> updateStudent(
    Id studentId,
    String newName,
    String newLastName,
    String newPhoneNumber,
    String newParentPhoneNumber,
    String newParentPhoneNumber2,
    List<String> newpointList,
    List<String> newGrades,
    List<String> newGradesIdentifiers,
  ) async {
    final existingStudent = await isarService.isar.students.get(studentId);
    if (existingStudent != null) {
      existingStudent.name = newName;
      existingStudent.lastName = newLastName;
      existingStudent.phoneNumber = newPhoneNumber;
      existingStudent.parentPhoneNumber = newParentPhoneNumber;
      existingStudent.parentPhoneNumber2 = newParentPhoneNumber2;
      existingStudent.points = newpointList;
      existingStudent.grades = newGrades;
      existingStudent.gradesIdentifiers = newGradesIdentifiers;
      await isarService.isar.writeTxn(
        () => isarService.isar.students.put(existingStudent),
      );
      notifyListeners();
      fetchStudentDetails(studentId);
    }
  }

  //DELETE STUDENT
  Future<void> deleteStudent(Id studentId) async {
    await isarService.isar.writeTxn(
      () => isarService.isar.students.delete(studentId),
    );
    readStudents(null);
  }
}
