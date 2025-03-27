import 'package:classplan_new/logic/isar_service.dart';
import 'package:classplan_new/models/grade.dart';
import 'package:isar/isar.dart';
import 'package:flutter/material.dart';

class GradeDatabase extends ChangeNotifier {
  final isarService = IsarService();
  final List<Grade> fetchedGradeList = [];
  Grade? fetchedGrade;

  //CREATE GRADE
  Future<void> createGrade(
    int studentId,
    String title,
    String type,
    String grade,
    String gradeAdd,
  ) async {
    debugPrint('Creating grade $title for student $studentId...');

    final newGrade =
        Grade()
          ..studentId = studentId
          ..title = title
          ..type = fromStringGradeType(type)
          ..grade = grade
          ..gradeAdd = gradeAdd;

    await isarService.isar.writeTxn(
      () => isarService.isar.grades.put(newGrade),
    );
    debugPrint('Grade creation process finished.');
    readStudentGrades(studentId);
  }

  //READ STUDENT GRADES
  Future<void> readStudentGrades(int studentId) async {
    debugPrint('Fetching grades of $studentId...');
    final List<Grade> studentGrades =
        await isarService.isar.grades
            .filter()
            .studentIdEqualTo(studentId)
            .findAll();
    if (studentGrades.isNotEmpty) {
      fetchedGradeList.clear();
      fetchedGradeList.addAll(studentGrades);
    }
    debugPrint(
      studentGrades.isNotEmpty
          ? "fetched grades: $studentGrades"
          : "fetched studentGrades are empty!",
    );
    notifyListeners();
  }

  //UPDATE GRADE
  Future<void> updateGrade(
    int gradeId,
    String newTitle,
    GradeType newType,
    String newGrade,
    String newGradeAdd,
  ) async {
    final currentGrade = await isarService.isar.grades.get(gradeId);
    if (currentGrade != null) {
      debugPrint(
        'Grade found for updating! Update with $newTitle, $newType, $newGrade $newGradeAdd',
      );
      currentGrade.title = newTitle;
      currentGrade.type = newType;
      currentGrade.grade = newGrade;
      currentGrade.gradeAdd = newGradeAdd;
      await isarService.isar.writeTxn(
        () => isarService.isar.grades.put(currentGrade),
      );
    } else {
      debugPrint('Grade search returned NULL, cannot update.');
    }
    debugPrint('Grade update process finished.');
    notifyListeners();
  }

  //DELETE GRADE
  Future<void> deleteGrade(int gradeId) async {
    debugPrint('Deleting grade $gradeId');
    await isarService.isar.writeTxn(
      () => isarService.isar.grades.delete(gradeId),
    );
    notifyListeners();
  }

  //DELETE ALL STUDENT GRADES UPON STUDENT DELETE
  Future<void> deleteAllStudentGrades(int studentId) async {
    final List<Grade> fetchedGrades =
        await isarService.isar.grades
            .filter()
            .studentIdEqualTo(studentId)
            .findAll();
    if (fetchedGrades != null) {
      debugPrint('Found grades for deletion!');
      for (Grade grade in fetchedGrades) {
        debugPrint('Deleting grade: ${grade.gradeId} ${grade.title}...');
        isarService.isar.writeTxn(
          () => isarService.isar.grades.delete(grade.gradeId),
        );
      }
      debugPrint('Deletion process finished.');
    }
  }
}

//Turn a string to enum for grade type
GradeType fromStringGradeType(String input) {
  switch (input) {
    case 'T':
      return GradeType.test;
    case 'K':
      return GradeType.quiz;
    case 'A':
      return GradeType.activity;
    case 'P':
      return GradeType.lesson;
    case 'I':
      return GradeType.other;
  }
  return GradeType.other;
}
