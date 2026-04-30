// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuestionCollection on Isar {
  IsarCollection<Question> get questions => this.collection();
}

const QuestionSchema = CollectionSchema(
  name: r'Question',
  id: -6819722535046815095,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.object,
      target: r'Content',
    ),
    r'feedback': PropertySchema(
      id: 1,
      name: r'feedback',
      type: IsarType.object,
      target: r'FeedbackInfo',
    ),
    r'metadata': PropertySchema(
      id: 2,
      name: r'metadata',
      type: IsarType.object,
      target: r'Metadata',
    ),
    r'questionId': PropertySchema(
      id: 3,
      name: r'questionId',
      type: IsarType.string,
    )
  },
  estimateSize: _questionEstimateSize,
  serialize: _questionSerialize,
  deserialize: _questionDeserialize,
  deserializeProp: _questionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'Metadata': MetadataSchema,
    r'Content': ContentSchema,
    r'Option': OptionSchema,
    r'FeedbackInfo': FeedbackInfoSchema
  },
  getId: _questionGetId,
  getLinks: _questionGetLinks,
  attach: _questionAttach,
  version: '3.1.0+1',
);

int _questionEstimateSize(
  Question object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      ContentSchema.estimateSize(
          object.content, allOffsets[Content]!, allOffsets);
  bytesCount += 3 +
      FeedbackInfoSchema.estimateSize(
          object.feedback, allOffsets[FeedbackInfo]!, allOffsets);
  bytesCount += 3 +
      MetadataSchema.estimateSize(
          object.metadata, allOffsets[Metadata]!, allOffsets);
  bytesCount += 3 + object.questionId.length * 3;
  return bytesCount;
}

void _questionSerialize(
  Question object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<Content>(
    offsets[0],
    allOffsets,
    ContentSchema.serialize,
    object.content,
  );
  writer.writeObject<FeedbackInfo>(
    offsets[1],
    allOffsets,
    FeedbackInfoSchema.serialize,
    object.feedback,
  );
  writer.writeObject<Metadata>(
    offsets[2],
    allOffsets,
    MetadataSchema.serialize,
    object.metadata,
  );
  writer.writeString(offsets[3], object.questionId);
}

Question _questionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Question();
  object.content = reader.readObjectOrNull<Content>(
        offsets[0],
        ContentSchema.deserialize,
        allOffsets,
      ) ??
      Content();
  object.feedback = reader.readObjectOrNull<FeedbackInfo>(
        offsets[1],
        FeedbackInfoSchema.deserialize,
        allOffsets,
      ) ??
      FeedbackInfo();
  object.id = id;
  object.metadata = reader.readObjectOrNull<Metadata>(
        offsets[2],
        MetadataSchema.deserialize,
        allOffsets,
      ) ??
      Metadata();
  object.questionId = reader.readString(offsets[3]);
  return object;
}

P _questionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<Content>(
            offset,
            ContentSchema.deserialize,
            allOffsets,
          ) ??
          Content()) as P;
    case 1:
      return (reader.readObjectOrNull<FeedbackInfo>(
            offset,
            FeedbackInfoSchema.deserialize,
            allOffsets,
          ) ??
          FeedbackInfo()) as P;
    case 2:
      return (reader.readObjectOrNull<Metadata>(
            offset,
            MetadataSchema.deserialize,
            allOffsets,
          ) ??
          Metadata()) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _questionGetId(Question object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _questionGetLinks(Question object) {
  return [];
}

void _questionAttach(IsarCollection<dynamic> col, Id id, Question object) {
  object.id = id;
}

extension QuestionQueryWhereSort on QueryBuilder<Question, Question, QWhere> {
  QueryBuilder<Question, Question, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension QuestionQueryWhere on QueryBuilder<Question, Question, QWhereClause> {
  QueryBuilder<Question, Question, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Question, Question, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Question, Question, QAfterWhereClause> idBetween(
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

extension QuestionQueryFilter
    on QueryBuilder<Question, Question, QFilterCondition> {
  QueryBuilder<Question, Question, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Question, Question, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Question, Question, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIdEqualTo(
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

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIdGreaterThan(
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

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIdLessThan(
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

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIdBetween(
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

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIdStartsWith(
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

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIdEndsWith(
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

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> questionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionId',
        value: '',
      ));
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition>
      questionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionId',
        value: '',
      ));
    });
  }
}

extension QuestionQueryObject
    on QueryBuilder<Question, Question, QFilterCondition> {
  QueryBuilder<Question, Question, QAfterFilterCondition> content(
      FilterQuery<Content> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'content');
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> feedback(
      FilterQuery<FeedbackInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'feedback');
    });
  }

  QueryBuilder<Question, Question, QAfterFilterCondition> metadata(
      FilterQuery<Metadata> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'metadata');
    });
  }
}

