// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBookCollection on Isar {
  IsarCollection<Book> get books => this.collection();
}

const BookSchema = CollectionSchema(
  name: r'Book',
  id: 4089735379470416465,
  properties: {
    r'chapters': PropertySchema(
      id: 0,
      name: r'chapters',
      type: IsarType.objectList,
      target: r'ChaptersMetaData',
    ),
    r'hash': PropertySchema(
      id: 1,
      name: r'hash',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'pages': PropertySchema(
      id: 3,
      name: r'pages',
      type: IsarType.objectList,
      target: r'PageData',
    ),
    r'pagesMetaData': PropertySchema(
      id: 4,
      name: r'pagesMetaData',
      type: IsarType.stringList,
    )
  },
  estimateSize: _bookEstimateSize,
  serialize: _bookSerialize,
  deserialize: _bookDeserialize,
  deserializeProp: _bookDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'ChaptersMetaData': ChaptersMetaDataSchema,
    r'PageData': PageDataSchema
  },
  getId: _bookGetId,
  getLinks: _bookGetLinks,
  attach: _bookAttach,
  version: '3.1.0+1',
);

int _bookEstimateSize(
  Book object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.chapters.length * 3;
  {
    final offsets = allOffsets[ChaptersMetaData]!;
    for (var i = 0; i < object.chapters.length; i++) {
      final value = object.chapters[i];
      bytesCount +=
          ChaptersMetaDataSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.hash.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.pages.length * 3;
  {
    final offsets = allOffsets[PageData]!;
    for (var i = 0; i < object.pages.length; i++) {
      final value = object.pages[i];
      bytesCount += PageDataSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.pagesMetaData.length * 3;
  {
    for (var i = 0; i < object.pagesMetaData.length; i++) {
      final value = object.pagesMetaData[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _bookSerialize(
  Book object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<ChaptersMetaData>(
    offsets[0],
    allOffsets,
    ChaptersMetaDataSchema.serialize,
    object.chapters,
  );
  writer.writeString(offsets[1], object.hash);
  writer.writeString(offsets[2], object.name);
  writer.writeObjectList<PageData>(
    offsets[3],
    allOffsets,
    PageDataSchema.serialize,
    object.pages,
  );
  writer.writeStringList(offsets[4], object.pagesMetaData);
}

Book _bookDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Book(
    chapters: reader.readObjectList<ChaptersMetaData>(
          offsets[0],
          ChaptersMetaDataSchema.deserialize,
          allOffsets,
          ChaptersMetaData(),
        ) ??
        [],
    hash: reader.readString(offsets[1]),
    name: reader.readString(offsets[2]),
    pages: reader.readObjectList<PageData>(
          offsets[3],
          PageDataSchema.deserialize,
          allOffsets,
          PageData(),
        ) ??
        [],
    pagesMetaData: reader.readStringList(offsets[4]) ?? [],
  );
  object.id = id;
  return object;
}

P _bookDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<ChaptersMetaData>(
            offset,
            ChaptersMetaDataSchema.deserialize,
            allOffsets,
            ChaptersMetaData(),
          ) ??
          []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readObjectList<PageData>(
            offset,
            PageDataSchema.deserialize,
            allOffsets,
            PageData(),
          ) ??
          []) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bookGetId(Book object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bookGetLinks(Book object) {
  return [];
}

void _bookAttach(IsarCollection<dynamic> col, Id id, Book object) {
  object.id = id;
}

extension BookQueryWhereSort on QueryBuilder<Book, Book, QWhere> {
  QueryBuilder<Book, Book, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BookQueryWhere on QueryBuilder<Book, Book, QWhereClause> {
  QueryBuilder<Book, Book, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Book, Book, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Book, Book, QAfterWhereClause> idBetween(
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

extension BookQueryFilter on QueryBuilder<Book, Book, QFilterCondition> {
  QueryBuilder<Book, Book, QAfterFilterCondition> chaptersLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chapters',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> chaptersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chapters',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> chaptersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chapters',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> chaptersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chapters',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> chaptersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chapters',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> chaptersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chapters',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> hashEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> hashGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> hashLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> hashBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> hashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> hashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> hashContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> hashMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> hashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hash',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> hashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hash',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Book, Book, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Book, Book, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Book, Book, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Book, Book, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Book, Book, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Book, Book, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Book, Book, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Book, Book, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Book, Book, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pagesMetaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition>
      pagesMetaDataElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pagesMetaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pagesMetaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pagesMetaData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition>
      pagesMetaDataElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pagesMetaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pagesMetaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pagesMetaData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pagesMetaData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition>
      pagesMetaDataElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pagesMetaData',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition>
      pagesMetaDataElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pagesMetaData',
        value: '',
      ));
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pagesMetaData',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pagesMetaData',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pagesMetaData',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pagesMetaData',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition>
      pagesMetaDataLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pagesMetaData',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesMetaDataLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pagesMetaData',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension BookQueryObject on QueryBuilder<Book, Book, QFilterCondition> {
  QueryBuilder<Book, Book, QAfterFilterCondition> chaptersElement(
      FilterQuery<ChaptersMetaData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'chapters');
    });
  }

  QueryBuilder<Book, Book, QAfterFilterCondition> pagesElement(
      FilterQuery<PageData> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pages');
    });
  }
}

extension BookQueryLinks on QueryBuilder<Book, Book, QFilterCondition> {}

extension BookQuerySortBy on QueryBuilder<Book, Book, QSortBy> {
  QueryBuilder<Book, Book, QAfterSortBy> sortByHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension BookQuerySortThenBy on QueryBuilder<Book, Book, QSortThenBy> {
  QueryBuilder<Book, Book, QAfterSortBy> thenByHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hash', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Book, Book, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension BookQueryWhereDistinct on QueryBuilder<Book, Book, QDistinct> {
  QueryBuilder<Book, Book, QDistinct> distinctByHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Book, Book, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Book, Book, QDistinct> distinctByPagesMetaData() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pagesMetaData');
    });
  }
}

extension BookQueryProperty on QueryBuilder<Book, Book, QQueryProperty> {
  QueryBuilder<Book, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Book, List<ChaptersMetaData>, QQueryOperations>
      chaptersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapters');
    });
  }

  QueryBuilder<Book, String, QQueryOperations> hashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hash');
    });
  }

  QueryBuilder<Book, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Book, List<PageData>, QQueryOperations> pagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pages');
    });
  }

  QueryBuilder<Book, List<String>, QQueryOperations> pagesMetaDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pagesMetaData');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ChaptersMetaDataSchema = Schema(
  name: r'ChaptersMetaData',
  id: 318356896372836042,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'range': PropertySchema(
      id: 1,
      name: r'range',
      type: IsarType.longList,
    )
  },
  estimateSize: _chaptersMetaDataEstimateSize,
  serialize: _chaptersMetaDataSerialize,
  deserialize: _chaptersMetaDataDeserialize,
  deserializeProp: _chaptersMetaDataDeserializeProp,
);

