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
          ..name = checkSpelling(studentName)
          ..lastName = checkSpelling(lastName)
          ..internalId = await getNextStudentNumberForClass(classId)
          ..classIds.add(classId);
    await isarService.isar.writeTxn(
      () => isarService.isar.students.put(newStudent),
    );
    readStudents(classId);
  }

  //FETCH LAST STUDENT INTERNAL ID FOR CLASS
  Future<int> getNextStudentNumberForClass(Id classId) async {
    final lastStudent =
        await isarService.isar.students
            .filter()
            .classIdsElementEqualTo(classId)
            .sortByInternalIdDesc()
            .findFirst();

    return (lastStudent?.internalId ?? 0) + 1;
  }

  //READ STUDENTS BY CLASSID OR ALL
  Future<void> readStudents(Id? classId) async {
    if (classId != null) {
      //classID specified, fetched students from that class
      List<Student> fetchedStudents =
          await isarService.isar.students
              .filter()
              .classIdsElementEqualTo(classId)
              .findAll();
      studentList.clear();
      studentList.addAll(fetchedStudents);
      notifyListeners();
    } else {
      //if no classID specified, fetches all studcents
      List<Student> fetchedStudents =
          await isarService.isar.students.where().findAll();
      studentList.clear();
      studentList.addAll(fetchedStudents);
      notifyListeners();
    }
  }

  //SORT STUDENT LIST ALPHABETICALLY
  void sortStudentsAlpha() {
    studentList.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void sortStudentsLastNameAlpha() {
    studentList.sort((a, b) => a.lastName.compareTo(b.lastName));
    notifyListeners();
  }

  //FETCH STUDENT DETAILS BY ID
  Future<void> fetchStudentDetails(Id studentId) async {
    final studentDetails = await isarService.isar.students.get(studentId);
    if (studentDetails != null) {
      fetchedStudent = studentDetails;
      notifyListeners();
    }
  }

  //DELETE ALL CLASS ID'S FROM ALL STUDENT'S CLASSLIST (TYPICALLY DURING CLASS DELETION)
  Future<void> deleteClassFromAllStudents(Id classId) async {
    //Fetch all student's containing classId
    List<Student> fetchedStudents =
        await isarService.isar.students
            .filter()
            .classIdsElementEqualTo(classId)
            .findAll();
    if (fetchedStudents.isNotEmpty) {
      for (Student student in fetchedStudents) {
        List<int> updatedClassList = List.from(student.classIds);
        updatedClassList.remove(classId);
        student.classIds = updatedClassList;
        await isarService.isar.writeTxn(
          () => isarService.isar.students.put(student),
        );
      }
    } else {
      return;
    }
  }

  //UPDATE STUDENT
  Future<void> updateStudent(Student newStudent) async {
    newStudent.name = checkSpelling(newStudent.name);
    newStudent.lastName = checkSpelling(newStudent.lastName);
    await isarService.isar.writeTxn(
      () => isarService.isar.students.put(newStudent),
    );
    notifyListeners();
    fetchStudentDetails(newStudent.studentId);
  }

  //DELETE STUDENT
  Future<void> deleteStudent(Id studentId) async {
    await isarService.isar.writeTxn(
      () => isarService.isar.students.delete(studentId),
    );
    readStudents(null);
  }

  //RESET STUDENT DATABASE
  Future<void> resetStudentDatabase() async {
    fetchedStudent = null;
    studentList.clear();
    await isarService.isar.writeTxn(() => isarService.isar.students.clear());
    notifyListeners();
  }
}

String checkSpelling(String text) {
  if (text.isEmpty) {
    return text;
  }
  //delete all non-letters
  text = text.replaceAll(RegExp(r'[^\p{L}]', unicode: true), '');

  //if text turns out empty after cleanup, leave it empty
  if (text.isEmpty) {
    return text;
  }
  //if the first letter is uppercase, return it
  if (text[0].toUpperCase() == text[0]) {
    return text;
  }
  //if its not, make it uppercase
  else {
    text = text[0].toUpperCase() + text.substring(1);
  }
  //return
  return text;
}