extension QuestionQueryLinks
    on QueryBuilder<Question, Question, QFilterCondition> {}

extension QuestionQuerySortBy on QueryBuilder<Question, Question, QSortBy> {
  QueryBuilder<Question, Question, QAfterSortBy> sortByQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.asc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> sortByQuestionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.desc);
    });
  }
}

extension QuestionQuerySortThenBy
    on QueryBuilder<Question, Question, QSortThenBy> {
  QueryBuilder<Question, Question, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> thenByQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.asc);
    });
  }

  QueryBuilder<Question, Question, QAfterSortBy> thenByQuestionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.desc);
    });
  }
}

extension QuestionQueryWhereDistinct
    on QueryBuilder<Question, Question, QDistinct> {
  QueryBuilder<Question, Question, QDistinct> distinctByQuestionId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionId', caseSensitive: caseSensitive);
    });
  }
}

extension QuestionQueryProperty
    on QueryBuilder<Question, Question, QQueryProperty> {
  QueryBuilder<Question, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Question, Content, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<Question, FeedbackInfo, QQueryOperations> feedbackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'feedback');
    });
  }

  QueryBuilder<Question, Metadata, QQueryOperations> metadataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metadata');
    });
  }

  QueryBuilder<Question, String, QQueryOperations> questionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MetadataSchema = Schema(
  name: r'Metadata',
  id: -437953486446359667,
  properties: {
    r'fase': PropertySchema(
      id: 0,
      name: r'fase',
      type: IsarType.string,
    ),
    r'kategoriUjian': PropertySchema(
      id: 1,
      name: r'kategoriUjian',
      type: IsarType.string,
    ),
    r'kelas': PropertySchema(
      id: 2,
      name: r'kelas',
      type: IsarType.long,
    ),
    r'konteksIslami': PropertySchema(
      id: 3,
      name: r'konteksIslami',
      type: IsarType.bool,
    ),
    r'mapel': PropertySchema(
      id: 4,
      name: r'mapel',
      type: IsarType.string,
    ),
    r'tagNilaiIslam': PropertySchema(
      id: 5,
      name: r'tagNilaiIslam',
      type: IsarType.stringList,
    ),
    r'tingkatKesulitan': PropertySchema(
      id: 6,
      name: r'tingkatKesulitan',
      type: IsarType.string,
    ),
    r'topik': PropertySchema(
      id: 7,
      name: r'topik',
      type: IsarType.string,
    ),
    r'xpReward': PropertySchema(
      id: 8,
      name: r'xpReward',
      type: IsarType.long,
    )
  },
  estimateSize: _metadataEstimateSize,
  serialize: _metadataSerialize,
  deserialize: _metadataDeserialize,
  deserializeProp: _metadataDeserializeProp,
);

int _metadataEstimateSize(
  Metadata object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.fase;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.kategoriUjian;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mapel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.tagNilaiIslam;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.tingkatKesulitan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.topik;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _metadataSerialize(
  Metadata object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.fase);
  writer.writeString(offsets[1], object.kategoriUjian);
  writer.writeLong(offsets[2], object.kelas);
  writer.writeBool(offsets[3], object.konteksIslami);
  writer.writeString(offsets[4], object.mapel);
  writer.writeStringList(offsets[5], object.tagNilaiIslam);
  writer.writeString(offsets[6], object.tingkatKesulitan);
  writer.writeString(offsets[7], object.topik);
  writer.writeLong(offsets[8], object.xpReward);
}

Metadata _metadataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Metadata();
  object.fase = reader.readStringOrNull(offsets[0]);
  object.kategoriUjian = reader.readStringOrNull(offsets[1]);
  object.kelas = reader.readLongOrNull(offsets[2]);
  object.konteksIslami = reader.readBoolOrNull(offsets[3]);
  object.mapel = reader.readStringOrNull(offsets[4]);
  object.tagNilaiIslam = reader.readStringList(offsets[5]);
  object.tingkatKesulitan = reader.readStringOrNull(offsets[6]);
  object.topik = reader.readStringOrNull(offsets[7]);
  object.xpReward = reader.readLongOrNull(offsets[8]);
  return object;
}

