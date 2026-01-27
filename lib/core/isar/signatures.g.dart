// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signatures.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSignatureCollection on Isar {
  IsarCollection<Signature> get signatures => this.collection();
}

const SignatureSchema = CollectionSchema(
  name: r'Signature',
  id: 1833548860252757049,
  properties: {
    r'abstractLexicalTraits': PropertySchema(
      id: 0,
      name: r'abstractLexicalTraits',
      type: IsarType.object,
      target: r'LexicalTraits',
    ),
    r'categoricalTraits': PropertySchema(
      id: 1,
      name: r'categoricalTraits',
      type: IsarType.byteList,
    ),
    r'internalMorphologicalTraits': PropertySchema(
      id: 2,
      name: r'internalMorphologicalTraits',
      type: IsarType.object,
      target: r'MorphologicalTraits',
    )
  },
  estimateSize: _signatureEstimateSize,
  serialize: _signatureSerialize,
  deserialize: _signatureDeserialize,
  deserializeProp: _signatureDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'MorphologicalTraits': MorphologicalTraitsSchema,
    r'Mishkal': MishkalSchema,
    r'LexicalTraits': LexicalTraitsSchema
  },
  getId: _signatureGetId,
  getLinks: _signatureGetLinks,
  attach: _signatureAttach,
  version: '3.1.0+1',
);

int _signatureEstimateSize(
  Signature object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.abstractLexicalTraits;
    if (value != null) {
      bytesCount += 3 +
          LexicalTraitsSchema.estimateSize(
              value, allOffsets[LexicalTraits]!, allOffsets);
    }
  }
  bytesCount += 3 + object.categoricalTraits.length;
  {
    final value = object.internalMorphologicalTraits;
    if (value != null) {
      bytesCount += 3 +
          MorphologicalTraitsSchema.estimateSize(
              value, allOffsets[MorphologicalTraits]!, allOffsets);
    }
  }
  return bytesCount;
}

void _signatureSerialize(
  Signature object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<LexicalTraits>(
    offsets[0],
    allOffsets,
    LexicalTraitsSchema.serialize,
    object.abstractLexicalTraits,
  );
  writer.writeByteList(offsets[1], object.categoricalTraits);
  writer.writeObject<MorphologicalTraits>(
    offsets[2],
    allOffsets,
    MorphologicalTraitsSchema.serialize,
    object.internalMorphologicalTraits,
  );
}

Signature _signatureDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Signature(
    abstractLexicalTraits: reader.readObjectOrNull<LexicalTraits>(
      offsets[0],
      LexicalTraitsSchema.deserialize,
      allOffsets,
    ),
    categoricalTraits: reader.readByteList(offsets[1]) ?? [],
    internalMorphologicalTraits: reader.readObjectOrNull<MorphologicalTraits>(
      offsets[2],
      MorphologicalTraitsSchema.deserialize,
      allOffsets,
    ),
  );
  object.id = id;
  return object;
}

P _signatureDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<LexicalTraits>(
        offset,
        LexicalTraitsSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readByteList(offset) ?? []) as P;
    case 2:
      return (reader.readObjectOrNull<MorphologicalTraits>(
        offset,
        MorphologicalTraitsSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _signatureGetId(Signature object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _signatureGetLinks(Signature object) {
  return [];
}

void _signatureAttach(IsarCollection<dynamic> col, Id id, Signature object) {
  object.id = id;
}

extension SignatureQueryWhereSort
    on QueryBuilder<Signature, Signature, QWhere> {
  QueryBuilder<Signature, Signature, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SignatureQueryWhere
    on QueryBuilder<Signature, Signature, QWhereClause> {
  QueryBuilder<Signature, Signature, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Signature, Signature, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Signature, Signature, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Signature, Signature, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Signature, Signature, QAfterWhereClause> idBetween(
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

extension SignatureQueryFilter
    on QueryBuilder<Signature, Signature, QFilterCondition> {
  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      abstractLexicalTraitsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'abstractLexicalTraits',
      ));
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      abstractLexicalTraitsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'abstractLexicalTraits',
      ));
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      categoricalTraitsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoricalTraits',
        value: value,
      ));
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      categoricalTraitsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoricalTraits',
        value: value,
      ));
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      categoricalTraitsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoricalTraits',
        value: value,
      ));
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      categoricalTraitsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoricalTraits',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      categoricalTraitsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categoricalTraits',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      categoricalTraitsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categoricalTraits',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      categoricalTraitsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categoricalTraits',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      categoricalTraitsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categoricalTraits',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      categoricalTraitsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categoricalTraits',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      categoricalTraitsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'categoricalTraits',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Signature, Signature, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Signature, Signature, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      internalMorphologicalTraitsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'internalMorphologicalTraits',
      ));
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      internalMorphologicalTraitsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'internalMorphologicalTraits',
      ));
    });
  }
}