int _chaptersMetaDataEstimateSize(
  ChaptersMetaData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.range.length * 8;
  return bytesCount;
}

void _chaptersMetaDataSerialize(
  ChaptersMetaData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeLongList(offsets[1], object.range);
}

ChaptersMetaData _chaptersMetaDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChaptersMetaData(
    reader.readStringOrNull(offsets[0]) ?? "",
    reader.readLongList(offsets[1]) ?? const [],
  );
  return object;
}

P _chaptersMetaDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 1:
      return (reader.readLongList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ChaptersMetaDataQueryFilter
    on QueryBuilder<ChaptersMetaData, ChaptersMetaData, QFilterCondition> {
  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      rangeElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'range',
        value: value,
      ));
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      rangeElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'range',
        value: value,
      ));
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      rangeElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'range',
        value: value,
      ));
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      rangeElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'range',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      rangeLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'range',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      rangeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'range',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      rangeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'range',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      rangeLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'range',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      rangeLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'range',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ChaptersMetaData, ChaptersMetaData, QAfterFilterCondition>
      rangeLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'range',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ChaptersMetaDataQueryObject
    on QueryBuilder<ChaptersMetaData, ChaptersMetaData, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const PageDataSchema = Schema(
  name: r'PageData',
  id: 106743378440469014,
  properties: {
    r'verses': PropertySchema(
      id: 0,
      name: r'verses',
      type: IsarType.stringList,
    )
  },
  estimateSize: _pageDataEstimateSize,
  serialize: _pageDataSerialize,
  deserialize: _pageDataDeserialize,
  deserializeProp: _pageDataDeserializeProp,
);

int _pageDataEstimateSize(
  PageData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.verses.length * 3;
  {
    for (var i = 0; i < object.verses.length; i++) {
      final value = object.verses[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _pageDataSerialize(
  PageData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.verses);
}

PageData _pageDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PageData(
    reader.readStringList(offsets[0]) ?? const [],
  );
  return object;
}

P _pageDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension PageDataQueryFilter
    on QueryBuilder<PageData, PageData, QFilterCondition> {
  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition>
      versesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition>
      versesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verses',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verses',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition>
      versesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verses',
        value: '',
      ));
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition>
      versesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verses',
        value: '',
      ));
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'verses',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'verses',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'verses',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'verses',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition>
      versesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'verses',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PageData, PageData, QAfterFilterCondition> versesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'verses',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PageDataQueryObject
    on QueryBuilder<PageData, PageData, QFilterCondition> {}