P _metadataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readBoolOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringList(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MetadataQueryFilter
    on QueryBuilder<Metadata, Metadata, QFilterCondition> {
  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fase',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fase',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fase',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fase',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fase',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> faseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fase',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      kategoriUjianIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kategoriUjian',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      kategoriUjianIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kategoriUjian',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kategoriUjianEqualTo(
    String? value, {
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      kategoriUjianGreaterThan(
    String? value, {
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kategoriUjianLessThan(
    String? value, {
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kategoriUjianBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kategoriUjianEndsWith(
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kategoriUjianContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'kategoriUjian',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kategoriUjianMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'kategoriUjian',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      kategoriUjianIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kategoriUjian',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      kategoriUjianIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'kategoriUjian',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kelasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'kelas',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kelasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'kelas',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kelasEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'kelas',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kelasGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'kelas',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kelasLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'kelas',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> kelasBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'kelas',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      konteksIslamiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'konteksIslami',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      konteksIslamiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'konteksIslami',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> konteksIslamiEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'konteksIslami',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mapel',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mapel',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelEqualTo(
    String? value, {
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelGreaterThan(
    String? value, {
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelLessThan(
    String? value, {
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelStartsWith(
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelEndsWith(
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelContains(
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelMatches(
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

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mapel',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> mapelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mapel',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagNilaiIslam',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagNilaiIslam',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagNilaiIslam',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagNilaiIslam',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagNilaiIslam',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagNilaiIslam',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagNilaiIslam',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagNilaiIslam',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagNilaiIslam',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagNilaiIslam',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagNilaiIslam',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagNilaiIslam',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagNilaiIslam',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagNilaiIslam',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagNilaiIslam',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagNilaiIslam',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagNilaiIslam',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tagNilaiIslamLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagNilaiIslam',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tingkatKesulitan',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tingkatKesulitan',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tingkatKesulitan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tingkatKesulitan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tingkatKesulitan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tingkatKesulitan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tingkatKesulitan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tingkatKesulitan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tingkatKesulitan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tingkatKesulitan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tingkatKesulitan',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition>
      tingkatKesulitanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tingkatKesulitan',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'topik',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'topik',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'topik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'topik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'topik',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'topik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'topik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'topik',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'topik',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'topik',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> topikIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'topik',
        value: '',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> xpRewardIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'xpReward',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> xpRewardIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'xpReward',
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> xpRewardEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xpReward',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> xpRewardGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'xpReward',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> xpRewardLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'xpReward',
        value: value,
      ));
    });
  }

  QueryBuilder<Metadata, Metadata, QAfterFilterCondition> xpRewardBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'xpReward',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MetadataQueryObject
    on QueryBuilder<Metadata, Metadata, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ContentSchema = Schema(
  name: r'Content',
  id: 2749874844035024652,
  properties: {
    r'jawabanBenar': PropertySchema(
      id: 0,
      name: r'jawabanBenar',
      type: IsarType.string,
    ),
    r'pertanyaan': PropertySchema(
      id: 1,
      name: r'pertanyaan',
      type: IsarType.string,
    ),
    r'pilihan': PropertySchema(
      id: 2,
      name: r'pilihan',
      type: IsarType.objectList,
      target: r'Option',
    ),
    r'tipeSoal': PropertySchema(
      id: 3,
      name: r'tipeSoal',
      type: IsarType.string,
    )
  },
  estimateSize: _contentEstimateSize,
  serialize: _contentSerialize,
  deserialize: _contentDeserialize,
  deserializeProp: _contentDeserializeProp,
);

int _contentEstimateSize(
  Content object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.jawabanBenar;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pertanyaan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.pilihan;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[Option]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += OptionSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.tipeSoal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _contentSerialize(
  Content object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.jawabanBenar);
  writer.writeString(offsets[1], object.pertanyaan);
  writer.writeObjectList<Option>(
    offsets[2],
    allOffsets,
    OptionSchema.serialize,
    object.pilihan,
  );
  writer.writeString(offsets[3], object.tipeSoal);
}

Content _contentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Content();
  object.jawabanBenar = reader.readStringOrNull(offsets[0]);
  object.pertanyaan = reader.readStringOrNull(offsets[1]);
  object.pilihan = reader.readObjectList<Option>(
    offsets[2],
    OptionSchema.deserialize,
    allOffsets,
    Option(),
  );
  object.tipeSoal = reader.readStringOrNull(offsets[3]);
  return object;
}

P _contentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readObjectList<Option>(
        offset,
        OptionSchema.deserialize,
        allOffsets,
        Option(),
      )) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ContentQueryFilter
    on QueryBuilder<Content, Content, QFilterCondition> {
  QueryBuilder<Content, Content, QAfterFilterCondition> jawabanBenarIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'jawabanBenar',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition>
      jawabanBenarIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'jawabanBenar',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> jawabanBenarEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jawabanBenar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> jawabanBenarGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jawabanBenar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> jawabanBenarLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jawabanBenar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> jawabanBenarBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jawabanBenar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> jawabanBenarStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jawabanBenar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> jawabanBenarEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jawabanBenar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> jawabanBenarContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jawabanBenar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> jawabanBenarMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jawabanBenar',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> jawabanBenarIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jawabanBenar',
        value: '',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition>
      jawabanBenarIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jawabanBenar',
        value: '',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pertanyaan',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pertanyaan',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pertanyaan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pertanyaan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pertanyaan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pertanyaan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pertanyaan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pertanyaan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pertanyaan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pertanyaan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pertanyaan',
        value: '',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pertanyaanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pertanyaan',
        value: '',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pilihanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pilihan',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pilihanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pilihan',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pilihanLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pilihan',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pilihanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pilihan',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pilihanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pilihan',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pilihanLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pilihan',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition>
      pilihanLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pilihan',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> pilihanLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pilihan',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tipeSoal',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tipeSoal',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipeSoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipeSoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipeSoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipeSoal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipeSoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipeSoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipeSoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipeSoal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipeSoal',
        value: '',
      ));
    });
  }

  QueryBuilder<Content, Content, QAfterFilterCondition> tipeSoalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipeSoal',
        value: '',
      ));
    });
  }
}

extension ContentQueryObject
    on QueryBuilder<Content, Content, QFilterCondition> {
  QueryBuilder<Content, Content, QAfterFilterCondition> pilihanElement(
      FilterQuery<Option> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pilihan');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const OptionSchema = Schema(
  name: r'Option',
  id: -5786321349724631965,
  properties: {
    r'idPilihan': PropertySchema(
      id: 0,
      name: r'idPilihan',
      type: IsarType.string,
    ),
    r'teks': PropertySchema(
      id: 1,
      name: r'teks',
      type: IsarType.string,
    )
  },
  estimateSize: _optionEstimateSize,
  serialize: _optionSerialize,
  deserialize: _optionDeserialize,
  deserializeProp: _optionDeserializeProp,
);

int _optionEstimateSize(
  Option object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.idPilihan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.teks;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _optionSerialize(
  Option object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.idPilihan);
  writer.writeString(offsets[1], object.teks);
}

Option _optionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Option();
  object.idPilihan = reader.readStringOrNull(offsets[0]);
  object.teks = reader.readStringOrNull(offsets[1]);
  return object;
}

P _optionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension OptionQueryFilter on QueryBuilder<Option, Option, QFilterCondition> {
  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'idPilihan',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'idPilihan',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idPilihan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'idPilihan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'idPilihan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'idPilihan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'idPilihan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'idPilihan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'idPilihan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'idPilihan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'idPilihan',
        value: '',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> idPilihanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'idPilihan',
        value: '',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'teks',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'teks',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teks',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teks',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teks',
        value: '',
      ));
    });
  }

  QueryBuilder<Option, Option, QAfterFilterCondition> teksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teks',
        value: '',
      ));
    });
  }
}

