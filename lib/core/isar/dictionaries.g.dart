// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionaries.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDictCollection on Isar {
  IsarCollection<Dict> get dicts => this.collection();
}

const DictSchema = CollectionSchema(
  name: r'Dict',
  id: 987444509729091105,
  properties: {
    r'origin': PropertySchema(
      id: 0,
      name: r'origin',
      type: IsarType.string,
      enumMap: _DictoriginEnumValueMap,
    ),
    r'shoresh': PropertySchema(
      id: 1,
      name: r'shoresh',
      type: IsarType.object,
      target: r'Shoresh',
    ),
    r'signatures': PropertySchema(
      id: 2,
      name: r'signatures',
      type: IsarType.objectList,
      target: r'SurfaceSignature',
    ),
    r'stage': PropertySchema(
      id: 3,
      name: r'stage',
      type: IsarType.string,
      enumMap: _DictstageEnumValueMap,
    ),
    r'word': PropertySchema(
      id: 4,
      name: r'word',
      type: IsarType.string,
    )
  },
  estimateSize: _dictEstimateSize,
  serialize: _dictSerialize,
  deserialize: _dictDeserialize,
  deserializeProp: _dictDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'Shoresh': ShoreshSchema,
    r'SurfaceSignature': SurfaceSignatureSchema
  },
  getId: _dictGetId,
  getLinks: _dictGetLinks,
  attach: _dictAttach,
  version: '3.1.0+1',
);

int _dictEstimateSize(
  Dict object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.origin.name.length * 3;
  {
    final value = object.shoresh;
    if (value != null) {
      bytesCount += 3 +
          ShoreshSchema.estimateSize(value, allOffsets[Shoresh]!, allOffsets);
    }
  }
  bytesCount += 3 + object.signatures.length * 3;
  {
    final offsets = allOffsets[SurfaceSignature]!;
    for (var i = 0; i < object.signatures.length; i++) {
      final value = object.signatures[i];
      bytesCount +=
          SurfaceSignatureSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.stage.name.length * 3;
  bytesCount += 3 + object.word.length * 3;
  return bytesCount;
}

void _dictSerialize(
  Dict object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.origin.name);
  writer.writeObject<Shoresh>(
    offsets[1],
    allOffsets,
    ShoreshSchema.serialize,
    object.shoresh,
  );
  writer.writeObjectList<SurfaceSignature>(
    offsets[2],
    allOffsets,
    SurfaceSignatureSchema.serialize,
    object.signatures,
  );
  writer.writeString(offsets[3], object.stage.name);
  writer.writeString(offsets[4], object.word);
}

Dict _dictDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Dict(
    origin: _DictoriginValueEnumMap[reader.readStringOrNull(offsets[0])] ??
        Origin.native,
    shoresh: reader.readObjectOrNull<Shoresh>(
      offsets[1],
      ShoreshSchema.deserialize,
      allOffsets,
    ),
    signatures: reader.readObjectList<SurfaceSignature>(
          offsets[2],
          SurfaceSignatureSchema.deserialize,
          allOffsets,
          SurfaceSignature(),
        ) ??
        [],
    stage: _DictstageValueEnumMap[reader.readStringOrNull(offsets[3])] ??
        Stage.biblical,
    word: reader.readString(offsets[4]),
  );
  object.id = id;
  return object;
}

