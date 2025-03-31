import "package:isar/isar.dart";

part 'class.g.dart';

@collection
class ClassObj {
  Id id = Isar.autoIncrement;
  late String name;
  late String careTeacher;
}