extension SignatureQueryObject
    on QueryBuilder<Signature, Signature, QFilterCondition> {
  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      abstractLexicalTraits(FilterQuery<LexicalTraits> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'abstractLexicalTraits');
    });
  }

  QueryBuilder<Signature, Signature, QAfterFilterCondition>
      internalMorphologicalTraits(FilterQuery<MorphologicalTraits> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'internalMorphologicalTraits');
    });
  }
}

extension SignatureQueryLinks
    on QueryBuilder<Signature, Signature, QFilterCondition> {}

extension SignatureQuerySortBy on QueryBuilder<Signature, Signature, QSortBy> {}

extension SignatureQuerySortThenBy
    on QueryBuilder<Signature, Signature, QSortThenBy> {
  QueryBuilder<Signature, Signature, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Signature, Signature, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension SignatureQueryWhereDistinct
    on QueryBuilder<Signature, Signature, QDistinct> {
  QueryBuilder<Signature, Signature, QDistinct> distinctByCategoricalTraits() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoricalTraits');
    });
  }
}

extension SignatureQueryProperty
    on QueryBuilder<Signature, Signature, QQueryProperty> {
  QueryBuilder<Signature, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Signature, LexicalTraits?, QQueryOperations>
      abstractLexicalTraitsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'abstractLexicalTraits');
    });
  }

  QueryBuilder<Signature, List<int>, QQueryOperations>
      categoricalTraitsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoricalTraits');
    });
  }

  QueryBuilder<Signature, MorphologicalTraits?, QQueryOperations>
      internalMorphologicalTraitsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'internalMorphologicalTraits');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MishkalSchema = Schema(
  name: r'Mishkal',
  id: 1840246030249294734,
  properties: {
    r'pattern': PropertySchema(
      id: 0,
      name: r'pattern',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 1,
      name: r'type',
      type: IsarType.string,
      enumMap: _MishkaltypeEnumValueMap,
    )
  },
  estimateSize: _mishkalEstimateSize,
  serialize: _mishkalSerialize,
  deserialize: _mishkalDeserialize,
  deserializeProp: _mishkalDeserializeProp,
);

int _mishkalEstimateSize(
  Mishkal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.pattern.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _mishkalSerialize(
  Mishkal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.pattern);
  writer.writeString(offsets[1], object.type.name);
}

Mishkal _mishkalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Mishkal();
  object.pattern = reader.readString(offsets[0]);
  object.type = _MishkaltypeValueEnumMap[reader.readStringOrNull(offsets[1])] ??
      MishkalType.verbal;
  return object;
}

P _mishkalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (_MishkaltypeValueEnumMap[reader.readStringOrNull(offset)] ??
          MishkalType.verbal) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MishkaltypeEnumValueMap = {
  r'verbal': r'verbal',
  r'nominal': r'nominal',
};
const _MishkaltypeValueEnumMap = {
  r'verbal': MishkalType.verbal,
  r'nominal': MishkalType.nominal,
};