extension OptionQueryObject on QueryBuilder<Option, Option, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const FeedbackInfoSchema = Schema(
  name: r'FeedbackInfo',
  id: -8911548856954206771,
  properties: {
    r'hint': PropertySchema(
      id: 0,
      name: r'hint',
      type: IsarType.string,
    ),
    r'penjelasanAnak': PropertySchema(
      id: 1,
      name: r'penjelasanAnak',
      type: IsarType.string,
    )
  },
  estimateSize: _feedbackInfoEstimateSize,
  serialize: _feedbackInfoSerialize,
  deserialize: _feedbackInfoDeserialize,
  deserializeProp: _feedbackInfoDeserializeProp,
);

int _feedbackInfoEstimateSize(
  FeedbackInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.hint;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.penjelasanAnak;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _feedbackInfoSerialize(
  FeedbackInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.hint);
  writer.writeString(offsets[1], object.penjelasanAnak);
}

FeedbackInfo _feedbackInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FeedbackInfo();
  object.hint = reader.readStringOrNull(offsets[0]);
  object.penjelasanAnak = reader.readStringOrNull(offsets[1]);
  return object;
}

P _feedbackInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension FeedbackInfoQueryFilter
    on QueryBuilder<FeedbackInfo, FeedbackInfo, QFilterCondition> {
  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition> hintIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hint',
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      hintIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hint',
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition> hintEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      hintGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition> hintLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition> hintBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      hintStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition> hintEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition> hintContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hint',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition> hintMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hint',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      hintIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hint',
        value: '',
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      hintIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hint',
        value: '',
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'penjelasanAnak',
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'penjelasanAnak',
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'penjelasanAnak',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'penjelasanAnak',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'penjelasanAnak',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'penjelasanAnak',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'penjelasanAnak',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'penjelasanAnak',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'penjelasanAnak',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'penjelasanAnak',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'penjelasanAnak',
        value: '',
      ));
    });
  }

  QueryBuilder<FeedbackInfo, FeedbackInfo, QAfterFilterCondition>
      penjelasanAnakIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'penjelasanAnak',
        value: '',
      ));
    });
  }
}

extension FeedbackInfoQueryObject
    on QueryBuilder<FeedbackInfo, FeedbackInfo, QFilterCondition> {}