P _dictDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_DictoriginValueEnumMap[reader.readStringOrNull(offset)] ??
          Origin.native) as P;
    case 1:
      return (reader.readObjectOrNull<Shoresh>(
        offset,
        ShoreshSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readObjectList<SurfaceSignature>(
            offset,
            SurfaceSignatureSchema.deserialize,
            allOffsets,
            SurfaceSignature(),
          ) ??
          []) as P;
    case 3:
      return (_DictstageValueEnumMap[reader.readStringOrNull(offset)] ??
          Stage.biblical) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _DictoriginEnumValueMap = {
  r'native': r'native',
  r'semitic': r'semitic',
  r'modern': r'modern',
};
const _DictoriginValueEnumMap = {
  r'native': Origin.native,
  r'semitic': Origin.semitic,
  r'modern': Origin.modern,
};
const _DictstageEnumValueMap = {
  r'biblical': r'biblical',
  r'mishnaic': r'mishnaic',
  r'medieval': r'medieval',
  r'modern': r'modern',
};
const _DictstageValueEnumMap = {
  r'biblical': Stage.biblical,
  r'mishnaic': Stage.mishnaic,
  r'medieval': Stage.medieval,
  r'modern': Stage.modern,
};

Id _dictGetId(Dict object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dictGetLinks(Dict object) {
  return [];
}

void _dictAttach(IsarCollection<dynamic> col, Id id, Dict object) {
  object.id = id;
}

extension DictQueryWhereSort on QueryBuilder<Dict, Dict, QWhere> {
  QueryBuilder<Dict, Dict, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DictQueryWhere on QueryBuilder<Dict, Dict, QWhereClause> {
  QueryBuilder<Dict, Dict, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Dict, Dict, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Dict, Dict, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Dict, Dict, QAfterWhereClause> idBetween(
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

extension DictQueryFilter on QueryBuilder<Dict, Dict, QFilterCondition> {
  QueryBuilder<Dict, Dict, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Dict, Dict, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Dict, Dict, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Dict, Dict, QAfterFilterCondition> originEqualTo(
    Origin value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> originGreaterThan(
    Origin value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> originLessThan(
    Origin value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> originBetween(
    Origin lower,
    Origin upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'origin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> originStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> originEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> originContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'origin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> originMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'origin',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> originIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'origin',
        value: '',
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> originIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'origin',
        value: '',
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> shoreshIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shoresh',
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> shoreshIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shoresh',
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> signaturesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'signatures',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> signaturesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'signatures',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> signaturesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'signatures',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> signaturesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'signatures',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> signaturesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'signatures',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> signaturesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'signatures',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> stageEqualTo(
    Stage value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> stageGreaterThan(
    Stage value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> stageLessThan(
    Stage value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> stageBetween(
    Stage lower,
    Stage upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> stageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> stageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> stageContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> stageMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> stageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stage',
        value: '',
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> stageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stage',
        value: '',
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> wordEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'word',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> wordGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'word',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> wordLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'word',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> wordBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'word',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> wordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'word',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> wordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'word',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> wordContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'word',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> wordMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'word',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> wordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'word',
        value: '',
      ));
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> wordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'word',
        value: '',
      ));
    });
  }
}

extension DictQueryObject on QueryBuilder<Dict, Dict, QFilterCondition> {
  QueryBuilder<Dict, Dict, QAfterFilterCondition> shoresh(
      FilterQuery<Shoresh> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'shoresh');
    });
  }

  QueryBuilder<Dict, Dict, QAfterFilterCondition> signaturesElement(
      FilterQuery<SurfaceSignature> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'signatures');
    });
  }
}

extension DictQueryLinks on QueryBuilder<Dict, Dict, QFilterCondition> {}

extension DictQuerySortBy on QueryBuilder<Dict, Dict, QSortBy> {
  QueryBuilder<Dict, Dict, QAfterSortBy> sortByOrigin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origin', Sort.asc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> sortByOriginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origin', Sort.desc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> sortByStage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stage', Sort.asc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> sortByStageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stage', Sort.desc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> sortByWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.asc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> sortByWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.desc);
    });
  }
}

extension DictQuerySortThenBy on QueryBuilder<Dict, Dict, QSortThenBy> {
  QueryBuilder<Dict, Dict, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> thenByOrigin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origin', Sort.asc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> thenByOriginDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'origin', Sort.desc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> thenByStage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stage', Sort.asc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> thenByStageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stage', Sort.desc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> thenByWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.asc);
    });
  }

  QueryBuilder<Dict, Dict, QAfterSortBy> thenByWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'word', Sort.desc);
    });
  }
}

extension DictQueryWhereDistinct on QueryBuilder<Dict, Dict, QDistinct> {
  QueryBuilder<Dict, Dict, QDistinct> distinctByOrigin(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'origin', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dict, Dict, QDistinct> distinctByStage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Dict, Dict, QDistinct> distinctByWord(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'word', caseSensitive: caseSensitive);
    });
  }
}