extension MishkalQueryFilter
    on QueryBuilder<Mishkal, Mishkal, QFilterCondition> {
  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> patternEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> patternGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> patternLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> patternBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pattern',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> patternStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> patternEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> patternContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pattern',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> patternMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pattern',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> patternIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pattern',
        value: '',
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> patternIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pattern',
        value: '',
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> typeEqualTo(
    MishkalType value, {
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

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> typeGreaterThan(
    MishkalType value, {
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

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> typeLessThan(
    MishkalType value, {
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

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> typeBetween(
    MishkalType lower,
    MishkalType upper, {
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

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> typeStartsWith(
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

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> typeEndsWith(
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

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> typeContains(
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

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> typeMatches(
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

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Mishkal, Mishkal, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension MishkalQueryObject
    on QueryBuilder<Mishkal, Mishkal, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MorphologicalTraitsSchema = Schema(
  name: r'MorphologicalTraits',
  id: 7481878518307199282,
  properties: {
    r'binyan': PropertySchema(
      id: 0,
      name: r'binyan',
      type: IsarType.string,
      enumMap: _MorphologicalTraitsbinyanEnumValueMap,
    ),
    r'form': PropertySchema(
      id: 1,
      name: r'form',
      type: IsarType.string,
      enumMap: _MorphologicalTraitsformEnumValueMap,
    ),
    r'gender': PropertySchema(
      id: 2,
      name: r'gender',
      type: IsarType.string,
      enumMap: _MorphologicalTraitsgenderEnumValueMap,
    ),
    r'mishqal': PropertySchema(
      id: 3,
      name: r'mishqal',
      type: IsarType.object,
      target: r'Mishkal',
    ),
    r'number': PropertySchema(
      id: 4,
      name: r'number',
      type: IsarType.string,
      enumMap: _MorphologicalTraitsnumberEnumValueMap,
    ),
    r'person': PropertySchema(
      id: 5,
      name: r'person',
      type: IsarType.string,
      enumMap: _MorphologicalTraitspersonEnumValueMap,
    ),
    r'tense': PropertySchema(
      id: 6,
      name: r'tense',
      type: IsarType.string,
      enumMap: _MorphologicalTraitstenseEnumValueMap,
    )
  },
  estimateSize: _morphologicalTraitsEstimateSize,
  serialize: _morphologicalTraitsSerialize,
  deserialize: _morphologicalTraitsDeserialize,
  deserializeProp: _morphologicalTraitsDeserializeProp,
);

int _morphologicalTraitsEstimateSize(
  MorphologicalTraits object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.binyan;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.form;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.gender;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.mishqal;
    if (value != null) {
      bytesCount += 3 +
          MishkalSchema.estimateSize(value, allOffsets[Mishkal]!, allOffsets);
    }
  }
  {
    final value = object.number;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.person;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.tense;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _morphologicalTraitsSerialize(
  MorphologicalTraits object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.binyan?.name);
  writer.writeString(offsets[1], object.form?.name);
  writer.writeString(offsets[2], object.gender?.name);
  writer.writeObject<Mishkal>(
    offsets[3],
    allOffsets,
    MishkalSchema.serialize,
    object.mishqal,
  );
  writer.writeString(offsets[4], object.number?.name);
  writer.writeString(offsets[5], object.person?.name);
  writer.writeString(offsets[6], object.tense?.name);
}

MorphologicalTraits _morphologicalTraitsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MorphologicalTraits();
  object.binyan = _MorphologicalTraitsbinyanValueEnumMap[
      reader.readStringOrNull(offsets[0])];
  object.form =
      _MorphologicalTraitsformValueEnumMap[reader.readStringOrNull(offsets[1])];
  object.gender = _MorphologicalTraitsgenderValueEnumMap[
      reader.readStringOrNull(offsets[2])];
  object.mishqal = reader.readObjectOrNull<Mishkal>(
    offsets[3],
    MishkalSchema.deserialize,
    allOffsets,
  );
  object.number = _MorphologicalTraitsnumberValueEnumMap[
      reader.readStringOrNull(offsets[4])];
  object.person = _MorphologicalTraitspersonValueEnumMap[
      reader.readStringOrNull(offsets[5])];
  object.tense = _MorphologicalTraitstenseValueEnumMap[
      reader.readStringOrNull(offsets[6])];
  return object;
}

P _morphologicalTraitsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_MorphologicalTraitsbinyanValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 1:
      return (_MorphologicalTraitsformValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 2:
      return (_MorphologicalTraitsgenderValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 3:
      return (reader.readObjectOrNull<Mishkal>(
        offset,
        MishkalSchema.deserialize,
        allOffsets,
      )) as P;
    case 4:
      return (_MorphologicalTraitsnumberValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 5:
      return (_MorphologicalTraitspersonValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 6:
      return (_MorphologicalTraitstenseValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MorphologicalTraitsbinyanEnumValueMap = {
  r'qal': r'qal',
  r'nifal': r'nifal',
  r'piel': r'piel',
  r'pual': r'pual',
  r'hifil': r'hifil',
  r'hufal': r'hufal',
  r'hitpael': r'hitpael',
};
const _MorphologicalTraitsbinyanValueEnumMap = {
  r'qal': Binyan.qal,
  r'nifal': Binyan.nifal,
  r'piel': Binyan.piel,
  r'pual': Binyan.pual,
  r'hifil': Binyan.hifil,
  r'hufal': Binyan.hufal,
  r'hitpael': Binyan.hitpael,
};
const _MorphologicalTraitsformEnumValueMap = {
  r'perfect': r'perfect',
  r'imperfect': r'imperfect',
  r'participle': r'participle',
  r'infinitive': r'infinitive',
  r'imperative': r'imperative',
};
const _MorphologicalTraitsformValueEnumMap = {
  r'perfect': VerbForm.perfect,
  r'imperfect': VerbForm.imperfect,
  r'participle': VerbForm.participle,
  r'infinitive': VerbForm.infinitive,
  r'imperative': VerbForm.imperative,
};
const _MorphologicalTraitsgenderEnumValueMap = {
  r'masculine': r'masculine',
  r'feminine': r'feminine',
  r'neutral': r'neutral',
};
const _MorphologicalTraitsgenderValueEnumMap = {
  r'masculine': Gender.masculine,
  r'feminine': Gender.feminine,
  r'neutral': Gender.neutral,
};
const _MorphologicalTraitsnumberEnumValueMap = {
  r'plural': r'plural',
  r'singular': r'singular',
  r'dual': r'dual',
};
const _MorphologicalTraitsnumberValueEnumMap = {
  r'plural': Number.plural,
  r'singular': Number.singular,
  r'dual': Number.dual,
};
const _MorphologicalTraitspersonEnumValueMap = {
  r'first': r'first',
  r'second': r'second',
  r'third': r'third',
};
const _MorphologicalTraitspersonValueEnumMap = {
  r'first': Person.first,
  r'second': Person.second,
  r'third': Person.third,
};
const _MorphologicalTraitstenseEnumValueMap = {
  r'past': r'past',
  r'present': r'present',
  r'future': r'future',
};
const _MorphologicalTraitstenseValueEnumMap = {
  r'past': VerbTense.past,
  r'present': VerbTense.present,
  r'future': VerbTense.future,
};

extension MorphologicalTraitsQueryFilter on QueryBuilder<MorphologicalTraits,
    MorphologicalTraits, QFilterCondition> {
  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'binyan',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'binyan',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanEqualTo(
    Binyan? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'binyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanGreaterThan(
    Binyan? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'binyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanLessThan(
    Binyan? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'binyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanBetween(
    Binyan? lower,
    Binyan? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'binyan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'binyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'binyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'binyan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'binyan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'binyan',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      binyanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'binyan',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'form',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'form',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formEqualTo(
    VerbForm? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'form',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formGreaterThan(
    VerbForm? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'form',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formLessThan(
    VerbForm? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'form',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formBetween(
    VerbForm? lower,
    VerbForm? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'form',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'form',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'form',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'form',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'form',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'form',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      formIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'form',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gender',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gender',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderEqualTo(
    Gender? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderGreaterThan(
    Gender? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderLessThan(
    Gender? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderBetween(
    Gender? lower,
    Gender? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      genderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gender',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      mishqalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mishqal',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      mishqalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mishqal',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'number',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'number',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberEqualTo(
    Number? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberGreaterThan(
    Number? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberLessThan(
    Number? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberBetween(
    Number? lower,
    Number? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'number',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      numberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'number',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'person',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'person',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personEqualTo(
    Person? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'person',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personGreaterThan(
    Person? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'person',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personLessThan(
    Person? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'person',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personBetween(
    Person? lower,
    Person? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'person',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'person',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'person',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'person',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'person',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'person',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      personIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'person',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tense',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tense',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseEqualTo(
    VerbTense? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseGreaterThan(
    VerbTense? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseLessThan(
    VerbTense? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseBetween(
    VerbTense? lower,
    VerbTense? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tense',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tense',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tense',
        value: '',
      ));
    });
  }

  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      tenseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tense',
        value: '',
      ));
    });
  }
}

extension MorphologicalTraitsQueryObject on QueryBuilder<MorphologicalTraits,
    MorphologicalTraits, QFilterCondition> {
  QueryBuilder<MorphologicalTraits, MorphologicalTraits, QAfterFilterCondition>
      mishqal(FilterQuery<Mishkal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'mishqal');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LexicalTraitsSchema = Schema(
  name: r'LexicalTraits',
  id: 7131315092284696621,
  properties: {
    r'grammaticalState': PropertySchema(
      id: 0,
      name: r'grammaticalState',
      type: IsarType.string,
      enumMap: _LexicalTraitsgrammaticalStateEnumValueMap,
    )
  },
  estimateSize: _lexicalTraitsEstimateSize,
  serialize: _lexicalTraitsSerialize,
  deserialize: _lexicalTraitsDeserialize,
  deserializeProp: _lexicalTraitsDeserializeProp,
);

int _lexicalTraitsEstimateSize(
  LexicalTraits object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.grammaticalState;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _lexicalTraitsSerialize(
  LexicalTraits object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.grammaticalState?.name);
}

LexicalTraits _lexicalTraitsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LexicalTraits();
  object.grammaticalState = _LexicalTraitsgrammaticalStateValueEnumMap[
      reader.readStringOrNull(offsets[0])];
  return object;
}

P _lexicalTraitsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_LexicalTraitsgrammaticalStateValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LexicalTraitsgrammaticalStateEnumValueMap = {
  r'absolute': r'absolute',
  r'construct': r'construct',
  r'suffixState': r'suffixState',
};
const _LexicalTraitsgrammaticalStateValueEnumMap = {
  r'absolute': GrammaticalState.absolute,
  r'construct': GrammaticalState.construct,
  r'suffixState': GrammaticalState.suffixState,
};

extension LexicalTraitsQueryFilter
    on QueryBuilder<LexicalTraits, LexicalTraits, QFilterCondition> {
  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'grammaticalState',
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'grammaticalState',
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateEqualTo(
    GrammaticalState? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grammaticalState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateGreaterThan(
    GrammaticalState? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grammaticalState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateLessThan(
    GrammaticalState? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grammaticalState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateBetween(
    GrammaticalState? lower,
    GrammaticalState? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grammaticalState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'grammaticalState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'grammaticalState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'grammaticalState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'grammaticalState',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grammaticalState',
        value: '',
      ));
    });
  }

  QueryBuilder<LexicalTraits, LexicalTraits, QAfterFilterCondition>
      grammaticalStateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'grammaticalState',
        value: '',
      ));
    });
  }
}

extension LexicalTraitsQueryObject
    on QueryBuilder<LexicalTraits, LexicalTraits, QFilterCondition> {}
