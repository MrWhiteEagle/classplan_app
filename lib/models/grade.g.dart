// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGradeCollection on Isar {
  IsarCollection<Grade> get grades => this.collection();
}

const GradeSchema = CollectionSchema(
  name: r'Grade',
  id: -5717027466259005798,
  properties: {
    r'grade': PropertySchema(
      id: 0,
      name: r'grade',
      type: IsarType.string,
    ),
    r'gradeAdd': PropertySchema(
      id: 1,
      name: r'gradeAdd',
      type: IsarType.string,
    ),
    r'studentId': PropertySchema(
      id: 2,
      name: r'studentId',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 3,
      name: r'title',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 4,
      name: r'type',
      type: IsarType.byte,
      enumMap: _GradetypeEnumValueMap,
    ),
    r'wasRecorded': PropertySchema(
      id: 5,
      name: r'wasRecorded',
      type: IsarType.bool,
    )
  },
  estimateSize: _gradeEstimateSize,
  serialize: _gradeSerialize,
  deserialize: _gradeDeserialize,
  deserializeProp: _gradeDeserializeProp,
  idName: r'gradeId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _gradeGetId,
  getLinks: _gradeGetLinks,
  attach: _gradeAttach,
  version: '3.1.8',
);

int _gradeEstimateSize(
  Grade object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.grade.length * 3;
  bytesCount += 3 + object.gradeAdd.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _gradeSerialize(
  Grade object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.grade);
  writer.writeString(offsets[1], object.gradeAdd);
  writer.writeLong(offsets[2], object.studentId);
  writer.writeString(offsets[3], object.title);
  writer.writeByte(offsets[4], object.type.index);
  writer.writeBool(offsets[5], object.wasRecorded);
}

Grade _gradeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Grade();
  object.grade = reader.readString(offsets[0]);
  object.gradeAdd = reader.readString(offsets[1]);
  object.gradeId = id;
  object.studentId = reader.readLong(offsets[2]);
  object.title = reader.readString(offsets[3]);
  object.type = _GradetypeValueEnumMap[reader.readByteOrNull(offsets[4])] ??
      GradeType.test;
  object.wasRecorded = reader.readBool(offsets[5]);
  return object;
}

P _gradeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (_GradetypeValueEnumMap[reader.readByteOrNull(offset)] ??
          GradeType.test) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _GradetypeEnumValueMap = {
  'test': 0,
  'quiz': 1,
  'activity': 2,
  'lesson': 3,
  'other': 4,
};
const _GradetypeValueEnumMap = {
  0: GradeType.test,
  1: GradeType.quiz,
  2: GradeType.activity,
  3: GradeType.lesson,
  4: GradeType.other,
};

Id _gradeGetId(Grade object) {
  return object.gradeId;
}

List<IsarLinkBase<dynamic>> _gradeGetLinks(Grade object) {
  return [];
}

void _gradeAttach(IsarCollection<dynamic> col, Id id, Grade object) {
  object.gradeId = id;
}

extension GradeQueryWhereSort on QueryBuilder<Grade, Grade, QWhere> {
  QueryBuilder<Grade, Grade, QAfterWhere> anyGradeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GradeQueryWhere on QueryBuilder<Grade, Grade, QWhereClause> {
  QueryBuilder<Grade, Grade, QAfterWhereClause> gradeIdEqualTo(Id gradeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: gradeId,
        upper: gradeId,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterWhereClause> gradeIdNotEqualTo(Id gradeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: gradeId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: gradeId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: gradeId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: gradeId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Grade, Grade, QAfterWhereClause> gradeIdGreaterThan(Id gradeId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: gradeId, includeLower: include),
      );
    });
  }

  QueryBuilder<Grade, Grade, QAfterWhereClause> gradeIdLessThan(Id gradeId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: gradeId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Grade, Grade, QAfterWhereClause> gradeIdBetween(
    Id lowerGradeId,
    Id upperGradeId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerGradeId,
        includeLower: includeLower,
        upper: upperGradeId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GradeQueryFilter on QueryBuilder<Grade, Grade, QFilterCondition> {
  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grade',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'grade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'grade',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grade',
        value: '',
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'grade',
        value: '',
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeAddEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gradeAdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeAddGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gradeAdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeAddLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gradeAdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeAddBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gradeAdd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeAddStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gradeAdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeAddEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gradeAdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeAddContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gradeAdd',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeAddMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gradeAdd',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeAddIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gradeAdd',
        value: '',
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeAddIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gradeAdd',
        value: '',
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gradeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gradeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gradeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> gradeIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gradeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> studentIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'studentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> studentIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'studentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> studentIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'studentId',
        value: value,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> studentIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'studentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> typeEqualTo(
      GradeType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> typeGreaterThan(
    GradeType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> typeLessThan(
    GradeType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> typeBetween(
    GradeType lower,
    GradeType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Grade, Grade, QAfterFilterCondition> wasRecordedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wasRecorded',
        value: value,
      ));
    });
  }
}

extension GradeQueryObject on QueryBuilder<Grade, Grade, QFilterCondition> {}

extension GradeQueryLinks on QueryBuilder<Grade, Grade, QFilterCondition> {}

extension GradeQuerySortBy on QueryBuilder<Grade, Grade, QSortBy> {
  QueryBuilder<Grade, Grade, QAfterSortBy> sortByGrade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByGradeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByGradeAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeAdd', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByGradeAddDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeAdd', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByStudentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByStudentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByWasRecorded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasRecorded', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> sortByWasRecordedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasRecorded', Sort.desc);
    });
  }
}

extension GradeQuerySortThenBy on QueryBuilder<Grade, Grade, QSortThenBy> {
  QueryBuilder<Grade, Grade, QAfterSortBy> thenByGrade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByGradeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'grade', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByGradeAdd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeAdd', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByGradeAddDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeAdd', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByGradeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeId', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByGradeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeId', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByStudentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByStudentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'studentId', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByWasRecorded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasRecorded', Sort.asc);
    });
  }

  QueryBuilder<Grade, Grade, QAfterSortBy> thenByWasRecordedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wasRecorded', Sort.desc);
    });
  }
}

extension GradeQueryWhereDistinct on QueryBuilder<Grade, Grade, QDistinct> {
  QueryBuilder<Grade, Grade, QDistinct> distinctByGrade(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'grade', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Grade, Grade, QDistinct> distinctByGradeAdd(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gradeAdd', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Grade, Grade, QDistinct> distinctByStudentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'studentId');
    });
  }

  QueryBuilder<Grade, Grade, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Grade, Grade, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<Grade, Grade, QDistinct> distinctByWasRecorded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wasRecorded');
    });
  }
}

extension GradeQueryProperty on QueryBuilder<Grade, Grade, QQueryProperty> {
  QueryBuilder<Grade, int, QQueryOperations> gradeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gradeId');
    });
  }

  QueryBuilder<Grade, String, QQueryOperations> gradeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'grade');
    });
  }

  QueryBuilder<Grade, String, QQueryOperations> gradeAddProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gradeAdd');
    });
  }

  QueryBuilder<Grade, int, QQueryOperations> studentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'studentId');
    });
  }

  QueryBuilder<Grade, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Grade, GradeType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Grade, bool, QQueryOperations> wasRecordedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wasRecorded');
    });
  }
}