extension DictQueryProperty on QueryBuilder<Dict, Dict, QQueryProperty> {
  QueryBuilder<Dict, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Dict, Origin, QQueryOperations> originProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'origin');
    });
  }

  QueryBuilder<Dict, Shoresh?, QQueryOperations> shoreshProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shoresh');
    });
  }

  QueryBuilder<Dict, List<SurfaceSignature>, QQueryOperations>
      signaturesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'signatures');
    });
  }

  QueryBuilder<Dict, Stage, QQueryOperations> stageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stage');
    });
  }

  QueryBuilder<Dict, String, QQueryOperations> wordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'word');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ShoreshSchema = Schema(
  name: r'Shoresh',
  id: -4635695575484860914,
  properties: {
    r'root': PropertySchema(
      id: 0,
      name: r'root',
      type: IsarType.string,
    ),
    r'weak': PropertySchema(
      id: 1,
      name: r'weak',
      type: IsarType.bool,
    )
  },
  estimateSize: _shoreshEstimateSize,
  serialize: _shoreshSerialize,
  deserialize: _shoreshDeserialize,
  deserializeProp: _shoreshDeserializeProp,
);

int _shoreshEstimateSize(
  Shoresh object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.root.length * 3;
  return bytesCount;
}

void _shoreshSerialize(
  Shoresh object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.root);
  writer.writeBool(offsets[1], object.weak);
}

Shoresh _shoreshDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Shoresh();
  object.root = reader.readString(offsets[0]);
  object.weak = reader.readBool(offsets[1]);
  return object;
}

P _shoreshDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ShoreshQueryFilter
    on QueryBuilder<Shoresh, Shoresh, QFilterCondition> {
  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> rootEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'root',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> rootGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'root',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> rootLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'root',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> rootBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'root',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> rootStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'root',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> rootEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'root',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> rootContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'root',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> rootMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'root',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> rootIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'root',
        value: '',
      ));
    });
  }

  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> rootIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'root',
        value: '',
      ));
    });
  }

  QueryBuilder<Shoresh, Shoresh, QAfterFilterCondition> weakEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weak',
        value: value,
      ));
    });
  }
}

extension ShoreshQueryObject
    on QueryBuilder<Shoresh, Shoresh, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SurfaceSignatureSchema = Schema(
  name: r'SurfaceSignature',
  id: -8179197315517314897,
  properties: {
    r'indexSense': PropertySchema(
      id: 0,
      name: r'indexSense',
      type: IsarType.long,
    ),
    r'indexSignature': PropertySchema(
      id: 1,
      name: r'indexSignature',
      type: IsarType.long,
    ),
    r'surface': PropertySchema(
      id: 2,
      name: r'surface',
      type: IsarType.string,
    )
  },
  estimateSize: _surfaceSignatureEstimateSize,
  serialize: _surfaceSignatureSerialize,
  deserialize: _surfaceSignatureDeserialize,
  deserializeProp: _surfaceSignatureDeserializeProp,
);

int _surfaceSignatureEstimateSize(
  SurfaceSignature object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.surface.length * 3;
  return bytesCount;
}

void _surfaceSignatureSerialize(
  SurfaceSignature object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.indexSense);
  writer.writeLong(offsets[1], object.indexSignature);
  writer.writeString(offsets[2], object.surface);
}

SurfaceSignature _surfaceSignatureDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SurfaceSignature();
  object.indexSense = reader.readLong(offsets[0]);
  object.indexSignature = reader.readLong(offsets[1]);
  object.surface = reader.readString(offsets[2]);
  return object;
}

P _surfaceSignatureDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SurfaceSignatureQueryFilter
    on QueryBuilder<SurfaceSignature, SurfaceSignature, QFilterCondition> {
  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      indexSenseEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'indexSense',
        value: value,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      indexSenseGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'indexSense',
        value: value,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      indexSenseLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'indexSense',
        value: value,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      indexSenseBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'indexSense',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      indexSignatureEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'indexSignature',
        value: value,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      indexSignatureGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'indexSignature',
        value: value,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      indexSignatureLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'indexSignature',
        value: value,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      indexSignatureBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'indexSignature',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      surfaceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      surfaceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'surface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      surfaceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'surface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      surfaceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'surface',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      surfaceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'surface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      surfaceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'surface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      surfaceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'surface',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      surfaceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'surface',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      surfaceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'surface',
        value: '',
      ));
    });
  }

  QueryBuilder<SurfaceSignature, SurfaceSignature, QAfterFilterCondition>
      surfaceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'surface',
        value: '',
      ));
    });
  }
}

extension SurfaceSignatureQueryObject
    on QueryBuilder<SurfaceSignature, SurfaceSignature, QFilterCondition> {}
