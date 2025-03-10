import "package:isar/isar.dart";

part 'student.g.dart';

@collection
class Student {
    Id studentId = Isar.autoIncrement;
    late List<Id> classIds;
    late String name;
    late String lastName;
    late String phoneNumber;
    late String parentPhoneNumber;
    late String parentPhoneNumber2;
}