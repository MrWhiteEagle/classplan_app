// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetClassObjCollection on Isar {
  IsarCollection<ClassObj> get classObjs => this.collection();
}

const ClassObjSchema = CollectionSchema(
  name: r'ClassObj',
  id: 519802763645775704,
  properties: {
    r'careTeacher': PropertySchema(
      id: 0,
      name: r'careTeacher',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'students': PropertySchema(
      id: 2,
      name: r'students',
      type: IsarType.longList,
    )
  },
  estimateSize: _classObjEstimateSize,
  serialize: _classObjSerialize,
  deserialize: _classObjDeserialize,
  deserializeProp: _classObjDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _classObjGetId,
  getLinks: _classObjGetLinks,
  attach: _classObjAttach,
  version: '3.1.8',
);

int _classObjEstimateSize(
  ClassObj object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.careTeacher.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.students.length * 8;
  return bytesCount;
}

void _classObjSerialize(
  ClassObj object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.careTeacher);
  writer.writeString(offsets[1], object.name);
  writer.writeLongList(offsets[2], object.students);
}

ClassObj _classObjDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ClassObj();
  object.careTeacher = reader.readString(offsets[0]);
  object.id = id;
  object.name = reader.readString(offsets[1]);
  object.students = reader.readLongList(offsets[2]) ?? [];
  return object;
}

P _classObjDeserializeProp<P>(
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
      return (reader.readLongList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _classObjGetId(ClassObj object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _classObjGetLinks(ClassObj object) {
  return [];
}

void _classObjAttach(IsarCollection<dynamic> col, Id id, ClassObj object) {
  object.id = id;
}

extension ClassObjQueryWhereSort on QueryBuilder<ClassObj, ClassObj, QWhere> {
  QueryBuilder<ClassObj, ClassObj, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ClassObjQueryWhere on QueryBuilder<ClassObj, ClassObj, QWhereClause> {
  QueryBuilder<ClassObj, ClassObj, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ClassObjQueryFilter
    on QueryBuilder<ClassObj, ClassObj, QFilterCondition> {
  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> careTeacherEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'careTeacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition>
      careTeacherGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'careTeacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> careTeacherLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'careTeacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> careTeacherBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'careTeacher',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> careTeacherStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'careTeacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> careTeacherEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'careTeacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> careTeacherContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'careTeacher',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> careTeacherMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'careTeacher',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> careTeacherIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'careTeacher',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition>
      careTeacherIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'careTeacher',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition>
      studentsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'students',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition>
      studentsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'students',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition>
      studentsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'students',
        value: value,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition>
      studentsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'students',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> studentsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'students',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> studentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'students',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> studentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'students',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition>
      studentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'students',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition>
      studentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'students',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterFilterCondition> studentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'students',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ClassObjQueryObject
    on QueryBuilder<ClassObj, ClassObj, QFilterCondition> {}

extension ClassObjQueryLinks
    on QueryBuilder<ClassObj, ClassObj, QFilterCondition> {}

extension ClassObjQuerySortBy on QueryBuilder<ClassObj, ClassObj, QSortBy> {
  QueryBuilder<ClassObj, ClassObj, QAfterSortBy> sortByCareTeacher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careTeacher', Sort.asc);
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterSortBy> sortByCareTeacherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careTeacher', Sort.desc);
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ClassObjQuerySortThenBy
    on QueryBuilder<ClassObj, ClassObj, QSortThenBy> {
  QueryBuilder<ClassObj, ClassObj, QAfterSortBy> thenByCareTeacher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careTeacher', Sort.asc);
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterSortBy> thenByCareTeacherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'careTeacher', Sort.desc);
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ClassObj, ClassObj, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ClassObjQueryWhereDistinct
    on QueryBuilder<ClassObj, ClassObj, QDistinct> {
  QueryBuilder<ClassObj, ClassObj, QDistinct> distinctByCareTeacher(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'careTeacher', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassObj, ClassObj, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ClassObj, ClassObj, QDistinct> distinctByStudents() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'students');
    });
  }
}

extension ClassObjQueryProperty
    on QueryBuilder<ClassObj, ClassObj, QQueryProperty> {
  QueryBuilder<ClassObj, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ClassObj, String, QQueryOperations> careTeacherProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'careTeacher');
    });
  }

  QueryBuilder<ClassObj, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ClassObj, List<int>, QQueryOperations> studentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'students');
    });
  }
}
