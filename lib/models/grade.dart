import 'package:isar/isar.dart';

part 'grade.g.dart';

enum GradeType { test, quiz, activity, lesson, other }

@Collection()
class Grade {
  Id gradeId = Isar.autoIncrement;
  late int studentId;
  late String title;
  bool wasRecorded = false;

  @enumerated
  late GradeType type;

  late String grade;
  late String gradeAdd;
}
