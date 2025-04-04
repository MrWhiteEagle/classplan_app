import 'package:classplan_new/logic/isar_service.dart';
import 'package:classplan_new/models/grade.dart';
import 'package:isar/isar.dart';
import 'package:flutter/material.dart';

class GradeDatabase extends ChangeNotifier {
  final isarService = IsarService();
  final List<Grade> fetchedGradeList = [];
  Grade? fetchedGrade;

  //CREATE GRADE
  Future<void> createGrade(int studentId, Grade newGrade) async {
    debugPrint(
      'Creating grade ${newGrade.title} for student ${newGrade.studentId}...',
    );

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
    fetchedGradeList.clear();
    fetchedGradeList.addAll(studentGrades);
    debugPrint(
      studentGrades.isNotEmpty
          ? "fetched grades: $studentGrades"
          : "fetched studentGrades are empty!",
    );
    notifyListeners();
  }

  //SORT STUDENT GRADES BY TITLE
  void sortGradesByTitle() {
    fetchedGradeList.sort((a, b) => a.title.compareTo(b.title));
    notifyListeners();
  }

  //SORT STUDENT GRADES BY TYPE
  void sortGradesByType() {
    Map<GradeType, int> sortOrder = {
      GradeType.test: 0,
      GradeType.quiz: 1,
      GradeType.activity: 2,
      GradeType.lesson: 3,
      GradeType.other: 4,
    };
    fetchedGradeList.sort(
      (a, b) => sortOrder[a.type]!.compareTo(sortOrder[b.type]!),
    );
    notifyListeners();
  }

  //UPDATE GRADE
  Future<void> updateGrade(int studentId, Grade newGrade) async {
    await isarService.isar.writeTxn(
      () => isarService.isar.grades.put(newGrade),
    );
    debugPrint('Grade update process finished.');
    readStudentGrades(studentId);
  }

  //DELETE GRADE
  Future<void> deleteGrade(int gradeId, int studentId) async {
    debugPrint('Deleting grade $gradeId');
    await isarService.isar.writeTxn(
      () => isarService.isar.grades.delete(gradeId),
    );
    readStudentGrades(studentId);
  }

  //DELETE ALL STUDENT GRADES UPON STUDENT DELETE
  Future<void> deleteAllStudentGrades(int studentId) async {
    final List<Grade> fetchedGrades =
        await isarService.isar.grades
            .filter()
            .studentIdEqualTo(studentId)
            .findAll();
    debugPrint('Found grades for deletion!');
    for (Grade grade in fetchedGrades) {
      debugPrint('Deleting grade: ${grade.gradeId} ${grade.title}...');
      isarService.isar.writeTxn(
        () => isarService.isar.grades.delete(grade.gradeId),
      );
    }
    debugPrint('Deletion process finished.');
  }

  Future<void> resetGradeDatabase() async {
    fetchedGrade = null;
    fetchedGradeList.clear();
    await isarService.isar.writeTxn(() => isarService.isar.grades.clear());
    notifyListeners();
  }
}
