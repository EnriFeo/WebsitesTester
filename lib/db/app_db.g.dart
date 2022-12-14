// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class WebsiteData extends DataClass implements Insertable<WebsiteData> {
  final int id;
  final String name;
  final String url;
  final String? img;
  final double systemGrade;
  final double googleGrade;
  const WebsiteData(
      {required this.id,
      required this.name,
      required this.url,
      this.img,
      required this.systemGrade,
      required this.googleGrade});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || img != null) {
      map['img'] = Variable<String>(img);
    }
    map['system_grade'] = Variable<double>(systemGrade);
    map['google_grade'] = Variable<double>(googleGrade);
    return map;
  }

  WebsiteCompanion toCompanion(bool nullToAbsent) {
    return WebsiteCompanion(
      id: Value(id),
      name: Value(name),
      url: Value(url),
      img: img == null && nullToAbsent ? const Value.absent() : Value(img),
      systemGrade: Value(systemGrade),
      googleGrade: Value(googleGrade),
    );
  }

  factory WebsiteData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WebsiteData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String>(json['url']),
      img: serializer.fromJson<String?>(json['img']),
      systemGrade: serializer.fromJson<double>(json['systemGrade']),
      googleGrade: serializer.fromJson<double>(json['googleGrade']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String>(url),
      'img': serializer.toJson<String?>(img),
      'systemGrade': serializer.toJson<double>(systemGrade),
      'googleGrade': serializer.toJson<double>(googleGrade),
    };
  }

  WebsiteData copyWith(
          {int? id,
          String? name,
          String? url,
          Value<String?> img = const Value.absent(),
          double? systemGrade,
          double? googleGrade}) =>
      WebsiteData(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        img: img.present ? img.value : this.img,
        systemGrade: systemGrade ?? this.systemGrade,
        googleGrade: googleGrade ?? this.googleGrade,
      );
  @override
  String toString() {
    return (StringBuffer('WebsiteData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('img: $img, ')
          ..write('systemGrade: $systemGrade, ')
          ..write('googleGrade: $googleGrade')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, url, img, systemGrade, googleGrade);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WebsiteData &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url &&
          other.img == this.img &&
          other.systemGrade == this.systemGrade &&
          other.googleGrade == this.googleGrade);
}

class WebsiteCompanion extends UpdateCompanion<WebsiteData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> url;
  final Value<String?> img;
  final Value<double> systemGrade;
  final Value<double> googleGrade;
  const WebsiteCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.img = const Value.absent(),
    this.systemGrade = const Value.absent(),
    this.googleGrade = const Value.absent(),
  });
  WebsiteCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String url,
    this.img = const Value.absent(),
    required double systemGrade,
    required double googleGrade,
  })  : name = Value(name),
        url = Value(url),
        systemGrade = Value(systemGrade),
        googleGrade = Value(googleGrade);
  static Insertable<WebsiteData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? url,
    Expression<String>? img,
    Expression<double>? systemGrade,
    Expression<double>? googleGrade,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
      if (img != null) 'img': img,
      if (systemGrade != null) 'system_grade': systemGrade,
      if (googleGrade != null) 'google_grade': googleGrade,
    });
  }

  WebsiteCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? url,
      Value<String?>? img,
      Value<double>? systemGrade,
      Value<double>? googleGrade}) {
    return WebsiteCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      img: img ?? this.img,
      systemGrade: systemGrade ?? this.systemGrade,
      googleGrade: googleGrade ?? this.googleGrade,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (img.present) {
      map['img'] = Variable<String>(img.value);
    }
    if (systemGrade.present) {
      map['system_grade'] = Variable<double>(systemGrade.value);
    }
    if (googleGrade.present) {
      map['google_grade'] = Variable<double>(googleGrade.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WebsiteCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('img: $img, ')
          ..write('systemGrade: $systemGrade, ')
          ..write('googleGrade: $googleGrade')
          ..write(')'))
        .toString();
  }
}

class $WebsiteTable extends Website with TableInfo<$WebsiteTable, WebsiteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WebsiteTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _imgMeta = const VerificationMeta('img');
  @override
  late final GeneratedColumn<String> img = GeneratedColumn<String>(
      'img', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _systemGradeMeta =
      const VerificationMeta('systemGrade');
  @override
  late final GeneratedColumn<double> systemGrade = GeneratedColumn<double>(
      'system_grade', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _googleGradeMeta =
      const VerificationMeta('googleGrade');
  @override
  late final GeneratedColumn<double> googleGrade = GeneratedColumn<double>(
      'google_grade', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, url, img, systemGrade, googleGrade];
  @override
  String get aliasedName => _alias ?? 'website';
  @override
  String get actualTableName => 'website';
  @override
  VerificationContext validateIntegrity(Insertable<WebsiteData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('img')) {
      context.handle(
          _imgMeta, img.isAcceptableOrUnknown(data['img']!, _imgMeta));
    }
    if (data.containsKey('system_grade')) {
      context.handle(
          _systemGradeMeta,
          systemGrade.isAcceptableOrUnknown(
              data['system_grade']!, _systemGradeMeta));
    } else if (isInserting) {
      context.missing(_systemGradeMeta);
    }
    if (data.containsKey('google_grade')) {
      context.handle(
          _googleGradeMeta,
          googleGrade.isAcceptableOrUnknown(
              data['google_grade']!, _googleGradeMeta));
    } else if (isInserting) {
      context.missing(_googleGradeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WebsiteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WebsiteData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      url: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      img: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}img']),
      systemGrade: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}system_grade'])!,
      googleGrade: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}google_grade'])!,
    );
  }

  @override
  $WebsiteTable createAlias(String alias) {
    return $WebsiteTable(attachedDatabase, alias);
  }
}

abstract class _$AppDB extends GeneratedDatabase {
  _$AppDB(QueryExecutor e) : super(e);
  late final $WebsiteTable website = $WebsiteTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [website];
}
