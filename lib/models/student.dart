import "package:isar/isar.dart";

part 'student.g.dart';

@collection
class Student {
  Id studentId = Isar.autoIncrement;
  late int internalId;
  List<Id> classIds = [];
  late String name;
  late String lastName;
  String phoneNumber = '';
  String parentPhoneNumber = '';
  String parentPhoneNumber2 = '';
  List<String> points = [];
}
