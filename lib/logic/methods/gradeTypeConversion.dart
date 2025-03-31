import 'package:classplan_new/models/grade.dart';

String gradeTypeToString(GradeType type) {
  switch (type) {
    case GradeType.test:
      return 'T';
    case GradeType.quiz:
      return 'K';
    case GradeType.activity:
      return 'A';
    case GradeType.lesson:
      return 'P';
    case GradeType.other:
      return 'I';
  }
}

GradeType stringToGradeType(String type) {
  switch (type) {
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
    default:
      return GradeType.other;
  }
}
