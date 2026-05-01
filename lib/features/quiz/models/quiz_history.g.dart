// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuizHistoryCollection on Isar {
  IsarCollection<QuizHistory> get quizHistorys => this.collection();
}

const QuizHistorySchema = CollectionSchema(
  name: r'QuizHistory',
  id: 2091378701948205328,
  properties: {
    r'completedAt': PropertySchema(
      id: 0,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'kategoriUjian': PropertySchema(
      id: 1,
      name: r'kategoriUjian',
      type: IsarType.string,
    ),
    r'mapel': PropertySchema(
      id: 2,
      name: r'mapel',
      type: IsarType.string,
    ),
    r'profileId': PropertySchema(
      id: 3,
      name: r'profileId',
      type: IsarType.long,
    ),
    r'questionId': PropertySchema(
      id: 4,
      name: r'questionId',
      type: IsarType.string,
    ),
    r'score': PropertySchema(
      id: 5,
      name: r'score',
      type: IsarType.long,
    )
  },
  estimateSize: _quizHistoryEstimateSize,
  serialize: _quizHistorySerialize,
  deserialize: _quizHistoryDeserialize,
  deserializeProp: _quizHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _quizHistoryGetId,
  getLinks: _quizHistoryGetLinks,
  attach: _quizHistoryAttach,
  version: '3.1.0+1',
);

int _quizHistoryEstimateSize(
  QuizHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.kategoriUjian.length * 3;
  bytesCount += 3 + object.mapel.length * 3;
  bytesCount += 3 + object.questionId.length * 3;
  return bytesCount;
}

void _quizHistorySerialize(
  QuizHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.completedAt);
  writer.writeString(offsets[1], object.kategoriUjian);
  writer.writeString(offsets[2], object.mapel);
  writer.writeLong(offsets[3], object.profileId);
  writer.writeString(offsets[4], object.questionId);
  writer.writeLong(offsets[5], object.score);
}

QuizHistory _quizHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizHistory();
  object.completedAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.kategoriUjian = reader.readString(offsets[1]);
  object.mapel = reader.readString(offsets[2]);
  object.profileId = reader.readLong(offsets[3]);
  object.questionId = reader.readString(offsets[4]);
  object.score = reader.readLong(offsets[5]);
  return object;
}

P _quizHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quizHistoryGetId(QuizHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quizHistoryGetLinks(QuizHistory object) {
  return [];
}

void _quizHistoryAttach(
    IsarCollection<dynamic> col, Id id, QuizHistory object) {
  object.id = id;
}

extension QuizHistoryQueryWhereSort
    on QueryBuilder<QuizHistory, QuizHistory, QWhere> {
  QueryBuilder<QuizHistory, QuizHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuizHistoryQueryWhere
    on QueryBuilder<QuizHistory, QuizHistory, QWhereClause> {
  QueryBuilder<QuizHistory, QuizHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<QuizHistory, QuizHistory, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterWhereClause> idBetween(
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

extension QuizHistoryQueryFilter
    on QueryBuilder<QuizHistory, QuizHistory, QFilterCondition> {
  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      completedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      completedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      completedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> idBetween(
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

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      kategoriUjianEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kategoriUjian',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      kategoriUjianGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kategoriUjian',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      kategoriUjianLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kategoriUjian',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      kategoriUjianBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kategoriUjian',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      kategoriUjianStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'kategoriUjian',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      kategoriUjianEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'kategoriUjian',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      kategoriUjianContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'kategoriUjian',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      kategoriUjianMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'kategoriUjian',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      kategoriUjianIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kategoriUjian',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      kategoriUjianIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'kategoriUjian',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> mapelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mapel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      mapelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mapel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> mapelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mapel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> mapelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mapel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> mapelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mapel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> mapelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mapel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> mapelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mapel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> mapelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mapel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> mapelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mapel',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      mapelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mapel',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      profileIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profileId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      profileIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profileId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      profileIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profileId',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      profileIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profileId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      questionIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      questionIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      questionIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      questionIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      questionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      questionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      questionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      questionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      questionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      questionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> scoreEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition>
      scoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> scoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterFilterCondition> scoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuizHistoryQueryObject
    on QueryBuilder<QuizHistory, QuizHistory, QFilterCondition> {}

extension QuizHistoryQueryLinks
    on QueryBuilder<QuizHistory, QuizHistory, QFilterCondition> {}

extension QuizHistoryQuerySortBy
    on QueryBuilder<QuizHistory, QuizHistory, QSortBy> {
  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByKategoriUjian() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kategoriUjian', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy>
      sortByKategoriUjianDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kategoriUjian', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByMapel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapel', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByMapelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapel', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByProfileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByQuestionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> sortByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }
}

extension QuizHistoryQuerySortThenBy
    on QueryBuilder<QuizHistory, QuizHistory, QSortThenBy> {
  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByKategoriUjian() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kategoriUjian', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy>
      thenByKategoriUjianDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'kategoriUjian', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByMapel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapel', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByMapelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapel', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByProfileIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profileId', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByQuestionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.desc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QAfterSortBy> thenByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }
}

extension QuizHistoryQueryWhereDistinct
    on QueryBuilder<QuizHistory, QuizHistory, QDistinct> {
  QueryBuilder<QuizHistory, QuizHistory, QDistinct> distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QDistinct> distinctByKategoriUjian(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'kategoriUjian',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QDistinct> distinctByMapel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mapel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QDistinct> distinctByProfileId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profileId');
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QDistinct> distinctByQuestionId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizHistory, QuizHistory, QDistinct> distinctByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score');
    });
  }
}

extension QuizHistoryQueryProperty
    on QueryBuilder<QuizHistory, QuizHistory, QQueryProperty> {
  QueryBuilder<QuizHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuizHistory, DateTime, QQueryOperations> completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<QuizHistory, String, QQueryOperations> kategoriUjianProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'kategoriUjian');
    });
  }

  QueryBuilder<QuizHistory, String, QQueryOperations> mapelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mapel');
    });
  }

  QueryBuilder<QuizHistory, int, QQueryOperations> profileIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profileId');
    });
  }

  QueryBuilder<QuizHistory, String, QQueryOperations> questionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionId');
    });
  }

  QueryBuilder<QuizHistory, int, QQueryOperations> scoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score');
    });
  }
}
