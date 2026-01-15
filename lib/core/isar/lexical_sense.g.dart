// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lexical_sense.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLexicalSenseCollection on Isar {
  IsarCollection<LexicalSense> get lexicalSenses => this.collection();
}

const LexicalSenseSchema = CollectionSchema(
  name: r'LexicalSense',
  id: 6112900662662195741,
  properties: {
    r'lemmaPt': PropertySchema(
      id: 0,
      name: r'lemmaPt',
      type: IsarType.string,
    ),
    r'lemmaPtCommentary': PropertySchema(
      id: 1,
      name: r'lemmaPtCommentary',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 2,
      name: r'type',
      type: IsarType.string,
      enumMap: _LexicalSensetypeEnumValueMap,
    )
  },
  estimateSize: _lexicalSenseEstimateSize,
  serialize: _lexicalSenseSerialize,
  deserialize: _lexicalSenseDeserialize,
  deserializeProp: _lexicalSenseDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _lexicalSenseGetId,
  getLinks: _lexicalSenseGetLinks,
  attach: _lexicalSenseAttach,
  version: '3.1.0+1',
);

int _lexicalSenseEstimateSize(
  LexicalSense object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.lemmaPt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lemmaPtCommentary;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _lexicalSenseSerialize(
  LexicalSense object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.lemmaPt);
  writer.writeString(offsets[1], object.lemmaPtCommentary);
  writer.writeString(offsets[2], object.type.name);
}

LexicalSense _lexicalSenseDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LexicalSense(
    lemmaPt: reader.readStringOrNull(offsets[0]),
    lemmaPtCommentary: reader.readStringOrNull(offsets[1]),
    type: _LexicalSensetypeValueEnumMap[reader.readStringOrNull(offsets[2])] ??
        SemanticType.event,
  );
  object.id = id;
  return object;
}

P _lexicalSenseDeserializeProp<P>(
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
      return (_LexicalSensetypeValueEnumMap[reader.readStringOrNull(offset)] ??
          SemanticType.event) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LexicalSensetypeEnumValueMap = {
  r'event': r'event',
  r'entity': r'entity',
  r'property': r'property',
  r'gramma': r'gramma',
};
const _LexicalSensetypeValueEnumMap = {
  r'event': SemanticType.event,
  r'entity': SemanticType.entity,
  r'property': SemanticType.property,
  r'gramma': SemanticType.gramma,
};

Id _lexicalSenseGetId(LexicalSense object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _lexicalSenseGetLinks(LexicalSense object) {
  return [];
}

void _lexicalSenseAttach(
    IsarCollection<dynamic> col, Id id, LexicalSense object) {
  object.id = id;
}

extension LexicalSenseQueryWhereSort
    on QueryBuilder<LexicalSense, LexicalSense, QWhere> {
  QueryBuilder<LexicalSense, LexicalSense, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LexicalSenseQueryWhere
    on QueryBuilder<LexicalSense, LexicalSense, QWhereClause> {
  QueryBuilder<LexicalSense, LexicalSense, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<LexicalSense, LexicalSense, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterWhereClause> idBetween(
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

extension LexicalSenseQueryFilter
    on QueryBuilder<LexicalSense, LexicalSense, QFilterCondition> {
  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition> idBetween(
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

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lemmaPt',
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lemmaPt',
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lemmaPt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lemmaPt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lemmaPt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lemmaPt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lemmaPt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lemmaPt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lemmaPt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lemmaPt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lemmaPt',
        value: '',
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lemmaPt',
        value: '',
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lemmaPtCommentary',
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lemmaPtCommentary',
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lemmaPtCommentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lemmaPtCommentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lemmaPtCommentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lemmaPtCommentary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lemmaPtCommentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lemmaPtCommentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lemmaPtCommentary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lemmaPtCommentary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lemmaPtCommentary',
        value: '',
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      lemmaPtCommentaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lemmaPtCommentary',
        value: '',
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition> typeEqualTo(
    SemanticType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      typeGreaterThan(
    SemanticType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition> typeLessThan(
    SemanticType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition> typeBetween(
    SemanticType lower,
    SemanticType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension LexicalSenseQueryObject
    on QueryBuilder<LexicalSense, LexicalSense, QFilterCondition> {}

extension LexicalSenseQueryLinks
    on QueryBuilder<LexicalSense, LexicalSense, QFilterCondition> {}

extension LexicalSenseQuerySortBy
    on QueryBuilder<LexicalSense, LexicalSense, QSortBy> {
  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy> sortByLemmaPt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lemmaPt', Sort.asc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy> sortByLemmaPtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lemmaPt', Sort.desc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy>
      sortByLemmaPtCommentary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lemmaPtCommentary', Sort.asc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy>
      sortByLemmaPtCommentaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lemmaPtCommentary', Sort.desc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension LexicalSenseQuerySortThenBy
    on QueryBuilder<LexicalSense, LexicalSense, QSortThenBy> {
  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy> thenByLemmaPt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lemmaPt', Sort.asc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy> thenByLemmaPtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lemmaPt', Sort.desc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy>
      thenByLemmaPtCommentary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lemmaPtCommentary', Sort.asc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy>
      thenByLemmaPtCommentaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lemmaPtCommentary', Sort.desc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension LexicalSenseQueryWhereDistinct
    on QueryBuilder<LexicalSense, LexicalSense, QDistinct> {
  QueryBuilder<LexicalSense, LexicalSense, QDistinct> distinctByLemmaPt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lemmaPt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QDistinct>
      distinctByLemmaPtCommentary({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lemmaPtCommentary',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LexicalSense, LexicalSense, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension LexicalSenseQueryProperty
    on QueryBuilder<LexicalSense, LexicalSense, QQueryProperty> {
  QueryBuilder<LexicalSense, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LexicalSense, String?, QQueryOperations> lemmaPtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lemmaPt');
    });
  }

  QueryBuilder<LexicalSense, String?, QQueryOperations>
      lemmaPtCommentaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lemmaPtCommentary');
    });
  }

  QueryBuilder<LexicalSense, SemanticType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
