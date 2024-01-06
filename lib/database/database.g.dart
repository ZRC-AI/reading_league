// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SeminarsTable extends Seminars with TableInfo<$SeminarsTable, Seminar> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeminarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _initiatorMeta =
      const VerificationMeta('initiator');
  @override
  late final GeneratedColumn<String> initiator = GeneratedColumn<String>(
      'initiator', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, initiator, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'seminars';
  @override
  VerificationContext validateIntegrity(Insertable<Seminar> instance,
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
    if (data.containsKey('initiator')) {
      context.handle(_initiatorMeta,
          initiator.isAcceptableOrUnknown(data['initiator']!, _initiatorMeta));
    } else if (isInserting) {
      context.missing(_initiatorMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Seminar map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Seminar(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      initiator: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}initiator'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $SeminarsTable createAlias(String alias) {
    return $SeminarsTable(attachedDatabase, alias);
  }
}

class Seminar extends DataClass implements Insertable<Seminar> {
  final int id;
  final String name;
  final String initiator;
  final String description;
  const Seminar(
      {required this.id,
      required this.name,
      required this.initiator,
      required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['initiator'] = Variable<String>(initiator);
    map['description'] = Variable<String>(description);
    return map;
  }

  SeminarsCompanion toCompanion(bool nullToAbsent) {
    return SeminarsCompanion(
      id: Value(id),
      name: Value(name),
      initiator: Value(initiator),
      description: Value(description),
    );
  }

  factory Seminar.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Seminar(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      initiator: serializer.fromJson<String>(json['initiator']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'initiator': serializer.toJson<String>(initiator),
      'description': serializer.toJson<String>(description),
    };
  }

  Seminar copyWith(
          {int? id, String? name, String? initiator, String? description}) =>
      Seminar(
        id: id ?? this.id,
        name: name ?? this.name,
        initiator: initiator ?? this.initiator,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Seminar(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('initiator: $initiator, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, initiator, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Seminar &&
          other.id == this.id &&
          other.name == this.name &&
          other.initiator == this.initiator &&
          other.description == this.description);
}

class SeminarsCompanion extends UpdateCompanion<Seminar> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> initiator;
  final Value<String> description;
  const SeminarsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.initiator = const Value.absent(),
    this.description = const Value.absent(),
  });
  SeminarsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String initiator,
    required String description,
  })  : name = Value(name),
        initiator = Value(initiator),
        description = Value(description);
  static Insertable<Seminar> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? initiator,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (initiator != null) 'initiator': initiator,
      if (description != null) 'description': description,
    });
  }

  SeminarsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? initiator,
      Value<String>? description}) {
    return SeminarsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      initiator: initiator ?? this.initiator,
      description: description ?? this.description,
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
    if (initiator.present) {
      map['initiator'] = Variable<String>(initiator.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeminarsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('initiator: $initiator, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $AudioPathsTable extends AudioPaths
    with TableInfo<$AudioPathsTable, AudioPath> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AudioPathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _seminarMeta =
      const VerificationMeta('seminar');
  @override
  late final GeneratedColumn<String> seminar = GeneratedColumn<String>(
      'seminar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _audiopathMeta =
      const VerificationMeta('audiopath');
  @override
  late final GeneratedColumn<String> audiopath = GeneratedColumn<String>(
      'audiopath', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, seminar, audiopath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audio_paths';
  @override
  VerificationContext validateIntegrity(Insertable<AudioPath> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('seminar')) {
      context.handle(_seminarMeta,
          seminar.isAcceptableOrUnknown(data['seminar']!, _seminarMeta));
    } else if (isInserting) {
      context.missing(_seminarMeta);
    }
    if (data.containsKey('audiopath')) {
      context.handle(_audiopathMeta,
          audiopath.isAcceptableOrUnknown(data['audiopath']!, _audiopathMeta));
    } else if (isInserting) {
      context.missing(_audiopathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AudioPath map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AudioPath(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      seminar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seminar'])!,
      audiopath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audiopath'])!,
    );
  }

  @override
  $AudioPathsTable createAlias(String alias) {
    return $AudioPathsTable(attachedDatabase, alias);
  }
}

class AudioPath extends DataClass implements Insertable<AudioPath> {
  final int id;
  final String seminar;
  final String audiopath;
  const AudioPath(
      {required this.id, required this.seminar, required this.audiopath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['seminar'] = Variable<String>(seminar);
    map['audiopath'] = Variable<String>(audiopath);
    return map;
  }

  AudioPathsCompanion toCompanion(bool nullToAbsent) {
    return AudioPathsCompanion(
      id: Value(id),
      seminar: Value(seminar),
      audiopath: Value(audiopath),
    );
  }

  factory AudioPath.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AudioPath(
      id: serializer.fromJson<int>(json['id']),
      seminar: serializer.fromJson<String>(json['seminar']),
      audiopath: serializer.fromJson<String>(json['audiopath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seminar': serializer.toJson<String>(seminar),
      'audiopath': serializer.toJson<String>(audiopath),
    };
  }

  AudioPath copyWith({int? id, String? seminar, String? audiopath}) =>
      AudioPath(
        id: id ?? this.id,
        seminar: seminar ?? this.seminar,
        audiopath: audiopath ?? this.audiopath,
      );
  @override
  String toString() {
    return (StringBuffer('AudioPath(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('audiopath: $audiopath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, seminar, audiopath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AudioPath &&
          other.id == this.id &&
          other.seminar == this.seminar &&
          other.audiopath == this.audiopath);
}

class AudioPathsCompanion extends UpdateCompanion<AudioPath> {
  final Value<int> id;
  final Value<String> seminar;
  final Value<String> audiopath;
  const AudioPathsCompanion({
    this.id = const Value.absent(),
    this.seminar = const Value.absent(),
    this.audiopath = const Value.absent(),
  });
  AudioPathsCompanion.insert({
    this.id = const Value.absent(),
    required String seminar,
    required String audiopath,
  })  : seminar = Value(seminar),
        audiopath = Value(audiopath);
  static Insertable<AudioPath> custom({
    Expression<int>? id,
    Expression<String>? seminar,
    Expression<String>? audiopath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seminar != null) 'seminar': seminar,
      if (audiopath != null) 'audiopath': audiopath,
    });
  }

  AudioPathsCompanion copyWith(
      {Value<int>? id, Value<String>? seminar, Value<String>? audiopath}) {
    return AudioPathsCompanion(
      id: id ?? this.id,
      seminar: seminar ?? this.seminar,
      audiopath: audiopath ?? this.audiopath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seminar.present) {
      map['seminar'] = Variable<String>(seminar.value);
    }
    if (audiopath.present) {
      map['audiopath'] = Variable<String>(audiopath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AudioPathsCompanion(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('audiopath: $audiopath')
          ..write(')'))
        .toString();
  }
}

class $TextPathsTable extends TextPaths
    with TableInfo<$TextPathsTable, TextPath> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TextPathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _seminarMeta =
      const VerificationMeta('seminar');
  @override
  late final GeneratedColumn<String> seminar = GeneratedColumn<String>(
      'seminar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textpathMeta =
      const VerificationMeta('textpath');
  @override
  late final GeneratedColumn<String> textpath = GeneratedColumn<String>(
      'textpath', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, seminar, textpath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'text_paths';
  @override
  VerificationContext validateIntegrity(Insertable<TextPath> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('seminar')) {
      context.handle(_seminarMeta,
          seminar.isAcceptableOrUnknown(data['seminar']!, _seminarMeta));
    } else if (isInserting) {
      context.missing(_seminarMeta);
    }
    if (data.containsKey('textpath')) {
      context.handle(_textpathMeta,
          textpath.isAcceptableOrUnknown(data['textpath']!, _textpathMeta));
    } else if (isInserting) {
      context.missing(_textpathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TextPath map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TextPath(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      seminar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seminar'])!,
      textpath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}textpath'])!,
    );
  }

  @override
  $TextPathsTable createAlias(String alias) {
    return $TextPathsTable(attachedDatabase, alias);
  }
}

class TextPath extends DataClass implements Insertable<TextPath> {
  final int id;
  final String seminar;
  final String textpath;
  const TextPath(
      {required this.id, required this.seminar, required this.textpath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['seminar'] = Variable<String>(seminar);
    map['textpath'] = Variable<String>(textpath);
    return map;
  }

  TextPathsCompanion toCompanion(bool nullToAbsent) {
    return TextPathsCompanion(
      id: Value(id),
      seminar: Value(seminar),
      textpath: Value(textpath),
    );
  }

  factory TextPath.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TextPath(
      id: serializer.fromJson<int>(json['id']),
      seminar: serializer.fromJson<String>(json['seminar']),
      textpath: serializer.fromJson<String>(json['textpath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seminar': serializer.toJson<String>(seminar),
      'textpath': serializer.toJson<String>(textpath),
    };
  }

  TextPath copyWith({int? id, String? seminar, String? textpath}) => TextPath(
        id: id ?? this.id,
        seminar: seminar ?? this.seminar,
        textpath: textpath ?? this.textpath,
      );
  @override
  String toString() {
    return (StringBuffer('TextPath(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('textpath: $textpath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, seminar, textpath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TextPath &&
          other.id == this.id &&
          other.seminar == this.seminar &&
          other.textpath == this.textpath);
}

class TextPathsCompanion extends UpdateCompanion<TextPath> {
  final Value<int> id;
  final Value<String> seminar;
  final Value<String> textpath;
  const TextPathsCompanion({
    this.id = const Value.absent(),
    this.seminar = const Value.absent(),
    this.textpath = const Value.absent(),
  });
  TextPathsCompanion.insert({
    this.id = const Value.absent(),
    required String seminar,
    required String textpath,
  })  : seminar = Value(seminar),
        textpath = Value(textpath);
  static Insertable<TextPath> custom({
    Expression<int>? id,
    Expression<String>? seminar,
    Expression<String>? textpath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seminar != null) 'seminar': seminar,
      if (textpath != null) 'textpath': textpath,
    });
  }

  TextPathsCompanion copyWith(
      {Value<int>? id, Value<String>? seminar, Value<String>? textpath}) {
    return TextPathsCompanion(
      id: id ?? this.id,
      seminar: seminar ?? this.seminar,
      textpath: textpath ?? this.textpath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seminar.present) {
      map['seminar'] = Variable<String>(seminar.value);
    }
    if (textpath.present) {
      map['textpath'] = Variable<String>(textpath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TextPathsCompanion(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('textpath: $textpath')
          ..write(')'))
        .toString();
  }
}

class $ImagePathsTable extends ImagePaths
    with TableInfo<$ImagePathsTable, ImagePath> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImagePathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _seminarMeta =
      const VerificationMeta('seminar');
  @override
  late final GeneratedColumn<String> seminar = GeneratedColumn<String>(
      'seminar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imagepathMeta =
      const VerificationMeta('imagepath');
  @override
  late final GeneratedColumn<String> imagepath = GeneratedColumn<String>(
      'imagepath', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, seminar, imagepath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'image_paths';
  @override
  VerificationContext validateIntegrity(Insertable<ImagePath> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('seminar')) {
      context.handle(_seminarMeta,
          seminar.isAcceptableOrUnknown(data['seminar']!, _seminarMeta));
    } else if (isInserting) {
      context.missing(_seminarMeta);
    }
    if (data.containsKey('imagepath')) {
      context.handle(_imagepathMeta,
          imagepath.isAcceptableOrUnknown(data['imagepath']!, _imagepathMeta));
    } else if (isInserting) {
      context.missing(_imagepathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImagePath map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImagePath(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      seminar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seminar'])!,
      imagepath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imagepath'])!,
    );
  }

  @override
  $ImagePathsTable createAlias(String alias) {
    return $ImagePathsTable(attachedDatabase, alias);
  }
}

class ImagePath extends DataClass implements Insertable<ImagePath> {
  final int id;
  final String seminar;
  final String imagepath;
  const ImagePath(
      {required this.id, required this.seminar, required this.imagepath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['seminar'] = Variable<String>(seminar);
    map['imagepath'] = Variable<String>(imagepath);
    return map;
  }

  ImagePathsCompanion toCompanion(bool nullToAbsent) {
    return ImagePathsCompanion(
      id: Value(id),
      seminar: Value(seminar),
      imagepath: Value(imagepath),
    );
  }

  factory ImagePath.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImagePath(
      id: serializer.fromJson<int>(json['id']),
      seminar: serializer.fromJson<String>(json['seminar']),
      imagepath: serializer.fromJson<String>(json['imagepath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seminar': serializer.toJson<String>(seminar),
      'imagepath': serializer.toJson<String>(imagepath),
    };
  }

  ImagePath copyWith({int? id, String? seminar, String? imagepath}) =>
      ImagePath(
        id: id ?? this.id,
        seminar: seminar ?? this.seminar,
        imagepath: imagepath ?? this.imagepath,
      );
  @override
  String toString() {
    return (StringBuffer('ImagePath(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('imagepath: $imagepath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, seminar, imagepath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImagePath &&
          other.id == this.id &&
          other.seminar == this.seminar &&
          other.imagepath == this.imagepath);
}

class ImagePathsCompanion extends UpdateCompanion<ImagePath> {
  final Value<int> id;
  final Value<String> seminar;
  final Value<String> imagepath;
  const ImagePathsCompanion({
    this.id = const Value.absent(),
    this.seminar = const Value.absent(),
    this.imagepath = const Value.absent(),
  });
  ImagePathsCompanion.insert({
    this.id = const Value.absent(),
    required String seminar,
    required String imagepath,
  })  : seminar = Value(seminar),
        imagepath = Value(imagepath);
  static Insertable<ImagePath> custom({
    Expression<int>? id,
    Expression<String>? seminar,
    Expression<String>? imagepath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seminar != null) 'seminar': seminar,
      if (imagepath != null) 'imagepath': imagepath,
    });
  }

  ImagePathsCompanion copyWith(
      {Value<int>? id, Value<String>? seminar, Value<String>? imagepath}) {
    return ImagePathsCompanion(
      id: id ?? this.id,
      seminar: seminar ?? this.seminar,
      imagepath: imagepath ?? this.imagepath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seminar.present) {
      map['seminar'] = Variable<String>(seminar.value);
    }
    if (imagepath.present) {
      map['imagepath'] = Variable<String>(imagepath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImagePathsCompanion(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('imagepath: $imagepath')
          ..write(')'))
        .toString();
  }
}

class $PdfPathsTable extends PdfPaths with TableInfo<$PdfPathsTable, PdfPath> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PdfPathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _seminarMeta =
      const VerificationMeta('seminar');
  @override
  late final GeneratedColumn<String> seminar = GeneratedColumn<String>(
      'seminar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pdfpathMeta =
      const VerificationMeta('pdfpath');
  @override
  late final GeneratedColumn<String> pdfpath = GeneratedColumn<String>(
      'pdfpath', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, seminar, pdfpath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pdf_paths';
  @override
  VerificationContext validateIntegrity(Insertable<PdfPath> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('seminar')) {
      context.handle(_seminarMeta,
          seminar.isAcceptableOrUnknown(data['seminar']!, _seminarMeta));
    } else if (isInserting) {
      context.missing(_seminarMeta);
    }
    if (data.containsKey('pdfpath')) {
      context.handle(_pdfpathMeta,
          pdfpath.isAcceptableOrUnknown(data['pdfpath']!, _pdfpathMeta));
    } else if (isInserting) {
      context.missing(_pdfpathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PdfPath map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PdfPath(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      seminar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seminar'])!,
      pdfpath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pdfpath'])!,
    );
  }

  @override
  $PdfPathsTable createAlias(String alias) {
    return $PdfPathsTable(attachedDatabase, alias);
  }
}

class PdfPath extends DataClass implements Insertable<PdfPath> {
  final int id;
  final String seminar;
  final String pdfpath;
  const PdfPath(
      {required this.id, required this.seminar, required this.pdfpath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['seminar'] = Variable<String>(seminar);
    map['pdfpath'] = Variable<String>(pdfpath);
    return map;
  }

  PdfPathsCompanion toCompanion(bool nullToAbsent) {
    return PdfPathsCompanion(
      id: Value(id),
      seminar: Value(seminar),
      pdfpath: Value(pdfpath),
    );
  }

  factory PdfPath.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PdfPath(
      id: serializer.fromJson<int>(json['id']),
      seminar: serializer.fromJson<String>(json['seminar']),
      pdfpath: serializer.fromJson<String>(json['pdfpath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seminar': serializer.toJson<String>(seminar),
      'pdfpath': serializer.toJson<String>(pdfpath),
    };
  }

  PdfPath copyWith({int? id, String? seminar, String? pdfpath}) => PdfPath(
        id: id ?? this.id,
        seminar: seminar ?? this.seminar,
        pdfpath: pdfpath ?? this.pdfpath,
      );
  @override
  String toString() {
    return (StringBuffer('PdfPath(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('pdfpath: $pdfpath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, seminar, pdfpath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PdfPath &&
          other.id == this.id &&
          other.seminar == this.seminar &&
          other.pdfpath == this.pdfpath);
}

class PdfPathsCompanion extends UpdateCompanion<PdfPath> {
  final Value<int> id;
  final Value<String> seminar;
  final Value<String> pdfpath;
  const PdfPathsCompanion({
    this.id = const Value.absent(),
    this.seminar = const Value.absent(),
    this.pdfpath = const Value.absent(),
  });
  PdfPathsCompanion.insert({
    this.id = const Value.absent(),
    required String seminar,
    required String pdfpath,
  })  : seminar = Value(seminar),
        pdfpath = Value(pdfpath);
  static Insertable<PdfPath> custom({
    Expression<int>? id,
    Expression<String>? seminar,
    Expression<String>? pdfpath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seminar != null) 'seminar': seminar,
      if (pdfpath != null) 'pdfpath': pdfpath,
    });
  }

  PdfPathsCompanion copyWith(
      {Value<int>? id, Value<String>? seminar, Value<String>? pdfpath}) {
    return PdfPathsCompanion(
      id: id ?? this.id,
      seminar: seminar ?? this.seminar,
      pdfpath: pdfpath ?? this.pdfpath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seminar.present) {
      map['seminar'] = Variable<String>(seminar.value);
    }
    if (pdfpath.present) {
      map['pdfpath'] = Variable<String>(pdfpath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PdfPathsCompanion(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('pdfpath: $pdfpath')
          ..write(')'))
        .toString();
  }
}

class $TimeStampsTable extends TimeStamps
    with TableInfo<$TimeStampsTable, TimeStamp> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeStampsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _seminarMeta =
      const VerificationMeta('seminar');
  @override
  late final GeneratedColumn<String> seminar = GeneratedColumn<String>(
      'seminar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ttaudiopathMeta =
      const VerificationMeta('ttaudiopath');
  @override
  late final GeneratedColumn<String> ttaudiopath = GeneratedColumn<String>(
      'ttaudiopath', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dxMeta = const VerificationMeta('dx');
  @override
  late final GeneratedColumn<double> dx = GeneratedColumn<double>(
      'dx', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dyMeta = const VerificationMeta('dy');
  @override
  late final GeneratedColumn<double> dy = GeneratedColumn<double>(
      'dy', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _stampMeta = const VerificationMeta('stamp');
  @override
  late final GeneratedColumn<int> stamp = GeneratedColumn<int>(
      'stamp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, seminar, ttaudiopath, description, dx, dy, stamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_stamps';
  @override
  VerificationContext validateIntegrity(Insertable<TimeStamp> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('seminar')) {
      context.handle(_seminarMeta,
          seminar.isAcceptableOrUnknown(data['seminar']!, _seminarMeta));
    } else if (isInserting) {
      context.missing(_seminarMeta);
    }
    if (data.containsKey('ttaudiopath')) {
      context.handle(
          _ttaudiopathMeta,
          ttaudiopath.isAcceptableOrUnknown(
              data['ttaudiopath']!, _ttaudiopathMeta));
    } else if (isInserting) {
      context.missing(_ttaudiopathMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('dx')) {
      context.handle(_dxMeta, dx.isAcceptableOrUnknown(data['dx']!, _dxMeta));
    } else if (isInserting) {
      context.missing(_dxMeta);
    }
    if (data.containsKey('dy')) {
      context.handle(_dyMeta, dy.isAcceptableOrUnknown(data['dy']!, _dyMeta));
    } else if (isInserting) {
      context.missing(_dyMeta);
    }
    if (data.containsKey('stamp')) {
      context.handle(
          _stampMeta, stamp.isAcceptableOrUnknown(data['stamp']!, _stampMeta));
    } else if (isInserting) {
      context.missing(_stampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeStamp map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeStamp(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      seminar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seminar'])!,
      ttaudiopath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ttaudiopath'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      dx: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dx'])!,
      dy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dy'])!,
      stamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stamp'])!,
    );
  }

  @override
  $TimeStampsTable createAlias(String alias) {
    return $TimeStampsTable(attachedDatabase, alias);
  }
}

class TimeStamp extends DataClass implements Insertable<TimeStamp> {
  final int id;
  final String seminar;
  final String ttaudiopath;
  final String description;
  final double dx;
  final double dy;
  final int stamp;
  const TimeStamp(
      {required this.id,
      required this.seminar,
      required this.ttaudiopath,
      required this.description,
      required this.dx,
      required this.dy,
      required this.stamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['seminar'] = Variable<String>(seminar);
    map['ttaudiopath'] = Variable<String>(ttaudiopath);
    map['description'] = Variable<String>(description);
    map['dx'] = Variable<double>(dx);
    map['dy'] = Variable<double>(dy);
    map['stamp'] = Variable<int>(stamp);
    return map;
  }

  TimeStampsCompanion toCompanion(bool nullToAbsent) {
    return TimeStampsCompanion(
      id: Value(id),
      seminar: Value(seminar),
      ttaudiopath: Value(ttaudiopath),
      description: Value(description),
      dx: Value(dx),
      dy: Value(dy),
      stamp: Value(stamp),
    );
  }

  factory TimeStamp.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeStamp(
      id: serializer.fromJson<int>(json['id']),
      seminar: serializer.fromJson<String>(json['seminar']),
      ttaudiopath: serializer.fromJson<String>(json['ttaudiopath']),
      description: serializer.fromJson<String>(json['description']),
      dx: serializer.fromJson<double>(json['dx']),
      dy: serializer.fromJson<double>(json['dy']),
      stamp: serializer.fromJson<int>(json['stamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seminar': serializer.toJson<String>(seminar),
      'ttaudiopath': serializer.toJson<String>(ttaudiopath),
      'description': serializer.toJson<String>(description),
      'dx': serializer.toJson<double>(dx),
      'dy': serializer.toJson<double>(dy),
      'stamp': serializer.toJson<int>(stamp),
    };
  }

  TimeStamp copyWith(
          {int? id,
          String? seminar,
          String? ttaudiopath,
          String? description,
          double? dx,
          double? dy,
          int? stamp}) =>
      TimeStamp(
        id: id ?? this.id,
        seminar: seminar ?? this.seminar,
        ttaudiopath: ttaudiopath ?? this.ttaudiopath,
        description: description ?? this.description,
        dx: dx ?? this.dx,
        dy: dy ?? this.dy,
        stamp: stamp ?? this.stamp,
      );
  @override
  String toString() {
    return (StringBuffer('TimeStamp(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('ttaudiopath: $ttaudiopath, ')
          ..write('description: $description, ')
          ..write('dx: $dx, ')
          ..write('dy: $dy, ')
          ..write('stamp: $stamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, seminar, ttaudiopath, description, dx, dy, stamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeStamp &&
          other.id == this.id &&
          other.seminar == this.seminar &&
          other.ttaudiopath == this.ttaudiopath &&
          other.description == this.description &&
          other.dx == this.dx &&
          other.dy == this.dy &&
          other.stamp == this.stamp);
}

class TimeStampsCompanion extends UpdateCompanion<TimeStamp> {
  final Value<int> id;
  final Value<String> seminar;
  final Value<String> ttaudiopath;
  final Value<String> description;
  final Value<double> dx;
  final Value<double> dy;
  final Value<int> stamp;
  const TimeStampsCompanion({
    this.id = const Value.absent(),
    this.seminar = const Value.absent(),
    this.ttaudiopath = const Value.absent(),
    this.description = const Value.absent(),
    this.dx = const Value.absent(),
    this.dy = const Value.absent(),
    this.stamp = const Value.absent(),
  });
  TimeStampsCompanion.insert({
    this.id = const Value.absent(),
    required String seminar,
    required String ttaudiopath,
    required String description,
    required double dx,
    required double dy,
    required int stamp,
  })  : seminar = Value(seminar),
        ttaudiopath = Value(ttaudiopath),
        description = Value(description),
        dx = Value(dx),
        dy = Value(dy),
        stamp = Value(stamp);
  static Insertable<TimeStamp> custom({
    Expression<int>? id,
    Expression<String>? seminar,
    Expression<String>? ttaudiopath,
    Expression<String>? description,
    Expression<double>? dx,
    Expression<double>? dy,
    Expression<int>? stamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seminar != null) 'seminar': seminar,
      if (ttaudiopath != null) 'ttaudiopath': ttaudiopath,
      if (description != null) 'description': description,
      if (dx != null) 'dx': dx,
      if (dy != null) 'dy': dy,
      if (stamp != null) 'stamp': stamp,
    });
  }

  TimeStampsCompanion copyWith(
      {Value<int>? id,
      Value<String>? seminar,
      Value<String>? ttaudiopath,
      Value<String>? description,
      Value<double>? dx,
      Value<double>? dy,
      Value<int>? stamp}) {
    return TimeStampsCompanion(
      id: id ?? this.id,
      seminar: seminar ?? this.seminar,
      ttaudiopath: ttaudiopath ?? this.ttaudiopath,
      description: description ?? this.description,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
      stamp: stamp ?? this.stamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seminar.present) {
      map['seminar'] = Variable<String>(seminar.value);
    }
    if (ttaudiopath.present) {
      map['ttaudiopath'] = Variable<String>(ttaudiopath.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dx.present) {
      map['dx'] = Variable<double>(dx.value);
    }
    if (dy.present) {
      map['dy'] = Variable<double>(dy.value);
    }
    if (stamp.present) {
      map['stamp'] = Variable<int>(stamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeStampsCompanion(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('ttaudiopath: $ttaudiopath, ')
          ..write('description: $description, ')
          ..write('dx: $dx, ')
          ..write('dy: $dy, ')
          ..write('stamp: $stamp')
          ..write(')'))
        .toString();
  }
}

class $TextButtonsTable extends TextButtons
    with TableInfo<$TextButtonsTable, TextButton> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TextButtonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _seminarMeta =
      const VerificationMeta('seminar');
  @override
  late final GeneratedColumn<String> seminar = GeneratedColumn<String>(
      'seminar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textpathMeta =
      const VerificationMeta('textpath');
  @override
  late final GeneratedColumn<String> textpath = GeneratedColumn<String>(
      'textpath', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dxMeta = const VerificationMeta('dx');
  @override
  late final GeneratedColumn<double> dx = GeneratedColumn<double>(
      'dx', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dyMeta = const VerificationMeta('dy');
  @override
  late final GeneratedColumn<double> dy = GeneratedColumn<double>(
      'dy', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, seminar, textpath, name, dx, dy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'text_buttons';
  @override
  VerificationContext validateIntegrity(Insertable<TextButton> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('seminar')) {
      context.handle(_seminarMeta,
          seminar.isAcceptableOrUnknown(data['seminar']!, _seminarMeta));
    } else if (isInserting) {
      context.missing(_seminarMeta);
    }
    if (data.containsKey('textpath')) {
      context.handle(_textpathMeta,
          textpath.isAcceptableOrUnknown(data['textpath']!, _textpathMeta));
    } else if (isInserting) {
      context.missing(_textpathMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('dx')) {
      context.handle(_dxMeta, dx.isAcceptableOrUnknown(data['dx']!, _dxMeta));
    } else if (isInserting) {
      context.missing(_dxMeta);
    }
    if (data.containsKey('dy')) {
      context.handle(_dyMeta, dy.isAcceptableOrUnknown(data['dy']!, _dyMeta));
    } else if (isInserting) {
      context.missing(_dyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TextButton map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TextButton(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      seminar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seminar'])!,
      textpath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}textpath'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      dx: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dx'])!,
      dy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dy'])!,
    );
  }

  @override
  $TextButtonsTable createAlias(String alias) {
    return $TextButtonsTable(attachedDatabase, alias);
  }
}

class TextButton extends DataClass implements Insertable<TextButton> {
  final int id;
  final String seminar;
  final String textpath;
  final String name;
  final double dx;
  final double dy;
  const TextButton(
      {required this.id,
      required this.seminar,
      required this.textpath,
      required this.name,
      required this.dx,
      required this.dy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['seminar'] = Variable<String>(seminar);
    map['textpath'] = Variable<String>(textpath);
    map['name'] = Variable<String>(name);
    map['dx'] = Variable<double>(dx);
    map['dy'] = Variable<double>(dy);
    return map;
  }

  TextButtonsCompanion toCompanion(bool nullToAbsent) {
    return TextButtonsCompanion(
      id: Value(id),
      seminar: Value(seminar),
      textpath: Value(textpath),
      name: Value(name),
      dx: Value(dx),
      dy: Value(dy),
    );
  }

  factory TextButton.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TextButton(
      id: serializer.fromJson<int>(json['id']),
      seminar: serializer.fromJson<String>(json['seminar']),
      textpath: serializer.fromJson<String>(json['textpath']),
      name: serializer.fromJson<String>(json['name']),
      dx: serializer.fromJson<double>(json['dx']),
      dy: serializer.fromJson<double>(json['dy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seminar': serializer.toJson<String>(seminar),
      'textpath': serializer.toJson<String>(textpath),
      'name': serializer.toJson<String>(name),
      'dx': serializer.toJson<double>(dx),
      'dy': serializer.toJson<double>(dy),
    };
  }

  TextButton copyWith(
          {int? id,
          String? seminar,
          String? textpath,
          String? name,
          double? dx,
          double? dy}) =>
      TextButton(
        id: id ?? this.id,
        seminar: seminar ?? this.seminar,
        textpath: textpath ?? this.textpath,
        name: name ?? this.name,
        dx: dx ?? this.dx,
        dy: dy ?? this.dy,
      );
  @override
  String toString() {
    return (StringBuffer('TextButton(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('textpath: $textpath, ')
          ..write('name: $name, ')
          ..write('dx: $dx, ')
          ..write('dy: $dy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, seminar, textpath, name, dx, dy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TextButton &&
          other.id == this.id &&
          other.seminar == this.seminar &&
          other.textpath == this.textpath &&
          other.name == this.name &&
          other.dx == this.dx &&
          other.dy == this.dy);
}

class TextButtonsCompanion extends UpdateCompanion<TextButton> {
  final Value<int> id;
  final Value<String> seminar;
  final Value<String> textpath;
  final Value<String> name;
  final Value<double> dx;
  final Value<double> dy;
  const TextButtonsCompanion({
    this.id = const Value.absent(),
    this.seminar = const Value.absent(),
    this.textpath = const Value.absent(),
    this.name = const Value.absent(),
    this.dx = const Value.absent(),
    this.dy = const Value.absent(),
  });
  TextButtonsCompanion.insert({
    this.id = const Value.absent(),
    required String seminar,
    required String textpath,
    required String name,
    required double dx,
    required double dy,
  })  : seminar = Value(seminar),
        textpath = Value(textpath),
        name = Value(name),
        dx = Value(dx),
        dy = Value(dy);
  static Insertable<TextButton> custom({
    Expression<int>? id,
    Expression<String>? seminar,
    Expression<String>? textpath,
    Expression<String>? name,
    Expression<double>? dx,
    Expression<double>? dy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seminar != null) 'seminar': seminar,
      if (textpath != null) 'textpath': textpath,
      if (name != null) 'name': name,
      if (dx != null) 'dx': dx,
      if (dy != null) 'dy': dy,
    });
  }

  TextButtonsCompanion copyWith(
      {Value<int>? id,
      Value<String>? seminar,
      Value<String>? textpath,
      Value<String>? name,
      Value<double>? dx,
      Value<double>? dy}) {
    return TextButtonsCompanion(
      id: id ?? this.id,
      seminar: seminar ?? this.seminar,
      textpath: textpath ?? this.textpath,
      name: name ?? this.name,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seminar.present) {
      map['seminar'] = Variable<String>(seminar.value);
    }
    if (textpath.present) {
      map['textpath'] = Variable<String>(textpath.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dx.present) {
      map['dx'] = Variable<double>(dx.value);
    }
    if (dy.present) {
      map['dy'] = Variable<double>(dy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TextButtonsCompanion(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('textpath: $textpath, ')
          ..write('name: $name, ')
          ..write('dx: $dx, ')
          ..write('dy: $dy')
          ..write(')'))
        .toString();
  }
}

class $PaintPathsTable extends PaintPaths
    with TableInfo<$PaintPathsTable, PaintPath> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaintPathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _seminarMeta =
      const VerificationMeta('seminar');
  @override
  late final GeneratedColumn<String> seminar = GeneratedColumn<String>(
      'seminar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathsMeta = const VerificationMeta('paths');
  @override
  late final GeneratedColumnWithTypeConverter<Paths?, String> paths =
      GeneratedColumn<String>('paths', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<Paths?>($PaintPathsTable.$converterpathsn);
  @override
  List<GeneratedColumn> get $columns => [id, seminar, description, paths];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'paint_paths';
  @override
  VerificationContext validateIntegrity(Insertable<PaintPath> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('seminar')) {
      context.handle(_seminarMeta,
          seminar.isAcceptableOrUnknown(data['seminar']!, _seminarMeta));
    } else if (isInserting) {
      context.missing(_seminarMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    context.handle(_pathsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaintPath map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaintPath(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      seminar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seminar'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      paths: $PaintPathsTable.$converterpathsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}paths'])),
    );
  }

  @override
  $PaintPathsTable createAlias(String alias) {
    return $PaintPathsTable(attachedDatabase, alias);
  }

  static TypeConverter<Paths, String> $converterpaths = const PathsConverter();
  static TypeConverter<Paths?, String?> $converterpathsn =
      NullAwareTypeConverter.wrap($converterpaths);
}

class PaintPath extends DataClass implements Insertable<PaintPath> {
  final int id;
  final String seminar;
  final String description;
  final Paths? paths;
  const PaintPath(
      {required this.id,
      required this.seminar,
      required this.description,
      this.paths});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['seminar'] = Variable<String>(seminar);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || paths != null) {
      final converter = $PaintPathsTable.$converterpathsn;
      map['paths'] = Variable<String>(converter.toSql(paths));
    }
    return map;
  }

  PaintPathsCompanion toCompanion(bool nullToAbsent) {
    return PaintPathsCompanion(
      id: Value(id),
      seminar: Value(seminar),
      description: Value(description),
      paths:
          paths == null && nullToAbsent ? const Value.absent() : Value(paths),
    );
  }

  factory PaintPath.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaintPath(
      id: serializer.fromJson<int>(json['id']),
      seminar: serializer.fromJson<String>(json['seminar']),
      description: serializer.fromJson<String>(json['description']),
      paths: serializer.fromJson<Paths?>(json['paths']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seminar': serializer.toJson<String>(seminar),
      'description': serializer.toJson<String>(description),
      'paths': serializer.toJson<Paths?>(paths),
    };
  }

  PaintPath copyWith(
          {int? id,
          String? seminar,
          String? description,
          Value<Paths?> paths = const Value.absent()}) =>
      PaintPath(
        id: id ?? this.id,
        seminar: seminar ?? this.seminar,
        description: description ?? this.description,
        paths: paths.present ? paths.value : this.paths,
      );
  @override
  String toString() {
    return (StringBuffer('PaintPath(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('description: $description, ')
          ..write('paths: $paths')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, seminar, description, paths);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaintPath &&
          other.id == this.id &&
          other.seminar == this.seminar &&
          other.description == this.description &&
          other.paths == this.paths);
}

class PaintPathsCompanion extends UpdateCompanion<PaintPath> {
  final Value<int> id;
  final Value<String> seminar;
  final Value<String> description;
  final Value<Paths?> paths;
  const PaintPathsCompanion({
    this.id = const Value.absent(),
    this.seminar = const Value.absent(),
    this.description = const Value.absent(),
    this.paths = const Value.absent(),
  });
  PaintPathsCompanion.insert({
    this.id = const Value.absent(),
    required String seminar,
    required String description,
    this.paths = const Value.absent(),
  })  : seminar = Value(seminar),
        description = Value(description);
  static Insertable<PaintPath> custom({
    Expression<int>? id,
    Expression<String>? seminar,
    Expression<String>? description,
    Expression<String>? paths,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seminar != null) 'seminar': seminar,
      if (description != null) 'description': description,
      if (paths != null) 'paths': paths,
    });
  }

  PaintPathsCompanion copyWith(
      {Value<int>? id,
      Value<String>? seminar,
      Value<String>? description,
      Value<Paths?>? paths}) {
    return PaintPathsCompanion(
      id: id ?? this.id,
      seminar: seminar ?? this.seminar,
      description: description ?? this.description,
      paths: paths ?? this.paths,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seminar.present) {
      map['seminar'] = Variable<String>(seminar.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (paths.present) {
      final converter = $PaintPathsTable.$converterpathsn;
      map['paths'] = Variable<String>(converter.toSql(paths.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaintPathsCompanion(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('description: $description, ')
          ..write('paths: $paths')
          ..write(')'))
        .toString();
  }
}

class $ReferencePathsTable extends ReferencePaths
    with TableInfo<$ReferencePathsTable, ReferencePath> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReferencePathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _seminarMeta =
      const VerificationMeta('seminar');
  @override
  late final GeneratedColumn<String> seminar = GeneratedColumn<String>(
      'seminar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referencepathMeta =
      const VerificationMeta('referencepath');
  @override
  late final GeneratedColumn<String> referencepath = GeneratedColumn<String>(
      'referencepath', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, seminar, referencepath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reference_paths';
  @override
  VerificationContext validateIntegrity(Insertable<ReferencePath> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('seminar')) {
      context.handle(_seminarMeta,
          seminar.isAcceptableOrUnknown(data['seminar']!, _seminarMeta));
    } else if (isInserting) {
      context.missing(_seminarMeta);
    }
    if (data.containsKey('referencepath')) {
      context.handle(
          _referencepathMeta,
          referencepath.isAcceptableOrUnknown(
              data['referencepath']!, _referencepathMeta));
    } else if (isInserting) {
      context.missing(_referencepathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReferencePath map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReferencePath(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      seminar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seminar'])!,
      referencepath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}referencepath'])!,
    );
  }

  @override
  $ReferencePathsTable createAlias(String alias) {
    return $ReferencePathsTable(attachedDatabase, alias);
  }
}

class ReferencePath extends DataClass implements Insertable<ReferencePath> {
  final int id;
  final String seminar;
  final String referencepath;
  const ReferencePath(
      {required this.id, required this.seminar, required this.referencepath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['seminar'] = Variable<String>(seminar);
    map['referencepath'] = Variable<String>(referencepath);
    return map;
  }

  ReferencePathsCompanion toCompanion(bool nullToAbsent) {
    return ReferencePathsCompanion(
      id: Value(id),
      seminar: Value(seminar),
      referencepath: Value(referencepath),
    );
  }

  factory ReferencePath.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReferencePath(
      id: serializer.fromJson<int>(json['id']),
      seminar: serializer.fromJson<String>(json['seminar']),
      referencepath: serializer.fromJson<String>(json['referencepath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seminar': serializer.toJson<String>(seminar),
      'referencepath': serializer.toJson<String>(referencepath),
    };
  }

  ReferencePath copyWith({int? id, String? seminar, String? referencepath}) =>
      ReferencePath(
        id: id ?? this.id,
        seminar: seminar ?? this.seminar,
        referencepath: referencepath ?? this.referencepath,
      );
  @override
  String toString() {
    return (StringBuffer('ReferencePath(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('referencepath: $referencepath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, seminar, referencepath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReferencePath &&
          other.id == this.id &&
          other.seminar == this.seminar &&
          other.referencepath == this.referencepath);
}

class ReferencePathsCompanion extends UpdateCompanion<ReferencePath> {
  final Value<int> id;
  final Value<String> seminar;
  final Value<String> referencepath;
  const ReferencePathsCompanion({
    this.id = const Value.absent(),
    this.seminar = const Value.absent(),
    this.referencepath = const Value.absent(),
  });
  ReferencePathsCompanion.insert({
    this.id = const Value.absent(),
    required String seminar,
    required String referencepath,
  })  : seminar = Value(seminar),
        referencepath = Value(referencepath);
  static Insertable<ReferencePath> custom({
    Expression<int>? id,
    Expression<String>? seminar,
    Expression<String>? referencepath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seminar != null) 'seminar': seminar,
      if (referencepath != null) 'referencepath': referencepath,
    });
  }

  ReferencePathsCompanion copyWith(
      {Value<int>? id, Value<String>? seminar, Value<String>? referencepath}) {
    return ReferencePathsCompanion(
      id: id ?? this.id,
      seminar: seminar ?? this.seminar,
      referencepath: referencepath ?? this.referencepath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seminar.present) {
      map['seminar'] = Variable<String>(seminar.value);
    }
    if (referencepath.present) {
      map['referencepath'] = Variable<String>(referencepath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReferencePathsCompanion(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('referencepath: $referencepath')
          ..write(')'))
        .toString();
  }
}

class $ReferenceButtonsTable extends ReferenceButtons
    with TableInfo<$ReferenceButtonsTable, ReferenceButton> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReferenceButtonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _seminarMeta =
      const VerificationMeta('seminar');
  @override
  late final GeneratedColumn<String> seminar = GeneratedColumn<String>(
      'seminar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referencepathMeta =
      const VerificationMeta('referencepath');
  @override
  late final GeneratedColumn<String> referencepath = GeneratedColumn<String>(
      'referencepath', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dxMeta = const VerificationMeta('dx');
  @override
  late final GeneratedColumn<double> dx = GeneratedColumn<double>(
      'dx', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dyMeta = const VerificationMeta('dy');
  @override
  late final GeneratedColumn<double> dy = GeneratedColumn<double>(
      'dy', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, seminar, referencepath, name, description, dx, dy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reference_buttons';
  @override
  VerificationContext validateIntegrity(Insertable<ReferenceButton> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('seminar')) {
      context.handle(_seminarMeta,
          seminar.isAcceptableOrUnknown(data['seminar']!, _seminarMeta));
    } else if (isInserting) {
      context.missing(_seminarMeta);
    }
    if (data.containsKey('referencepath')) {
      context.handle(
          _referencepathMeta,
          referencepath.isAcceptableOrUnknown(
              data['referencepath']!, _referencepathMeta));
    } else if (isInserting) {
      context.missing(_referencepathMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('dx')) {
      context.handle(_dxMeta, dx.isAcceptableOrUnknown(data['dx']!, _dxMeta));
    } else if (isInserting) {
      context.missing(_dxMeta);
    }
    if (data.containsKey('dy')) {
      context.handle(_dyMeta, dy.isAcceptableOrUnknown(data['dy']!, _dyMeta));
    } else if (isInserting) {
      context.missing(_dyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReferenceButton map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReferenceButton(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      seminar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seminar'])!,
      referencepath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}referencepath'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      dx: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dx'])!,
      dy: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dy'])!,
    );
  }

  @override
  $ReferenceButtonsTable createAlias(String alias) {
    return $ReferenceButtonsTable(attachedDatabase, alias);
  }
}

class ReferenceButton extends DataClass implements Insertable<ReferenceButton> {
  final int id;
  final String seminar;
  final String referencepath;
  final String name;
  final String description;
  final double dx;
  final double dy;
  const ReferenceButton(
      {required this.id,
      required this.seminar,
      required this.referencepath,
      required this.name,
      required this.description,
      required this.dx,
      required this.dy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['seminar'] = Variable<String>(seminar);
    map['referencepath'] = Variable<String>(referencepath);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['dx'] = Variable<double>(dx);
    map['dy'] = Variable<double>(dy);
    return map;
  }

  ReferenceButtonsCompanion toCompanion(bool nullToAbsent) {
    return ReferenceButtonsCompanion(
      id: Value(id),
      seminar: Value(seminar),
      referencepath: Value(referencepath),
      name: Value(name),
      description: Value(description),
      dx: Value(dx),
      dy: Value(dy),
    );
  }

  factory ReferenceButton.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReferenceButton(
      id: serializer.fromJson<int>(json['id']),
      seminar: serializer.fromJson<String>(json['seminar']),
      referencepath: serializer.fromJson<String>(json['referencepath']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      dx: serializer.fromJson<double>(json['dx']),
      dy: serializer.fromJson<double>(json['dy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'seminar': serializer.toJson<String>(seminar),
      'referencepath': serializer.toJson<String>(referencepath),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'dx': serializer.toJson<double>(dx),
      'dy': serializer.toJson<double>(dy),
    };
  }

  ReferenceButton copyWith(
          {int? id,
          String? seminar,
          String? referencepath,
          String? name,
          String? description,
          double? dx,
          double? dy}) =>
      ReferenceButton(
        id: id ?? this.id,
        seminar: seminar ?? this.seminar,
        referencepath: referencepath ?? this.referencepath,
        name: name ?? this.name,
        description: description ?? this.description,
        dx: dx ?? this.dx,
        dy: dy ?? this.dy,
      );
  @override
  String toString() {
    return (StringBuffer('ReferenceButton(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('referencepath: $referencepath, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('dx: $dx, ')
          ..write('dy: $dy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, seminar, referencepath, name, description, dx, dy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReferenceButton &&
          other.id == this.id &&
          other.seminar == this.seminar &&
          other.referencepath == this.referencepath &&
          other.name == this.name &&
          other.description == this.description &&
          other.dx == this.dx &&
          other.dy == this.dy);
}

class ReferenceButtonsCompanion extends UpdateCompanion<ReferenceButton> {
  final Value<int> id;
  final Value<String> seminar;
  final Value<String> referencepath;
  final Value<String> name;
  final Value<String> description;
  final Value<double> dx;
  final Value<double> dy;
  const ReferenceButtonsCompanion({
    this.id = const Value.absent(),
    this.seminar = const Value.absent(),
    this.referencepath = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.dx = const Value.absent(),
    this.dy = const Value.absent(),
  });
  ReferenceButtonsCompanion.insert({
    this.id = const Value.absent(),
    required String seminar,
    required String referencepath,
    required String name,
    required String description,
    required double dx,
    required double dy,
  })  : seminar = Value(seminar),
        referencepath = Value(referencepath),
        name = Value(name),
        description = Value(description),
        dx = Value(dx),
        dy = Value(dy);
  static Insertable<ReferenceButton> custom({
    Expression<int>? id,
    Expression<String>? seminar,
    Expression<String>? referencepath,
    Expression<String>? name,
    Expression<String>? description,
    Expression<double>? dx,
    Expression<double>? dy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (seminar != null) 'seminar': seminar,
      if (referencepath != null) 'referencepath': referencepath,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (dx != null) 'dx': dx,
      if (dy != null) 'dy': dy,
    });
  }

  ReferenceButtonsCompanion copyWith(
      {Value<int>? id,
      Value<String>? seminar,
      Value<String>? referencepath,
      Value<String>? name,
      Value<String>? description,
      Value<double>? dx,
      Value<double>? dy}) {
    return ReferenceButtonsCompanion(
      id: id ?? this.id,
      seminar: seminar ?? this.seminar,
      referencepath: referencepath ?? this.referencepath,
      name: name ?? this.name,
      description: description ?? this.description,
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (seminar.present) {
      map['seminar'] = Variable<String>(seminar.value);
    }
    if (referencepath.present) {
      map['referencepath'] = Variable<String>(referencepath.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dx.present) {
      map['dx'] = Variable<double>(dx.value);
    }
    if (dy.present) {
      map['dy'] = Variable<double>(dy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReferenceButtonsCompanion(')
          ..write('id: $id, ')
          ..write('seminar: $seminar, ')
          ..write('referencepath: $referencepath, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('dx: $dx, ')
          ..write('dy: $dy')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $SeminarsTable seminars = $SeminarsTable(this);
  late final $AudioPathsTable audioPaths = $AudioPathsTable(this);
  late final $TextPathsTable textPaths = $TextPathsTable(this);
  late final $ImagePathsTable imagePaths = $ImagePathsTable(this);
  late final $PdfPathsTable pdfPaths = $PdfPathsTable(this);
  late final $TimeStampsTable timeStamps = $TimeStampsTable(this);
  late final $TextButtonsTable textButtons = $TextButtonsTable(this);
  late final $PaintPathsTable paintPaths = $PaintPathsTable(this);
  late final $ReferencePathsTable referencePaths = $ReferencePathsTable(this);
  late final $ReferenceButtonsTable referenceButtons =
      $ReferenceButtonsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        seminars,
        audioPaths,
        textPaths,
        imagePaths,
        pdfPaths,
        timeStamps,
        textButtons,
        paintPaths,
        referencePaths,
        referenceButtons
      ];
}
