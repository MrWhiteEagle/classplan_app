import 'package:classplan_new/models/event.dart';
import 'package:classplan_new/models/grade.dart';
import 'package:classplan_new/models/class.dart';
import 'package:classplan_new/models/student.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  late Isar isar;

  factory IsarService() {
    return _instance;
  }

  IsarService._internal();

  Future<void> initialize() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([
        ClassObjSchema,
        StudentSchema,
        GradeSchema,
        EventSchema,
      ], directory: dir.path);
    } else {
      isar = Isar.getInstance()!;
    }
  }
}
