// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $NutritionalPlanTableTable extends NutritionalPlanTable
    with TableInfo<$NutritionalPlanTableTable, NutritionalPlanTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionalPlanTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => ps.uuid.v7(),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationDateMeta = const VerificationMeta(
    'creationDate',
  );
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
    'creation_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _onlyLoggingMeta = const VerificationMeta(
    'onlyLogging',
  );
  @override
  late final GeneratedColumn<bool> onlyLogging = GeneratedColumn<bool>(
    'only_logging',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("only_logging" IN (0, 1))',
    ),
  );
  static const VerificationMeta _goalEnergyMeta = const VerificationMeta(
    'goalEnergy',
  );
  @override
  late final GeneratedColumn<int> goalEnergy = GeneratedColumn<int>(
    'goal_energy',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalProteinMeta = const VerificationMeta(
    'goalProtein',
  );
  @override
  late final GeneratedColumn<int> goalProtein = GeneratedColumn<int>(
    'goal_protein',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalCarbohydratesMeta = const VerificationMeta(
    'goalCarbohydrates',
  );
  @override
  late final GeneratedColumn<int> goalCarbohydrates = GeneratedColumn<int>(
    'goal_carbohydrates',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalFiberMeta = const VerificationMeta(
    'goalFiber',
  );
  @override
  late final GeneratedColumn<int> goalFiber = GeneratedColumn<int>(
    'goal_fiber',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalFatMeta = const VerificationMeta(
    'goalFat',
  );
  @override
  late final GeneratedColumn<int> goalFat = GeneratedColumn<int>(
    'goal_fat',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasGoalCaloriesMeta = const VerificationMeta(
    'hasGoalCalories',
  );
  @override
  late final GeneratedColumn<bool> hasGoalCalories = GeneratedColumn<bool>(
    'has_goal_calories',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_goal_calories" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    description,
    creationDate,
    startDate,
    endDate,
    onlyLogging,
    goalEnergy,
    goalProtein,
    goalCarbohydrates,
    goalFiber,
    goalFat,
    hasGoalCalories,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_nutritionplan';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionalPlanTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('creation_date')) {
      context.handle(
        _creationDateMeta,
        creationDate.isAcceptableOrUnknown(
          data['creation_date']!,
          _creationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end']!, _endDateMeta),
      );
    }
    if (data.containsKey('only_logging')) {
      context.handle(
        _onlyLoggingMeta,
        onlyLogging.isAcceptableOrUnknown(
          data['only_logging']!,
          _onlyLoggingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_onlyLoggingMeta);
    }
    if (data.containsKey('goal_energy')) {
      context.handle(
        _goalEnergyMeta,
        goalEnergy.isAcceptableOrUnknown(data['goal_energy']!, _goalEnergyMeta),
      );
    }
    if (data.containsKey('goal_protein')) {
      context.handle(
        _goalProteinMeta,
        goalProtein.isAcceptableOrUnknown(
          data['goal_protein']!,
          _goalProteinMeta,
        ),
      );
    }
    if (data.containsKey('goal_carbohydrates')) {
      context.handle(
        _goalCarbohydratesMeta,
        goalCarbohydrates.isAcceptableOrUnknown(
          data['goal_carbohydrates']!,
          _goalCarbohydratesMeta,
        ),
      );
    }
    if (data.containsKey('goal_fiber')) {
      context.handle(
        _goalFiberMeta,
        goalFiber.isAcceptableOrUnknown(data['goal_fiber']!, _goalFiberMeta),
      );
    }
    if (data.containsKey('goal_fat')) {
      context.handle(
        _goalFatMeta,
        goalFat.isAcceptableOrUnknown(data['goal_fat']!, _goalFatMeta),
      );
    }
    if (data.containsKey('has_goal_calories')) {
      context.handle(
        _hasGoalCaloriesMeta,
        hasGoalCalories.isAcceptableOrUnknown(
          data['has_goal_calories']!,
          _hasGoalCaloriesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hasGoalCaloriesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  NutritionalPlanTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionalPlanTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      creationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_date'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end'],
      ),
      onlyLogging: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}only_logging'],
      )!,
      goalEnergy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_energy'],
      ),
      goalProtein: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_protein'],
      ),
      goalCarbohydrates: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_carbohydrates'],
      ),
      goalFiber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_fiber'],
      ),
      goalFat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_fat'],
      ),
      hasGoalCalories: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_goal_calories'],
      )!,
    );
  }

  @override
  $NutritionalPlanTableTable createAlias(String alias) {
    return $NutritionalPlanTableTable(attachedDatabase, alias);
  }
}

class NutritionalPlanTableData extends DataClass
    implements Insertable<NutritionalPlanTableData> {
  final String id;
  final String description;
  final DateTime creationDate;
  final DateTime startDate;
  final DateTime? endDate;
  final bool onlyLogging;
  final int? goalEnergy;
  final int? goalProtein;
  final int? goalCarbohydrates;
  final int? goalFiber;
  final int? goalFat;
  final bool hasGoalCalories;
  const NutritionalPlanTableData({
    required this.id,
    required this.description,
    required this.creationDate,
    required this.startDate,
    this.endDate,
    required this.onlyLogging,
    this.goalEnergy,
    this.goalProtein,
    this.goalCarbohydrates,
    this.goalFiber,
    this.goalFat,
    required this.hasGoalCalories,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['description'] = Variable<String>(description);
    map['creation_date'] = Variable<DateTime>(creationDate);
    map['start'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end'] = Variable<DateTime>(endDate);
    }
    map['only_logging'] = Variable<bool>(onlyLogging);
    if (!nullToAbsent || goalEnergy != null) {
      map['goal_energy'] = Variable<int>(goalEnergy);
    }
    if (!nullToAbsent || goalProtein != null) {
      map['goal_protein'] = Variable<int>(goalProtein);
    }
    if (!nullToAbsent || goalCarbohydrates != null) {
      map['goal_carbohydrates'] = Variable<int>(goalCarbohydrates);
    }
    if (!nullToAbsent || goalFiber != null) {
      map['goal_fiber'] = Variable<int>(goalFiber);
    }
    if (!nullToAbsent || goalFat != null) {
      map['goal_fat'] = Variable<int>(goalFat);
    }
    map['has_goal_calories'] = Variable<bool>(hasGoalCalories);
    return map;
  }

  NutritionalPlanTableCompanion toCompanion(bool nullToAbsent) {
    return NutritionalPlanTableCompanion(
      id: Value(id),
      description: Value(description),
      creationDate: Value(creationDate),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      onlyLogging: Value(onlyLogging),
      goalEnergy: goalEnergy == null && nullToAbsent
          ? const Value.absent()
          : Value(goalEnergy),
      goalProtein: goalProtein == null && nullToAbsent
          ? const Value.absent()
          : Value(goalProtein),
      goalCarbohydrates: goalCarbohydrates == null && nullToAbsent
          ? const Value.absent()
          : Value(goalCarbohydrates),
      goalFiber: goalFiber == null && nullToAbsent
          ? const Value.absent()
          : Value(goalFiber),
      goalFat: goalFat == null && nullToAbsent
          ? const Value.absent()
          : Value(goalFat),
      hasGoalCalories: Value(hasGoalCalories),
    );
  }

  factory NutritionalPlanTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionalPlanTableData(
      id: serializer.fromJson<String>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      creationDate: serializer.fromJson<DateTime>(json['creationDate']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      onlyLogging: serializer.fromJson<bool>(json['onlyLogging']),
      goalEnergy: serializer.fromJson<int?>(json['goalEnergy']),
      goalProtein: serializer.fromJson<int?>(json['goalProtein']),
      goalCarbohydrates: serializer.fromJson<int?>(json['goalCarbohydrates']),
      goalFiber: serializer.fromJson<int?>(json['goalFiber']),
      goalFat: serializer.fromJson<int?>(json['goalFat']),
      hasGoalCalories: serializer.fromJson<bool>(json['hasGoalCalories']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'description': serializer.toJson<String>(description),
      'creationDate': serializer.toJson<DateTime>(creationDate),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'onlyLogging': serializer.toJson<bool>(onlyLogging),
      'goalEnergy': serializer.toJson<int?>(goalEnergy),
      'goalProtein': serializer.toJson<int?>(goalProtein),
      'goalCarbohydrates': serializer.toJson<int?>(goalCarbohydrates),
      'goalFiber': serializer.toJson<int?>(goalFiber),
      'goalFat': serializer.toJson<int?>(goalFat),
      'hasGoalCalories': serializer.toJson<bool>(hasGoalCalories),
    };
  }

  NutritionalPlanTableData copyWith({
    String? id,
    String? description,
    DateTime? creationDate,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    bool? onlyLogging,
    Value<int?> goalEnergy = const Value.absent(),
    Value<int?> goalProtein = const Value.absent(),
    Value<int?> goalCarbohydrates = const Value.absent(),
    Value<int?> goalFiber = const Value.absent(),
    Value<int?> goalFat = const Value.absent(),
    bool? hasGoalCalories,
  }) => NutritionalPlanTableData(
    id: id ?? this.id,
    description: description ?? this.description,
    creationDate: creationDate ?? this.creationDate,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    onlyLogging: onlyLogging ?? this.onlyLogging,
    goalEnergy: goalEnergy.present ? goalEnergy.value : this.goalEnergy,
    goalProtein: goalProtein.present ? goalProtein.value : this.goalProtein,
    goalCarbohydrates: goalCarbohydrates.present
        ? goalCarbohydrates.value
        : this.goalCarbohydrates,
    goalFiber: goalFiber.present ? goalFiber.value : this.goalFiber,
    goalFat: goalFat.present ? goalFat.value : this.goalFat,
    hasGoalCalories: hasGoalCalories ?? this.hasGoalCalories,
  );
  NutritionalPlanTableData copyWithCompanion(
    NutritionalPlanTableCompanion data,
  ) {
    return NutritionalPlanTableData(
      id: data.id.present ? data.id.value : this.id,
      description: data.description.present
          ? data.description.value
          : this.description,
      creationDate: data.creationDate.present
          ? data.creationDate.value
          : this.creationDate,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      onlyLogging: data.onlyLogging.present
          ? data.onlyLogging.value
          : this.onlyLogging,
      goalEnergy: data.goalEnergy.present
          ? data.goalEnergy.value
          : this.goalEnergy,
      goalProtein: data.goalProtein.present
          ? data.goalProtein.value
          : this.goalProtein,
      goalCarbohydrates: data.goalCarbohydrates.present
          ? data.goalCarbohydrates.value
          : this.goalCarbohydrates,
      goalFiber: data.goalFiber.present ? data.goalFiber.value : this.goalFiber,
      goalFat: data.goalFat.present ? data.goalFat.value : this.goalFat,
      hasGoalCalories: data.hasGoalCalories.present
          ? data.hasGoalCalories.value
          : this.hasGoalCalories,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionalPlanTableData(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('creationDate: $creationDate, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('onlyLogging: $onlyLogging, ')
          ..write('goalEnergy: $goalEnergy, ')
          ..write('goalProtein: $goalProtein, ')
          ..write('goalCarbohydrates: $goalCarbohydrates, ')
          ..write('goalFiber: $goalFiber, ')
          ..write('goalFat: $goalFat, ')
          ..write('hasGoalCalories: $hasGoalCalories')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    description,
    creationDate,
    startDate,
    endDate,
    onlyLogging,
    goalEnergy,
    goalProtein,
    goalCarbohydrates,
    goalFiber,
    goalFat,
    hasGoalCalories,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionalPlanTableData &&
          other.id == this.id &&
          other.description == this.description &&
          other.creationDate == this.creationDate &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.onlyLogging == this.onlyLogging &&
          other.goalEnergy == this.goalEnergy &&
          other.goalProtein == this.goalProtein &&
          other.goalCarbohydrates == this.goalCarbohydrates &&
          other.goalFiber == this.goalFiber &&
          other.goalFat == this.goalFat &&
          other.hasGoalCalories == this.hasGoalCalories);
}

class NutritionalPlanTableCompanion
    extends UpdateCompanion<NutritionalPlanTableData> {
  final Value<String> id;
  final Value<String> description;
  final Value<DateTime> creationDate;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<bool> onlyLogging;
  final Value<int?> goalEnergy;
  final Value<int?> goalProtein;
  final Value<int?> goalCarbohydrates;
  final Value<int?> goalFiber;
  final Value<int?> goalFat;
  final Value<bool> hasGoalCalories;
  final Value<int> rowid;
  const NutritionalPlanTableCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.creationDate = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.onlyLogging = const Value.absent(),
    this.goalEnergy = const Value.absent(),
    this.goalProtein = const Value.absent(),
    this.goalCarbohydrates = const Value.absent(),
    this.goalFiber = const Value.absent(),
    this.goalFat = const Value.absent(),
    this.hasGoalCalories = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NutritionalPlanTableCompanion.insert({
    this.id = const Value.absent(),
    required String description,
    required DateTime creationDate,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    required bool onlyLogging,
    this.goalEnergy = const Value.absent(),
    this.goalProtein = const Value.absent(),
    this.goalCarbohydrates = const Value.absent(),
    this.goalFiber = const Value.absent(),
    this.goalFat = const Value.absent(),
    required bool hasGoalCalories,
    this.rowid = const Value.absent(),
  }) : description = Value(description),
       creationDate = Value(creationDate),
       startDate = Value(startDate),
       onlyLogging = Value(onlyLogging),
       hasGoalCalories = Value(hasGoalCalories);
  static Insertable<NutritionalPlanTableData> custom({
    Expression<String>? id,
    Expression<String>? description,
    Expression<DateTime>? creationDate,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? onlyLogging,
    Expression<int>? goalEnergy,
    Expression<int>? goalProtein,
    Expression<int>? goalCarbohydrates,
    Expression<int>? goalFiber,
    Expression<int>? goalFat,
    Expression<bool>? hasGoalCalories,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (creationDate != null) 'creation_date': creationDate,
      if (startDate != null) 'start': startDate,
      if (endDate != null) 'end': endDate,
      if (onlyLogging != null) 'only_logging': onlyLogging,
      if (goalEnergy != null) 'goal_energy': goalEnergy,
      if (goalProtein != null) 'goal_protein': goalProtein,
      if (goalCarbohydrates != null) 'goal_carbohydrates': goalCarbohydrates,
      if (goalFiber != null) 'goal_fiber': goalFiber,
      if (goalFat != null) 'goal_fat': goalFat,
      if (hasGoalCalories != null) 'has_goal_calories': hasGoalCalories,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NutritionalPlanTableCompanion copyWith({
    Value<String>? id,
    Value<String>? description,
    Value<DateTime>? creationDate,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<bool>? onlyLogging,
    Value<int?>? goalEnergy,
    Value<int?>? goalProtein,
    Value<int?>? goalCarbohydrates,
    Value<int?>? goalFiber,
    Value<int?>? goalFat,
    Value<bool>? hasGoalCalories,
    Value<int>? rowid,
  }) {
    return NutritionalPlanTableCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      creationDate: creationDate ?? this.creationDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      onlyLogging: onlyLogging ?? this.onlyLogging,
      goalEnergy: goalEnergy ?? this.goalEnergy,
      goalProtein: goalProtein ?? this.goalProtein,
      goalCarbohydrates: goalCarbohydrates ?? this.goalCarbohydrates,
      goalFiber: goalFiber ?? this.goalFiber,
      goalFat: goalFat ?? this.goalFat,
      hasGoalCalories: hasGoalCalories ?? this.hasGoalCalories,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    if (startDate.present) {
      map['start'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end'] = Variable<DateTime>(endDate.value);
    }
    if (onlyLogging.present) {
      map['only_logging'] = Variable<bool>(onlyLogging.value);
    }
    if (goalEnergy.present) {
      map['goal_energy'] = Variable<int>(goalEnergy.value);
    }
    if (goalProtein.present) {
      map['goal_protein'] = Variable<int>(goalProtein.value);
    }
    if (goalCarbohydrates.present) {
      map['goal_carbohydrates'] = Variable<int>(goalCarbohydrates.value);
    }
    if (goalFiber.present) {
      map['goal_fiber'] = Variable<int>(goalFiber.value);
    }
    if (goalFat.present) {
      map['goal_fat'] = Variable<int>(goalFat.value);
    }
    if (hasGoalCalories.present) {
      map['has_goal_calories'] = Variable<bool>(hasGoalCalories.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionalPlanTableCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('creationDate: $creationDate, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('onlyLogging: $onlyLogging, ')
          ..write('goalEnergy: $goalEnergy, ')
          ..write('goalProtein: $goalProtein, ')
          ..write('goalCarbohydrates: $goalCarbohydrates, ')
          ..write('goalFiber: $goalFiber, ')
          ..write('goalFat: $goalFat, ')
          ..write('hasGoalCalories: $hasGoalCalories, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IngredientTableTable extends IngredientTable
    with TableInfo<$IngredientTableTable, IngredientTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => ps.uuid.v4(),
  );
  static const VerificationMeta _languageIdMeta = const VerificationMeta(
    'languageId',
  );
  @override
  late final GeneratedColumn<int> languageId = GeneratedColumn<int>(
    'language_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceNameMeta = const VerificationMeta(
    'sourceName',
  );
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
    'source_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceUrlMeta = const VerificationMeta(
    'sourceUrl',
  );
  @override
  late final GeneratedColumn<String> sourceUrl = GeneratedColumn<String>(
    'source_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licenseObjectURlMeta = const VerificationMeta(
    'licenseObjectURl',
  );
  @override
  late final GeneratedColumn<String> licenseObjectURl = GeneratedColumn<String>(
    'license_object_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _energyMeta = const VerificationMeta('energy');
  @override
  late final GeneratedColumn<int> energy = GeneratedColumn<int>(
    'energy',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbohydratesMeta = const VerificationMeta(
    'carbohydrates',
  );
  @override
  late final GeneratedColumn<double> carbohydrates = GeneratedColumn<double>(
    'carbohydrates',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbohydratesSugarMeta =
      const VerificationMeta('carbohydratesSugar');
  @override
  late final GeneratedColumn<double> carbohydratesSugar =
      GeneratedColumn<double>(
        'carbohydrates_sugar',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
    'fat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatSaturatedMeta = const VerificationMeta(
    'fatSaturated',
  );
  @override
  late final GeneratedColumn<double> fatSaturated = GeneratedColumn<double>(
    'fat_saturated',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fiberMeta = const VerificationMeta('fiber');
  @override
  late final GeneratedColumn<double> fiber = GeneratedColumn<double>(
    'fiber',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sodiumMeta = const VerificationMeta('sodium');
  @override
  late final GeneratedColumn<double> sodium = GeneratedColumn<double>(
    'sodium',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isVeganMeta = const VerificationMeta(
    'isVegan',
  );
  @override
  late final GeneratedColumn<bool> isVegan = GeneratedColumn<bool>(
    'is_vegan',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_vegan" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isVegetarianMeta = const VerificationMeta(
    'isVegetarian',
  );
  @override
  late final GeneratedColumn<bool> isVegetarian = GeneratedColumn<bool>(
    'is_vegetarian',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_vegetarian" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<NutriScore?, String> nutriscore =
      GeneratedColumn<String>(
        'nutriscore',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<NutriScore?>($IngredientTableTable.$converternutriscoren);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    languageId,
    remoteId,
    sourceName,
    sourceUrl,
    licenseObjectURl,
    code,
    name,
    created,
    energy,
    carbohydrates,
    carbohydratesSugar,
    protein,
    fat,
    fatSaturated,
    fiber,
    sodium,
    isVegan,
    isVegetarian,
    nutriscore,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_ingredient';
  @override
  VerificationContext validateIntegrity(
    Insertable<IngredientTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    }
    if (data.containsKey('language_id')) {
      context.handle(
        _languageIdMeta,
        languageId.isAcceptableOrUnknown(data['language_id']!, _languageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_languageIdMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('source_name')) {
      context.handle(
        _sourceNameMeta,
        sourceName.isAcceptableOrUnknown(data['source_name']!, _sourceNameMeta),
      );
    }
    if (data.containsKey('source_url')) {
      context.handle(
        _sourceUrlMeta,
        sourceUrl.isAcceptableOrUnknown(data['source_url']!, _sourceUrlMeta),
      );
    }
    if (data.containsKey('license_object_url')) {
      context.handle(
        _licenseObjectURlMeta,
        licenseObjectURl.isAcceptableOrUnknown(
          data['license_object_url']!,
          _licenseObjectURlMeta,
        ),
      );
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('energy')) {
      context.handle(
        _energyMeta,
        energy.isAcceptableOrUnknown(data['energy']!, _energyMeta),
      );
    } else if (isInserting) {
      context.missing(_energyMeta);
    }
    if (data.containsKey('carbohydrates')) {
      context.handle(
        _carbohydratesMeta,
        carbohydrates.isAcceptableOrUnknown(
          data['carbohydrates']!,
          _carbohydratesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbohydratesMeta);
    }
    if (data.containsKey('carbohydrates_sugar')) {
      context.handle(
        _carbohydratesSugarMeta,
        carbohydratesSugar.isAcceptableOrUnknown(
          data['carbohydrates_sugar']!,
          _carbohydratesSugarMeta,
        ),
      );
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinMeta);
    }
    if (data.containsKey('fat')) {
      context.handle(
        _fatMeta,
        fat.isAcceptableOrUnknown(data['fat']!, _fatMeta),
      );
    } else if (isInserting) {
      context.missing(_fatMeta);
    }
    if (data.containsKey('fat_saturated')) {
      context.handle(
        _fatSaturatedMeta,
        fatSaturated.isAcceptableOrUnknown(
          data['fat_saturated']!,
          _fatSaturatedMeta,
        ),
      );
    }
    if (data.containsKey('fiber')) {
      context.handle(
        _fiberMeta,
        fiber.isAcceptableOrUnknown(data['fiber']!, _fiberMeta),
      );
    }
    if (data.containsKey('sodium')) {
      context.handle(
        _sodiumMeta,
        sodium.isAcceptableOrUnknown(data['sodium']!, _sodiumMeta),
      );
    }
    if (data.containsKey('is_vegan')) {
      context.handle(
        _isVeganMeta,
        isVegan.isAcceptableOrUnknown(data['is_vegan']!, _isVeganMeta),
      );
    }
    if (data.containsKey('is_vegetarian')) {
      context.handle(
        _isVegetarianMeta,
        isVegetarian.isAcceptableOrUnknown(
          data['is_vegetarian']!,
          _isVegetarianMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  IngredientTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IngredientTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      languageId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}language_id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      sourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_name'],
      ),
      sourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_url'],
      ),
      licenseObjectURl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_object_url'],
      ),
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created'],
      )!,
      energy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy'],
      )!,
      carbohydrates: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbohydrates'],
      )!,
      carbohydratesSugar: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbohydrates_sugar'],
      ),
      protein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein'],
      )!,
      fat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat'],
      )!,
      fatSaturated: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_saturated'],
      ),
      fiber: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber'],
      ),
      sodium: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sodium'],
      ),
      isVegan: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_vegan'],
      ),
      isVegetarian: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_vegetarian'],
      ),
      nutriscore: $IngredientTableTable.$converternutriscoren.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}nutriscore'],
        ),
      ),
    );
  }

  @override
  $IngredientTableTable createAlias(String alias) {
    return $IngredientTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<NutriScore, String, String> $converternutriscore =
      const EnumNameConverter<NutriScore>(NutriScore.values);
  static JsonTypeConverter2<NutriScore?, String?, String?>
  $converternutriscoren = JsonTypeConverter2.asNullable($converternutriscore);
}

class IngredientTableData extends DataClass
    implements Insertable<IngredientTableData> {
  final int id;
  final String uuid;
  final int languageId;
  final String? remoteId;
  final String? sourceName;
  final String? sourceUrl;
  final String? licenseObjectURl;
  final String? code;
  final String name;
  final DateTime created;
  final int energy;
  final double carbohydrates;
  final double? carbohydratesSugar;
  final double protein;
  final double fat;
  final double? fatSaturated;
  final double? fiber;
  final double? sodium;
  final bool? isVegan;
  final bool? isVegetarian;
  final NutriScore? nutriscore;
  const IngredientTableData({
    required this.id,
    required this.uuid,
    required this.languageId,
    this.remoteId,
    this.sourceName,
    this.sourceUrl,
    this.licenseObjectURl,
    this.code,
    required this.name,
    required this.created,
    required this.energy,
    required this.carbohydrates,
    this.carbohydratesSugar,
    required this.protein,
    required this.fat,
    this.fatSaturated,
    this.fiber,
    this.sodium,
    this.isVegan,
    this.isVegetarian,
    this.nutriscore,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['language_id'] = Variable<int>(languageId);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || sourceName != null) {
      map['source_name'] = Variable<String>(sourceName);
    }
    if (!nullToAbsent || sourceUrl != null) {
      map['source_url'] = Variable<String>(sourceUrl);
    }
    if (!nullToAbsent || licenseObjectURl != null) {
      map['license_object_url'] = Variable<String>(licenseObjectURl);
    }
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['name'] = Variable<String>(name);
    map['created'] = Variable<DateTime>(created);
    map['energy'] = Variable<int>(energy);
    map['carbohydrates'] = Variable<double>(carbohydrates);
    if (!nullToAbsent || carbohydratesSugar != null) {
      map['carbohydrates_sugar'] = Variable<double>(carbohydratesSugar);
    }
    map['protein'] = Variable<double>(protein);
    map['fat'] = Variable<double>(fat);
    if (!nullToAbsent || fatSaturated != null) {
      map['fat_saturated'] = Variable<double>(fatSaturated);
    }
    if (!nullToAbsent || fiber != null) {
      map['fiber'] = Variable<double>(fiber);
    }
    if (!nullToAbsent || sodium != null) {
      map['sodium'] = Variable<double>(sodium);
    }
    if (!nullToAbsent || isVegan != null) {
      map['is_vegan'] = Variable<bool>(isVegan);
    }
    if (!nullToAbsent || isVegetarian != null) {
      map['is_vegetarian'] = Variable<bool>(isVegetarian);
    }
    if (!nullToAbsent || nutriscore != null) {
      map['nutriscore'] = Variable<String>(
        $IngredientTableTable.$converternutriscoren.toSql(nutriscore),
      );
    }
    return map;
  }

  IngredientTableCompanion toCompanion(bool nullToAbsent) {
    return IngredientTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      languageId: Value(languageId),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      sourceName: sourceName == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceName),
      sourceUrl: sourceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceUrl),
      licenseObjectURl: licenseObjectURl == null && nullToAbsent
          ? const Value.absent()
          : Value(licenseObjectURl),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      name: Value(name),
      created: Value(created),
      energy: Value(energy),
      carbohydrates: Value(carbohydrates),
      carbohydratesSugar: carbohydratesSugar == null && nullToAbsent
          ? const Value.absent()
          : Value(carbohydratesSugar),
      protein: Value(protein),
      fat: Value(fat),
      fatSaturated: fatSaturated == null && nullToAbsent
          ? const Value.absent()
          : Value(fatSaturated),
      fiber: fiber == null && nullToAbsent
          ? const Value.absent()
          : Value(fiber),
      sodium: sodium == null && nullToAbsent
          ? const Value.absent()
          : Value(sodium),
      isVegan: isVegan == null && nullToAbsent
          ? const Value.absent()
          : Value(isVegan),
      isVegetarian: isVegetarian == null && nullToAbsent
          ? const Value.absent()
          : Value(isVegetarian),
      nutriscore: nutriscore == null && nullToAbsent
          ? const Value.absent()
          : Value(nutriscore),
    );
  }

  factory IngredientTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IngredientTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      languageId: serializer.fromJson<int>(json['languageId']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      sourceName: serializer.fromJson<String?>(json['sourceName']),
      sourceUrl: serializer.fromJson<String?>(json['sourceUrl']),
      licenseObjectURl: serializer.fromJson<String?>(json['licenseObjectURl']),
      code: serializer.fromJson<String?>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      created: serializer.fromJson<DateTime>(json['created']),
      energy: serializer.fromJson<int>(json['energy']),
      carbohydrates: serializer.fromJson<double>(json['carbohydrates']),
      carbohydratesSugar: serializer.fromJson<double?>(
        json['carbohydratesSugar'],
      ),
      protein: serializer.fromJson<double>(json['protein']),
      fat: serializer.fromJson<double>(json['fat']),
      fatSaturated: serializer.fromJson<double?>(json['fatSaturated']),
      fiber: serializer.fromJson<double?>(json['fiber']),
      sodium: serializer.fromJson<double?>(json['sodium']),
      isVegan: serializer.fromJson<bool?>(json['isVegan']),
      isVegetarian: serializer.fromJson<bool?>(json['isVegetarian']),
      nutriscore: $IngredientTableTable.$converternutriscoren.fromJson(
        serializer.fromJson<String?>(json['nutriscore']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'languageId': serializer.toJson<int>(languageId),
      'remoteId': serializer.toJson<String?>(remoteId),
      'sourceName': serializer.toJson<String?>(sourceName),
      'sourceUrl': serializer.toJson<String?>(sourceUrl),
      'licenseObjectURl': serializer.toJson<String?>(licenseObjectURl),
      'code': serializer.toJson<String?>(code),
      'name': serializer.toJson<String>(name),
      'created': serializer.toJson<DateTime>(created),
      'energy': serializer.toJson<int>(energy),
      'carbohydrates': serializer.toJson<double>(carbohydrates),
      'carbohydratesSugar': serializer.toJson<double?>(carbohydratesSugar),
      'protein': serializer.toJson<double>(protein),
      'fat': serializer.toJson<double>(fat),
      'fatSaturated': serializer.toJson<double?>(fatSaturated),
      'fiber': serializer.toJson<double?>(fiber),
      'sodium': serializer.toJson<double?>(sodium),
      'isVegan': serializer.toJson<bool?>(isVegan),
      'isVegetarian': serializer.toJson<bool?>(isVegetarian),
      'nutriscore': serializer.toJson<String?>(
        $IngredientTableTable.$converternutriscoren.toJson(nutriscore),
      ),
    };
  }

  IngredientTableData copyWith({
    int? id,
    String? uuid,
    int? languageId,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> sourceName = const Value.absent(),
    Value<String?> sourceUrl = const Value.absent(),
    Value<String?> licenseObjectURl = const Value.absent(),
    Value<String?> code = const Value.absent(),
    String? name,
    DateTime? created,
    int? energy,
    double? carbohydrates,
    Value<double?> carbohydratesSugar = const Value.absent(),
    double? protein,
    double? fat,
    Value<double?> fatSaturated = const Value.absent(),
    Value<double?> fiber = const Value.absent(),
    Value<double?> sodium = const Value.absent(),
    Value<bool?> isVegan = const Value.absent(),
    Value<bool?> isVegetarian = const Value.absent(),
    Value<NutriScore?> nutriscore = const Value.absent(),
  }) => IngredientTableData(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    languageId: languageId ?? this.languageId,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    sourceName: sourceName.present ? sourceName.value : this.sourceName,
    sourceUrl: sourceUrl.present ? sourceUrl.value : this.sourceUrl,
    licenseObjectURl: licenseObjectURl.present
        ? licenseObjectURl.value
        : this.licenseObjectURl,
    code: code.present ? code.value : this.code,
    name: name ?? this.name,
    created: created ?? this.created,
    energy: energy ?? this.energy,
    carbohydrates: carbohydrates ?? this.carbohydrates,
    carbohydratesSugar: carbohydratesSugar.present
        ? carbohydratesSugar.value
        : this.carbohydratesSugar,
    protein: protein ?? this.protein,
    fat: fat ?? this.fat,
    fatSaturated: fatSaturated.present ? fatSaturated.value : this.fatSaturated,
    fiber: fiber.present ? fiber.value : this.fiber,
    sodium: sodium.present ? sodium.value : this.sodium,
    isVegan: isVegan.present ? isVegan.value : this.isVegan,
    isVegetarian: isVegetarian.present ? isVegetarian.value : this.isVegetarian,
    nutriscore: nutriscore.present ? nutriscore.value : this.nutriscore,
  );
  IngredientTableData copyWithCompanion(IngredientTableCompanion data) {
    return IngredientTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      languageId: data.languageId.present
          ? data.languageId.value
          : this.languageId,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      sourceName: data.sourceName.present
          ? data.sourceName.value
          : this.sourceName,
      sourceUrl: data.sourceUrl.present ? data.sourceUrl.value : this.sourceUrl,
      licenseObjectURl: data.licenseObjectURl.present
          ? data.licenseObjectURl.value
          : this.licenseObjectURl,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      created: data.created.present ? data.created.value : this.created,
      energy: data.energy.present ? data.energy.value : this.energy,
      carbohydrates: data.carbohydrates.present
          ? data.carbohydrates.value
          : this.carbohydrates,
      carbohydratesSugar: data.carbohydratesSugar.present
          ? data.carbohydratesSugar.value
          : this.carbohydratesSugar,
      protein: data.protein.present ? data.protein.value : this.protein,
      fat: data.fat.present ? data.fat.value : this.fat,
      fatSaturated: data.fatSaturated.present
          ? data.fatSaturated.value
          : this.fatSaturated,
      fiber: data.fiber.present ? data.fiber.value : this.fiber,
      sodium: data.sodium.present ? data.sodium.value : this.sodium,
      isVegan: data.isVegan.present ? data.isVegan.value : this.isVegan,
      isVegetarian: data.isVegetarian.present
          ? data.isVegetarian.value
          : this.isVegetarian,
      nutriscore: data.nutriscore.present
          ? data.nutriscore.value
          : this.nutriscore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IngredientTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('languageId: $languageId, ')
          ..write('remoteId: $remoteId, ')
          ..write('sourceName: $sourceName, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('licenseObjectURl: $licenseObjectURl, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('created: $created, ')
          ..write('energy: $energy, ')
          ..write('carbohydrates: $carbohydrates, ')
          ..write('carbohydratesSugar: $carbohydratesSugar, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('fatSaturated: $fatSaturated, ')
          ..write('fiber: $fiber, ')
          ..write('sodium: $sodium, ')
          ..write('isVegan: $isVegan, ')
          ..write('isVegetarian: $isVegetarian, ')
          ..write('nutriscore: $nutriscore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    uuid,
    languageId,
    remoteId,
    sourceName,
    sourceUrl,
    licenseObjectURl,
    code,
    name,
    created,
    energy,
    carbohydrates,
    carbohydratesSugar,
    protein,
    fat,
    fatSaturated,
    fiber,
    sodium,
    isVegan,
    isVegetarian,
    nutriscore,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IngredientTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.languageId == this.languageId &&
          other.remoteId == this.remoteId &&
          other.sourceName == this.sourceName &&
          other.sourceUrl == this.sourceUrl &&
          other.licenseObjectURl == this.licenseObjectURl &&
          other.code == this.code &&
          other.name == this.name &&
          other.created == this.created &&
          other.energy == this.energy &&
          other.carbohydrates == this.carbohydrates &&
          other.carbohydratesSugar == this.carbohydratesSugar &&
          other.protein == this.protein &&
          other.fat == this.fat &&
          other.fatSaturated == this.fatSaturated &&
          other.fiber == this.fiber &&
          other.sodium == this.sodium &&
          other.isVegan == this.isVegan &&
          other.isVegetarian == this.isVegetarian &&
          other.nutriscore == this.nutriscore);
}

class IngredientTableCompanion extends UpdateCompanion<IngredientTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<int> languageId;
  final Value<String?> remoteId;
  final Value<String?> sourceName;
  final Value<String?> sourceUrl;
  final Value<String?> licenseObjectURl;
  final Value<String?> code;
  final Value<String> name;
  final Value<DateTime> created;
  final Value<int> energy;
  final Value<double> carbohydrates;
  final Value<double?> carbohydratesSugar;
  final Value<double> protein;
  final Value<double> fat;
  final Value<double?> fatSaturated;
  final Value<double?> fiber;
  final Value<double?> sodium;
  final Value<bool?> isVegan;
  final Value<bool?> isVegetarian;
  final Value<NutriScore?> nutriscore;
  final Value<int> rowid;
  const IngredientTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.languageId = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.licenseObjectURl = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.created = const Value.absent(),
    this.energy = const Value.absent(),
    this.carbohydrates = const Value.absent(),
    this.carbohydratesSugar = const Value.absent(),
    this.protein = const Value.absent(),
    this.fat = const Value.absent(),
    this.fatSaturated = const Value.absent(),
    this.fiber = const Value.absent(),
    this.sodium = const Value.absent(),
    this.isVegan = const Value.absent(),
    this.isVegetarian = const Value.absent(),
    this.nutriscore = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IngredientTableCompanion.insert({
    required int id,
    this.uuid = const Value.absent(),
    required int languageId,
    this.remoteId = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.sourceUrl = const Value.absent(),
    this.licenseObjectURl = const Value.absent(),
    this.code = const Value.absent(),
    required String name,
    required DateTime created,
    required int energy,
    required double carbohydrates,
    this.carbohydratesSugar = const Value.absent(),
    required double protein,
    required double fat,
    this.fatSaturated = const Value.absent(),
    this.fiber = const Value.absent(),
    this.sodium = const Value.absent(),
    this.isVegan = const Value.absent(),
    this.isVegetarian = const Value.absent(),
    this.nutriscore = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       languageId = Value(languageId),
       name = Value(name),
       created = Value(created),
       energy = Value(energy),
       carbohydrates = Value(carbohydrates),
       protein = Value(protein),
       fat = Value(fat);
  static Insertable<IngredientTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<int>? languageId,
    Expression<String>? remoteId,
    Expression<String>? sourceName,
    Expression<String>? sourceUrl,
    Expression<String>? licenseObjectURl,
    Expression<String>? code,
    Expression<String>? name,
    Expression<DateTime>? created,
    Expression<int>? energy,
    Expression<double>? carbohydrates,
    Expression<double>? carbohydratesSugar,
    Expression<double>? protein,
    Expression<double>? fat,
    Expression<double>? fatSaturated,
    Expression<double>? fiber,
    Expression<double>? sodium,
    Expression<bool>? isVegan,
    Expression<bool>? isVegetarian,
    Expression<String>? nutriscore,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (languageId != null) 'language_id': languageId,
      if (remoteId != null) 'remote_id': remoteId,
      if (sourceName != null) 'source_name': sourceName,
      if (sourceUrl != null) 'source_url': sourceUrl,
      if (licenseObjectURl != null) 'license_object_url': licenseObjectURl,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (created != null) 'created': created,
      if (energy != null) 'energy': energy,
      if (carbohydrates != null) 'carbohydrates': carbohydrates,
      if (carbohydratesSugar != null) 'carbohydrates_sugar': carbohydratesSugar,
      if (protein != null) 'protein': protein,
      if (fat != null) 'fat': fat,
      if (fatSaturated != null) 'fat_saturated': fatSaturated,
      if (fiber != null) 'fiber': fiber,
      if (sodium != null) 'sodium': sodium,
      if (isVegan != null) 'is_vegan': isVegan,
      if (isVegetarian != null) 'is_vegetarian': isVegetarian,
      if (nutriscore != null) 'nutriscore': nutriscore,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IngredientTableCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<int>? languageId,
    Value<String?>? remoteId,
    Value<String?>? sourceName,
    Value<String?>? sourceUrl,
    Value<String?>? licenseObjectURl,
    Value<String?>? code,
    Value<String>? name,
    Value<DateTime>? created,
    Value<int>? energy,
    Value<double>? carbohydrates,
    Value<double?>? carbohydratesSugar,
    Value<double>? protein,
    Value<double>? fat,
    Value<double?>? fatSaturated,
    Value<double?>? fiber,
    Value<double?>? sodium,
    Value<bool?>? isVegan,
    Value<bool?>? isVegetarian,
    Value<NutriScore?>? nutriscore,
    Value<int>? rowid,
  }) {
    return IngredientTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      languageId: languageId ?? this.languageId,
      remoteId: remoteId ?? this.remoteId,
      sourceName: sourceName ?? this.sourceName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      licenseObjectURl: licenseObjectURl ?? this.licenseObjectURl,
      code: code ?? this.code,
      name: name ?? this.name,
      created: created ?? this.created,
      energy: energy ?? this.energy,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      carbohydratesSugar: carbohydratesSugar ?? this.carbohydratesSugar,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      fatSaturated: fatSaturated ?? this.fatSaturated,
      fiber: fiber ?? this.fiber,
      sodium: sodium ?? this.sodium,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      nutriscore: nutriscore ?? this.nutriscore,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (languageId.present) {
      map['language_id'] = Variable<int>(languageId.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (sourceUrl.present) {
      map['source_url'] = Variable<String>(sourceUrl.value);
    }
    if (licenseObjectURl.present) {
      map['license_object_url'] = Variable<String>(licenseObjectURl.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (energy.present) {
      map['energy'] = Variable<int>(energy.value);
    }
    if (carbohydrates.present) {
      map['carbohydrates'] = Variable<double>(carbohydrates.value);
    }
    if (carbohydratesSugar.present) {
      map['carbohydrates_sugar'] = Variable<double>(carbohydratesSugar.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (fatSaturated.present) {
      map['fat_saturated'] = Variable<double>(fatSaturated.value);
    }
    if (fiber.present) {
      map['fiber'] = Variable<double>(fiber.value);
    }
    if (sodium.present) {
      map['sodium'] = Variable<double>(sodium.value);
    }
    if (isVegan.present) {
      map['is_vegan'] = Variable<bool>(isVegan.value);
    }
    if (isVegetarian.present) {
      map['is_vegetarian'] = Variable<bool>(isVegetarian.value);
    }
    if (nutriscore.present) {
      map['nutriscore'] = Variable<String>(
        $IngredientTableTable.$converternutriscoren.toSql(nutriscore.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('languageId: $languageId, ')
          ..write('remoteId: $remoteId, ')
          ..write('sourceName: $sourceName, ')
          ..write('sourceUrl: $sourceUrl, ')
          ..write('licenseObjectURl: $licenseObjectURl, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('created: $created, ')
          ..write('energy: $energy, ')
          ..write('carbohydrates: $carbohydrates, ')
          ..write('carbohydratesSugar: $carbohydratesSugar, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('fatSaturated: $fatSaturated, ')
          ..write('fiber: $fiber, ')
          ..write('sodium: $sodium, ')
          ..write('isVegan: $isVegan, ')
          ..write('isVegetarian: $isVegetarian, ')
          ..write('nutriscore: $nutriscore, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IngredientImageTableTable extends IngredientImageTable
    with TableInfo<$IngredientImageTableTable, IngredientImageTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientImageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nutrition_ingredient (id)',
    ),
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
    'width',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdateMeta = const VerificationMeta(
    'lastUpdate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
    'last_update',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licenseIdMeta = const VerificationMeta(
    'licenseId',
  );
  @override
  late final GeneratedColumn<int> licenseId = GeneratedColumn<int>(
    'license_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'license_author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authorUrlMeta = const VerificationMeta(
    'authorUrl',
  );
  @override
  late final GeneratedColumn<String> authorUrl = GeneratedColumn<String>(
    'license_author_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'license_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _objectUrlMeta = const VerificationMeta(
    'objectUrl',
  );
  @override
  late final GeneratedColumn<String> objectUrl = GeneratedColumn<String>(
    'license_object_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _derivativeSourceUrlMeta =
      const VerificationMeta('derivativeSourceUrl');
  @override
  late final GeneratedColumn<String> derivativeSourceUrl =
      GeneratedColumn<String>(
        'license_derivative_source_url',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    ingredientId,
    image,
    size,
    width,
    height,
    created,
    lastUpdate,
    licenseId,
    author,
    authorUrl,
    title,
    objectUrl,
    derivativeSourceUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_image';
  @override
  VerificationContext validateIntegrity(
    Insertable<IngredientImageTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
        _lastUpdateMeta,
        lastUpdate.isAcceptableOrUnknown(data['last_update']!, _lastUpdateMeta),
      );
    } else if (isInserting) {
      context.missing(_lastUpdateMeta);
    }
    if (data.containsKey('license_id')) {
      context.handle(
        _licenseIdMeta,
        licenseId.isAcceptableOrUnknown(data['license_id']!, _licenseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_licenseIdMeta);
    }
    if (data.containsKey('license_author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['license_author']!, _authorMeta),
      );
    }
    if (data.containsKey('license_author_url')) {
      context.handle(
        _authorUrlMeta,
        authorUrl.isAcceptableOrUnknown(
          data['license_author_url']!,
          _authorUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_authorUrlMeta);
    }
    if (data.containsKey('license_title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['license_title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('license_object_url')) {
      context.handle(
        _objectUrlMeta,
        objectUrl.isAcceptableOrUnknown(
          data['license_object_url']!,
          _objectUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_objectUrlMeta);
    }
    if (data.containsKey('license_derivative_source_url')) {
      context.handle(
        _derivativeSourceUrlMeta,
        derivativeSourceUrl.isAcceptableOrUnknown(
          data['license_derivative_source_url']!,
          _derivativeSourceUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_derivativeSourceUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  IngredientImageTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IngredientImageTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      )!,
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created'],
      )!,
      lastUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_update'],
      )!,
      licenseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}license_id'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_author'],
      ),
      authorUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_author_url'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_title'],
      )!,
      objectUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_object_url'],
      )!,
      derivativeSourceUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_derivative_source_url'],
      )!,
    );
  }

  @override
  $IngredientImageTableTable createAlias(String alias) {
    return $IngredientImageTableTable(attachedDatabase, alias);
  }
}

class IngredientImageTableData extends DataClass
    implements Insertable<IngredientImageTableData> {
  final int id;
  final String uuid;
  final int ingredientId;
  final String image;
  final int size;
  final int width;
  final int height;
  final DateTime created;
  final DateTime lastUpdate;
  final int licenseId;
  final String? author;
  final String authorUrl;
  final String title;
  final String objectUrl;
  final String derivativeSourceUrl;
  const IngredientImageTableData({
    required this.id,
    required this.uuid,
    required this.ingredientId,
    required this.image,
    required this.size,
    required this.width,
    required this.height,
    required this.created,
    required this.lastUpdate,
    required this.licenseId,
    this.author,
    required this.authorUrl,
    required this.title,
    required this.objectUrl,
    required this.derivativeSourceUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['image'] = Variable<String>(image);
    map['size'] = Variable<int>(size);
    map['width'] = Variable<int>(width);
    map['height'] = Variable<int>(height);
    map['created'] = Variable<DateTime>(created);
    map['last_update'] = Variable<DateTime>(lastUpdate);
    map['license_id'] = Variable<int>(licenseId);
    if (!nullToAbsent || author != null) {
      map['license_author'] = Variable<String>(author);
    }
    map['license_author_url'] = Variable<String>(authorUrl);
    map['license_title'] = Variable<String>(title);
    map['license_object_url'] = Variable<String>(objectUrl);
    map['license_derivative_source_url'] = Variable<String>(
      derivativeSourceUrl,
    );
    return map;
  }

  IngredientImageTableCompanion toCompanion(bool nullToAbsent) {
    return IngredientImageTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      ingredientId: Value(ingredientId),
      image: Value(image),
      size: Value(size),
      width: Value(width),
      height: Value(height),
      created: Value(created),
      lastUpdate: Value(lastUpdate),
      licenseId: Value(licenseId),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      authorUrl: Value(authorUrl),
      title: Value(title),
      objectUrl: Value(objectUrl),
      derivativeSourceUrl: Value(derivativeSourceUrl),
    );
  }

  factory IngredientImageTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IngredientImageTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      image: serializer.fromJson<String>(json['image']),
      size: serializer.fromJson<int>(json['size']),
      width: serializer.fromJson<int>(json['width']),
      height: serializer.fromJson<int>(json['height']),
      created: serializer.fromJson<DateTime>(json['created']),
      lastUpdate: serializer.fromJson<DateTime>(json['lastUpdate']),
      licenseId: serializer.fromJson<int>(json['licenseId']),
      author: serializer.fromJson<String?>(json['author']),
      authorUrl: serializer.fromJson<String>(json['authorUrl']),
      title: serializer.fromJson<String>(json['title']),
      objectUrl: serializer.fromJson<String>(json['objectUrl']),
      derivativeSourceUrl: serializer.fromJson<String>(
        json['derivativeSourceUrl'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'image': serializer.toJson<String>(image),
      'size': serializer.toJson<int>(size),
      'width': serializer.toJson<int>(width),
      'height': serializer.toJson<int>(height),
      'created': serializer.toJson<DateTime>(created),
      'lastUpdate': serializer.toJson<DateTime>(lastUpdate),
      'licenseId': serializer.toJson<int>(licenseId),
      'author': serializer.toJson<String?>(author),
      'authorUrl': serializer.toJson<String>(authorUrl),
      'title': serializer.toJson<String>(title),
      'objectUrl': serializer.toJson<String>(objectUrl),
      'derivativeSourceUrl': serializer.toJson<String>(derivativeSourceUrl),
    };
  }

  IngredientImageTableData copyWith({
    int? id,
    String? uuid,
    int? ingredientId,
    String? image,
    int? size,
    int? width,
    int? height,
    DateTime? created,
    DateTime? lastUpdate,
    int? licenseId,
    Value<String?> author = const Value.absent(),
    String? authorUrl,
    String? title,
    String? objectUrl,
    String? derivativeSourceUrl,
  }) => IngredientImageTableData(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    ingredientId: ingredientId ?? this.ingredientId,
    image: image ?? this.image,
    size: size ?? this.size,
    width: width ?? this.width,
    height: height ?? this.height,
    created: created ?? this.created,
    lastUpdate: lastUpdate ?? this.lastUpdate,
    licenseId: licenseId ?? this.licenseId,
    author: author.present ? author.value : this.author,
    authorUrl: authorUrl ?? this.authorUrl,
    title: title ?? this.title,
    objectUrl: objectUrl ?? this.objectUrl,
    derivativeSourceUrl: derivativeSourceUrl ?? this.derivativeSourceUrl,
  );
  IngredientImageTableData copyWithCompanion(
    IngredientImageTableCompanion data,
  ) {
    return IngredientImageTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      image: data.image.present ? data.image.value : this.image,
      size: data.size.present ? data.size.value : this.size,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      created: data.created.present ? data.created.value : this.created,
      lastUpdate: data.lastUpdate.present
          ? data.lastUpdate.value
          : this.lastUpdate,
      licenseId: data.licenseId.present ? data.licenseId.value : this.licenseId,
      author: data.author.present ? data.author.value : this.author,
      authorUrl: data.authorUrl.present ? data.authorUrl.value : this.authorUrl,
      title: data.title.present ? data.title.value : this.title,
      objectUrl: data.objectUrl.present ? data.objectUrl.value : this.objectUrl,
      derivativeSourceUrl: data.derivativeSourceUrl.present
          ? data.derivativeSourceUrl.value
          : this.derivativeSourceUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IngredientImageTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('image: $image, ')
          ..write('size: $size, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('created: $created, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('licenseId: $licenseId, ')
          ..write('author: $author, ')
          ..write('authorUrl: $authorUrl, ')
          ..write('title: $title, ')
          ..write('objectUrl: $objectUrl, ')
          ..write('derivativeSourceUrl: $derivativeSourceUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    ingredientId,
    image,
    size,
    width,
    height,
    created,
    lastUpdate,
    licenseId,
    author,
    authorUrl,
    title,
    objectUrl,
    derivativeSourceUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IngredientImageTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.ingredientId == this.ingredientId &&
          other.image == this.image &&
          other.size == this.size &&
          other.width == this.width &&
          other.height == this.height &&
          other.created == this.created &&
          other.lastUpdate == this.lastUpdate &&
          other.licenseId == this.licenseId &&
          other.author == this.author &&
          other.authorUrl == this.authorUrl &&
          other.title == this.title &&
          other.objectUrl == this.objectUrl &&
          other.derivativeSourceUrl == this.derivativeSourceUrl);
}

class IngredientImageTableCompanion
    extends UpdateCompanion<IngredientImageTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<int> ingredientId;
  final Value<String> image;
  final Value<int> size;
  final Value<int> width;
  final Value<int> height;
  final Value<DateTime> created;
  final Value<DateTime> lastUpdate;
  final Value<int> licenseId;
  final Value<String?> author;
  final Value<String> authorUrl;
  final Value<String> title;
  final Value<String> objectUrl;
  final Value<String> derivativeSourceUrl;
  final Value<int> rowid;
  const IngredientImageTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.image = const Value.absent(),
    this.size = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.created = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.licenseId = const Value.absent(),
    this.author = const Value.absent(),
    this.authorUrl = const Value.absent(),
    this.title = const Value.absent(),
    this.objectUrl = const Value.absent(),
    this.derivativeSourceUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IngredientImageTableCompanion.insert({
    required int id,
    required String uuid,
    required int ingredientId,
    required String image,
    required int size,
    required int width,
    required int height,
    required DateTime created,
    required DateTime lastUpdate,
    required int licenseId,
    this.author = const Value.absent(),
    required String authorUrl,
    required String title,
    required String objectUrl,
    required String derivativeSourceUrl,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       uuid = Value(uuid),
       ingredientId = Value(ingredientId),
       image = Value(image),
       size = Value(size),
       width = Value(width),
       height = Value(height),
       created = Value(created),
       lastUpdate = Value(lastUpdate),
       licenseId = Value(licenseId),
       authorUrl = Value(authorUrl),
       title = Value(title),
       objectUrl = Value(objectUrl),
       derivativeSourceUrl = Value(derivativeSourceUrl);
  static Insertable<IngredientImageTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<int>? ingredientId,
    Expression<String>? image,
    Expression<int>? size,
    Expression<int>? width,
    Expression<int>? height,
    Expression<DateTime>? created,
    Expression<DateTime>? lastUpdate,
    Expression<int>? licenseId,
    Expression<String>? author,
    Expression<String>? authorUrl,
    Expression<String>? title,
    Expression<String>? objectUrl,
    Expression<String>? derivativeSourceUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (image != null) 'image': image,
      if (size != null) 'size': size,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (created != null) 'created': created,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (licenseId != null) 'license_id': licenseId,
      if (author != null) 'license_author': author,
      if (authorUrl != null) 'license_author_url': authorUrl,
      if (title != null) 'license_title': title,
      if (objectUrl != null) 'license_object_url': objectUrl,
      if (derivativeSourceUrl != null)
        'license_derivative_source_url': derivativeSourceUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IngredientImageTableCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<int>? ingredientId,
    Value<String>? image,
    Value<int>? size,
    Value<int>? width,
    Value<int>? height,
    Value<DateTime>? created,
    Value<DateTime>? lastUpdate,
    Value<int>? licenseId,
    Value<String?>? author,
    Value<String>? authorUrl,
    Value<String>? title,
    Value<String>? objectUrl,
    Value<String>? derivativeSourceUrl,
    Value<int>? rowid,
  }) {
    return IngredientImageTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      ingredientId: ingredientId ?? this.ingredientId,
      image: image ?? this.image,
      size: size ?? this.size,
      width: width ?? this.width,
      height: height ?? this.height,
      created: created ?? this.created,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      licenseId: licenseId ?? this.licenseId,
      author: author ?? this.author,
      authorUrl: authorUrl ?? this.authorUrl,
      title: title ?? this.title,
      objectUrl: objectUrl ?? this.objectUrl,
      derivativeSourceUrl: derivativeSourceUrl ?? this.derivativeSourceUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    if (licenseId.present) {
      map['license_id'] = Variable<int>(licenseId.value);
    }
    if (author.present) {
      map['license_author'] = Variable<String>(author.value);
    }
    if (authorUrl.present) {
      map['license_author_url'] = Variable<String>(authorUrl.value);
    }
    if (title.present) {
      map['license_title'] = Variable<String>(title.value);
    }
    if (objectUrl.present) {
      map['license_object_url'] = Variable<String>(objectUrl.value);
    }
    if (derivativeSourceUrl.present) {
      map['license_derivative_source_url'] = Variable<String>(
        derivativeSourceUrl.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientImageTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('image: $image, ')
          ..write('size: $size, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('created: $created, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('licenseId: $licenseId, ')
          ..write('author: $author, ')
          ..write('authorUrl: $authorUrl, ')
          ..write('title: $title, ')
          ..write('objectUrl: $objectUrl, ')
          ..write('derivativeSourceUrl: $derivativeSourceUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IngredientWeightUnitTableTable extends IngredientWeightUnitTable
    with
        TableInfo<
          $IngredientWeightUnitTableTable,
          IngredientWeightUnitTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientWeightUnitTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nutrition_ingredient (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gramMeta = const VerificationMeta('gram');
  @override
  late final GeneratedColumn<int> gram = GeneratedColumn<int>(
    'gram',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, uuid, ingredientId, name, gram];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_ingredientweightunit';
  @override
  VerificationContext validateIntegrity(
    Insertable<IngredientWeightUnitTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('gram')) {
      context.handle(
        _gramMeta,
        gram.isAcceptableOrUnknown(data['gram']!, _gramMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  IngredientWeightUnitTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IngredientWeightUnitTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      gram: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gram'],
      ),
    );
  }

  @override
  $IngredientWeightUnitTableTable createAlias(String alias) {
    return $IngredientWeightUnitTableTable(attachedDatabase, alias);
  }
}

class IngredientWeightUnitTableData extends DataClass
    implements Insertable<IngredientWeightUnitTableData> {
  final int id;
  final String uuid;
  final int ingredientId;
  final String name;
  final int? gram;
  const IngredientWeightUnitTableData({
    required this.id,
    required this.uuid,
    required this.ingredientId,
    required this.name,
    this.gram,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || gram != null) {
      map['gram'] = Variable<int>(gram);
    }
    return map;
  }

  IngredientWeightUnitTableCompanion toCompanion(bool nullToAbsent) {
    return IngredientWeightUnitTableCompanion(
      id: Value(id),
      uuid: Value(uuid),
      ingredientId: Value(ingredientId),
      name: Value(name),
      gram: gram == null && nullToAbsent ? const Value.absent() : Value(gram),
    );
  }

  factory IngredientWeightUnitTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IngredientWeightUnitTableData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      name: serializer.fromJson<String>(json['name']),
      gram: serializer.fromJson<int?>(json['gram']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'name': serializer.toJson<String>(name),
      'gram': serializer.toJson<int?>(gram),
    };
  }

  IngredientWeightUnitTableData copyWith({
    int? id,
    String? uuid,
    int? ingredientId,
    String? name,
    Value<int?> gram = const Value.absent(),
  }) => IngredientWeightUnitTableData(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    ingredientId: ingredientId ?? this.ingredientId,
    name: name ?? this.name,
    gram: gram.present ? gram.value : this.gram,
  );
  IngredientWeightUnitTableData copyWithCompanion(
    IngredientWeightUnitTableCompanion data,
  ) {
    return IngredientWeightUnitTableData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      name: data.name.present ? data.name.value : this.name,
      gram: data.gram.present ? data.gram.value : this.gram,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IngredientWeightUnitTableData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('name: $name, ')
          ..write('gram: $gram')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uuid, ingredientId, name, gram);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IngredientWeightUnitTableData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.ingredientId == this.ingredientId &&
          other.name == this.name &&
          other.gram == this.gram);
}

class IngredientWeightUnitTableCompanion
    extends UpdateCompanion<IngredientWeightUnitTableData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<int> ingredientId;
  final Value<String> name;
  final Value<int?> gram;
  final Value<int> rowid;
  const IngredientWeightUnitTableCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.name = const Value.absent(),
    this.gram = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IngredientWeightUnitTableCompanion.insert({
    required int id,
    required String uuid,
    required int ingredientId,
    required String name,
    this.gram = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       uuid = Value(uuid),
       ingredientId = Value(ingredientId),
       name = Value(name);
  static Insertable<IngredientWeightUnitTableData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<int>? ingredientId,
    Expression<String>? name,
    Expression<int>? gram,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (name != null) 'name': name,
      if (gram != null) 'gram': gram,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IngredientWeightUnitTableCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<int>? ingredientId,
    Value<String>? name,
    Value<int?>? gram,
    Value<int>? rowid,
  }) {
    return IngredientWeightUnitTableCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      ingredientId: ingredientId ?? this.ingredientId,
      name: name ?? this.name,
      gram: gram ?? this.gram,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gram.present) {
      map['gram'] = Variable<int>(gram.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientWeightUnitTableCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('name: $name, ')
          ..write('gram: $gram, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealTableTable extends MealTable
    with TableInfo<$MealTableTable, mealdomain.Meal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => ps.uuid.v7(),
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nutrition_nutritionplan (id)',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TimeOfDay?, String> time =
      GeneratedColumn<String>(
        'time',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<TimeOfDay?>($MealTableTable.$convertertimen);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [id, planId, order, time, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_meal';
  @override
  VerificationContext validateIntegrity(
    Insertable<mealdomain.Meal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  mealdomain.Meal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return mealdomain.Meal.fromDrift(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      time: $MealTableTable.$convertertimen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}time'],
        ),
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
    );
  }

  @override
  $MealTableTable createAlias(String alias) {
    return $MealTableTable(attachedDatabase, alias);
  }

  static TypeConverter<TimeOfDay, String> $convertertime =
      const TimeOfDayConverter();
  static TypeConverter<TimeOfDay?, String?> $convertertimen =
      NullAwareTypeConverter.wrap($convertertime);
}

class MealTableCompanion extends UpdateCompanion<mealdomain.Meal> {
  final Value<String> id;
  final Value<String> planId;
  final Value<int> order;
  final Value<TimeOfDay?> time;
  final Value<String> name;
  final Value<int> rowid;
  const MealTableCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.order = const Value.absent(),
    this.time = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealTableCompanion.insert({
    this.id = const Value.absent(),
    required String planId,
    this.order = const Value.absent(),
    this.time = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : planId = Value(planId);
  static Insertable<mealdomain.Meal> custom({
    Expression<String>? id,
    Expression<String>? planId,
    Expression<int>? order,
    Expression<String>? time,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (order != null) 'order': order,
      if (time != null) 'time': time,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealTableCompanion copyWith({
    Value<String>? id,
    Value<String>? planId,
    Value<int>? order,
    Value<TimeOfDay?>? time,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return MealTableCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      order: order ?? this.order,
      time: time ?? this.time,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(
        $MealTableTable.$convertertimen.toSql(time.value),
      );
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealTableCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('order: $order, ')
          ..write('time: $time, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealItemTableTable extends MealItemTable
    with TableInfo<$MealItemTableTable, MealItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealItemTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => ps.uuid.v7(),
  );
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<String> mealId = GeneratedColumn<String>(
    'meal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nutrition_meal (id)',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nutrition_ingredient (id)',
    ),
  );
  static const VerificationMeta _weightUnitIdMeta = const VerificationMeta(
    'weightUnitId',
  );
  @override
  late final GeneratedColumn<int> weightUnitId = GeneratedColumn<int>(
    'weight_unit_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mealId,
    ingredientId,
    weightUnitId,
    order,
    amount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_mealitem';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_id')) {
      context.handle(
        _mealIdMeta,
        mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mealIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('weight_unit_id')) {
      context.handle(
        _weightUnitIdMeta,
        weightUnitId.isAcceptableOrUnknown(
          data['weight_unit_id']!,
          _weightUnitIdMeta,
        ),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MealItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealItem.fromDrift(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      weightUnitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight_unit_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
    );
  }

  @override
  $MealItemTableTable createAlias(String alias) {
    return $MealItemTableTable(attachedDatabase, alias);
  }
}

class MealItemTableCompanion extends UpdateCompanion<MealItem> {
  final Value<String> id;
  final Value<String> mealId;
  final Value<int> ingredientId;
  final Value<int?> weightUnitId;
  final Value<int> order;
  final Value<double> amount;
  final Value<int> rowid;
  const MealItemTableCompanion({
    this.id = const Value.absent(),
    this.mealId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.weightUnitId = const Value.absent(),
    this.order = const Value.absent(),
    this.amount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealItemTableCompanion.insert({
    this.id = const Value.absent(),
    required String mealId,
    required int ingredientId,
    this.weightUnitId = const Value.absent(),
    this.order = const Value.absent(),
    required double amount,
    this.rowid = const Value.absent(),
  }) : mealId = Value(mealId),
       ingredientId = Value(ingredientId),
       amount = Value(amount);
  static Insertable<MealItem> custom({
    Expression<String>? id,
    Expression<String>? mealId,
    Expression<int>? ingredientId,
    Expression<int>? weightUnitId,
    Expression<int>? order,
    Expression<double>? amount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealId != null) 'meal_id': mealId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (weightUnitId != null) 'weight_unit_id': weightUnitId,
      if (order != null) 'order': order,
      if (amount != null) 'amount': amount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealItemTableCompanion copyWith({
    Value<String>? id,
    Value<String>? mealId,
    Value<int>? ingredientId,
    Value<int?>? weightUnitId,
    Value<int>? order,
    Value<double>? amount,
    Value<int>? rowid,
  }) {
    return MealItemTableCompanion(
      id: id ?? this.id,
      mealId: mealId ?? this.mealId,
      ingredientId: ingredientId ?? this.ingredientId,
      weightUnitId: weightUnitId ?? this.weightUnitId,
      order: order ?? this.order,
      amount: amount ?? this.amount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mealId.present) {
      map['meal_id'] = Variable<String>(mealId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (weightUnitId.present) {
      map['weight_unit_id'] = Variable<int>(weightUnitId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealItemTableCompanion(')
          ..write('id: $id, ')
          ..write('mealId: $mealId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('weightUnitId: $weightUnitId, ')
          ..write('order: $order, ')
          ..write('amount: $amount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LogItemTableTable extends LogItemTable
    with TableInfo<$LogItemTableTable, LogItemTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogItemTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => ps.uuid.v7(),
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nutrition_nutritionplan (id)',
    ),
  );
  static const VerificationMeta _mealIdMeta = const VerificationMeta('mealId');
  @override
  late final GeneratedColumn<String> mealId = GeneratedColumn<String>(
    'meal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nutrition_ingredient (id)',
    ),
  );
  static const VerificationMeta _weightUnitIdMeta = const VerificationMeta(
    'weightUnitId',
  );
  @override
  late final GeneratedColumn<int> weightUnitId = GeneratedColumn<int>(
    'weight_unit_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datetimeMeta = const VerificationMeta(
    'datetime',
  );
  @override
  late final GeneratedColumn<DateTime> datetime = GeneratedColumn<DateTime>(
    'datetime',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planId,
    mealId,
    ingredientId,
    weightUnitId,
    datetime,
    amount,
    comment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_logitem';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogItemTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('meal_id')) {
      context.handle(
        _mealIdMeta,
        mealId.isAcceptableOrUnknown(data['meal_id']!, _mealIdMeta),
      );
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('weight_unit_id')) {
      context.handle(
        _weightUnitIdMeta,
        weightUnitId.isAcceptableOrUnknown(
          data['weight_unit_id']!,
          _weightUnitIdMeta,
        ),
      );
    }
    if (data.containsKey('datetime')) {
      context.handle(
        _datetimeMeta,
        datetime.isAcceptableOrUnknown(data['datetime']!, _datetimeMeta),
      );
    } else if (isInserting) {
      context.missing(_datetimeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LogItemTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogItemTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      mealId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_id'],
      ),
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      weightUnitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight_unit_id'],
      ),
      datetime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}datetime'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
    );
  }

  @override
  $LogItemTableTable createAlias(String alias) {
    return $LogItemTableTable(attachedDatabase, alias);
  }
}

class LogItemTableData extends DataClass
    implements Insertable<LogItemTableData> {
  final String id;
  final String planId;
  final String? mealId;
  final int ingredientId;
  final int? weightUnitId;
  final DateTime datetime;
  final double amount;
  final String? comment;
  const LogItemTableData({
    required this.id,
    required this.planId,
    this.mealId,
    required this.ingredientId,
    this.weightUnitId,
    required this.datetime,
    required this.amount,
    this.comment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['plan_id'] = Variable<String>(planId);
    if (!nullToAbsent || mealId != null) {
      map['meal_id'] = Variable<String>(mealId);
    }
    map['ingredient_id'] = Variable<int>(ingredientId);
    if (!nullToAbsent || weightUnitId != null) {
      map['weight_unit_id'] = Variable<int>(weightUnitId);
    }
    map['datetime'] = Variable<DateTime>(datetime);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    return map;
  }

  LogItemTableCompanion toCompanion(bool nullToAbsent) {
    return LogItemTableCompanion(
      id: Value(id),
      planId: Value(planId),
      mealId: mealId == null && nullToAbsent
          ? const Value.absent()
          : Value(mealId),
      ingredientId: Value(ingredientId),
      weightUnitId: weightUnitId == null && nullToAbsent
          ? const Value.absent()
          : Value(weightUnitId),
      datetime: Value(datetime),
      amount: Value(amount),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
    );
  }

  factory LogItemTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogItemTableData(
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      mealId: serializer.fromJson<String?>(json['mealId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      weightUnitId: serializer.fromJson<int?>(json['weightUnitId']),
      datetime: serializer.fromJson<DateTime>(json['datetime']),
      amount: serializer.fromJson<double>(json['amount']),
      comment: serializer.fromJson<String?>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'planId': serializer.toJson<String>(planId),
      'mealId': serializer.toJson<String?>(mealId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'weightUnitId': serializer.toJson<int?>(weightUnitId),
      'datetime': serializer.toJson<DateTime>(datetime),
      'amount': serializer.toJson<double>(amount),
      'comment': serializer.toJson<String?>(comment),
    };
  }

  LogItemTableData copyWith({
    String? id,
    String? planId,
    Value<String?> mealId = const Value.absent(),
    int? ingredientId,
    Value<int?> weightUnitId = const Value.absent(),
    DateTime? datetime,
    double? amount,
    Value<String?> comment = const Value.absent(),
  }) => LogItemTableData(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    mealId: mealId.present ? mealId.value : this.mealId,
    ingredientId: ingredientId ?? this.ingredientId,
    weightUnitId: weightUnitId.present ? weightUnitId.value : this.weightUnitId,
    datetime: datetime ?? this.datetime,
    amount: amount ?? this.amount,
    comment: comment.present ? comment.value : this.comment,
  );
  LogItemTableData copyWithCompanion(LogItemTableCompanion data) {
    return LogItemTableData(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      mealId: data.mealId.present ? data.mealId.value : this.mealId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      weightUnitId: data.weightUnitId.present
          ? data.weightUnitId.value
          : this.weightUnitId,
      datetime: data.datetime.present ? data.datetime.value : this.datetime,
      amount: data.amount.present ? data.amount.value : this.amount,
      comment: data.comment.present ? data.comment.value : this.comment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogItemTableData(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('mealId: $mealId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('weightUnitId: $weightUnitId, ')
          ..write('datetime: $datetime, ')
          ..write('amount: $amount, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planId,
    mealId,
    ingredientId,
    weightUnitId,
    datetime,
    amount,
    comment,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogItemTableData &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.mealId == this.mealId &&
          other.ingredientId == this.ingredientId &&
          other.weightUnitId == this.weightUnitId &&
          other.datetime == this.datetime &&
          other.amount == this.amount &&
          other.comment == this.comment);
}

class LogItemTableCompanion extends UpdateCompanion<LogItemTableData> {
  final Value<String> id;
  final Value<String> planId;
  final Value<String?> mealId;
  final Value<int> ingredientId;
  final Value<int?> weightUnitId;
  final Value<DateTime> datetime;
  final Value<double> amount;
  final Value<String?> comment;
  final Value<int> rowid;
  const LogItemTableCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.mealId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.weightUnitId = const Value.absent(),
    this.datetime = const Value.absent(),
    this.amount = const Value.absent(),
    this.comment = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LogItemTableCompanion.insert({
    this.id = const Value.absent(),
    required String planId,
    this.mealId = const Value.absent(),
    required int ingredientId,
    this.weightUnitId = const Value.absent(),
    required DateTime datetime,
    required double amount,
    this.comment = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : planId = Value(planId),
       ingredientId = Value(ingredientId),
       datetime = Value(datetime),
       amount = Value(amount);
  static Insertable<LogItemTableData> custom({
    Expression<String>? id,
    Expression<String>? planId,
    Expression<String>? mealId,
    Expression<int>? ingredientId,
    Expression<int>? weightUnitId,
    Expression<DateTime>? datetime,
    Expression<double>? amount,
    Expression<String>? comment,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (mealId != null) 'meal_id': mealId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (weightUnitId != null) 'weight_unit_id': weightUnitId,
      if (datetime != null) 'datetime': datetime,
      if (amount != null) 'amount': amount,
      if (comment != null) 'comment': comment,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LogItemTableCompanion copyWith({
    Value<String>? id,
    Value<String>? planId,
    Value<String?>? mealId,
    Value<int>? ingredientId,
    Value<int?>? weightUnitId,
    Value<DateTime>? datetime,
    Value<double>? amount,
    Value<String?>? comment,
    Value<int>? rowid,
  }) {
    return LogItemTableCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      mealId: mealId ?? this.mealId,
      ingredientId: ingredientId ?? this.ingredientId,
      weightUnitId: weightUnitId ?? this.weightUnitId,
      datetime: datetime ?? this.datetime,
      amount: amount ?? this.amount,
      comment: comment ?? this.comment,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (mealId.present) {
      map['meal_id'] = Variable<String>(mealId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (weightUnitId.present) {
      map['weight_unit_id'] = Variable<int>(weightUnitId.value);
    }
    if (datetime.present) {
      map['datetime'] = Variable<DateTime>(datetime.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogItemTableCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('mealId: $mealId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('weightUnitId: $weightUnitId, ')
          ..write('datetime: $datetime, ')
          ..write('amount: $amount, ')
          ..write('comment: $comment, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DriftPowersyncDatabase extends GeneratedDatabase {
  _$DriftPowersyncDatabase(QueryExecutor e) : super(e);
  $DriftPowersyncDatabaseManager get managers =>
      $DriftPowersyncDatabaseManager(this);
  late final $NutritionalPlanTableTable nutritionalPlanTable =
      $NutritionalPlanTableTable(this);
  late final $IngredientTableTable ingredientTable = $IngredientTableTable(
    this,
  );
  late final $IngredientImageTableTable ingredientImageTable =
      $IngredientImageTableTable(this);
  late final $IngredientWeightUnitTableTable ingredientWeightUnitTable =
      $IngredientWeightUnitTableTable(this);
  late final $MealTableTable mealTable = $MealTableTable(this);
  late final $MealItemTableTable mealItemTable = $MealItemTableTable(this);
  late final $LogItemTableTable logItemTable = $LogItemTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    nutritionalPlanTable,
    ingredientTable,
    ingredientImageTable,
    ingredientWeightUnitTable,
    mealTable,
    mealItemTable,
    logItemTable,
  ];
}

typedef $$NutritionalPlanTableTableCreateCompanionBuilder =
    NutritionalPlanTableCompanion Function({
      Value<String> id,
      required String description,
      required DateTime creationDate,
      required DateTime startDate,
      Value<DateTime?> endDate,
      required bool onlyLogging,
      Value<int?> goalEnergy,
      Value<int?> goalProtein,
      Value<int?> goalCarbohydrates,
      Value<int?> goalFiber,
      Value<int?> goalFat,
      required bool hasGoalCalories,
      Value<int> rowid,
    });
typedef $$NutritionalPlanTableTableUpdateCompanionBuilder =
    NutritionalPlanTableCompanion Function({
      Value<String> id,
      Value<String> description,
      Value<DateTime> creationDate,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<bool> onlyLogging,
      Value<int?> goalEnergy,
      Value<int?> goalProtein,
      Value<int?> goalCarbohydrates,
      Value<int?> goalFiber,
      Value<int?> goalFat,
      Value<bool> hasGoalCalories,
      Value<int> rowid,
    });

final class $$NutritionalPlanTableTableReferences
    extends
        BaseReferences<
          _$DriftPowersyncDatabase,
          $NutritionalPlanTableTable,
          NutritionalPlanTableData
        > {
  $$NutritionalPlanTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MealTableTable, List<mealdomain.Meal>>
  _mealTableRefsTable(_$DriftPowersyncDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mealTable,
        aliasName: $_aliasNameGenerator(
          db.nutritionalPlanTable.id,
          db.mealTable.planId,
        ),
      );

  $$MealTableTableProcessedTableManager get mealTableRefs {
    final manager = $$MealTableTableTableManager(
      $_db,
      $_db.mealTable,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LogItemTableTable, List<LogItemTableData>>
  _logItemTableRefsTable(_$DriftPowersyncDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.logItemTable,
        aliasName: $_aliasNameGenerator(
          db.nutritionalPlanTable.id,
          db.logItemTable.planId,
        ),
      );

  $$LogItemTableTableProcessedTableManager get logItemTableRefs {
    final manager = $$LogItemTableTableTableManager(
      $_db,
      $_db.logItemTable,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_logItemTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NutritionalPlanTableTableFilterComposer
    extends Composer<_$DriftPowersyncDatabase, $NutritionalPlanTableTable> {
  $$NutritionalPlanTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onlyLogging => $composableBuilder(
    column: $table.onlyLogging,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalEnergy => $composableBuilder(
    column: $table.goalEnergy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalProtein => $composableBuilder(
    column: $table.goalProtein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalCarbohydrates => $composableBuilder(
    column: $table.goalCarbohydrates,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalFiber => $composableBuilder(
    column: $table.goalFiber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get goalFat => $composableBuilder(
    column: $table.goalFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasGoalCalories => $composableBuilder(
    column: $table.hasGoalCalories,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mealTableRefs(
    Expression<bool> Function($$MealTableTableFilterComposer f) f,
  ) {
    final $$MealTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealTable,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTableTableFilterComposer(
            $db: $db,
            $table: $db.mealTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> logItemTableRefs(
    Expression<bool> Function($$LogItemTableTableFilterComposer f) f,
  ) {
    final $$LogItemTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logItemTable,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogItemTableTableFilterComposer(
            $db: $db,
            $table: $db.logItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NutritionalPlanTableTableOrderingComposer
    extends Composer<_$DriftPowersyncDatabase, $NutritionalPlanTableTable> {
  $$NutritionalPlanTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onlyLogging => $composableBuilder(
    column: $table.onlyLogging,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalEnergy => $composableBuilder(
    column: $table.goalEnergy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalProtein => $composableBuilder(
    column: $table.goalProtein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalCarbohydrates => $composableBuilder(
    column: $table.goalCarbohydrates,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalFiber => $composableBuilder(
    column: $table.goalFiber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get goalFat => $composableBuilder(
    column: $table.goalFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasGoalCalories => $composableBuilder(
    column: $table.hasGoalCalories,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NutritionalPlanTableTableAnnotationComposer
    extends Composer<_$DriftPowersyncDatabase, $NutritionalPlanTableTable> {
  $$NutritionalPlanTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get onlyLogging => $composableBuilder(
    column: $table.onlyLogging,
    builder: (column) => column,
  );

  GeneratedColumn<int> get goalEnergy => $composableBuilder(
    column: $table.goalEnergy,
    builder: (column) => column,
  );

  GeneratedColumn<int> get goalProtein => $composableBuilder(
    column: $table.goalProtein,
    builder: (column) => column,
  );

  GeneratedColumn<int> get goalCarbohydrates => $composableBuilder(
    column: $table.goalCarbohydrates,
    builder: (column) => column,
  );

  GeneratedColumn<int> get goalFiber =>
      $composableBuilder(column: $table.goalFiber, builder: (column) => column);

  GeneratedColumn<int> get goalFat =>
      $composableBuilder(column: $table.goalFat, builder: (column) => column);

  GeneratedColumn<bool> get hasGoalCalories => $composableBuilder(
    column: $table.hasGoalCalories,
    builder: (column) => column,
  );

  Expression<T> mealTableRefs<T extends Object>(
    Expression<T> Function($$MealTableTableAnnotationComposer a) f,
  ) {
    final $$MealTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealTable,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTableTableAnnotationComposer(
            $db: $db,
            $table: $db.mealTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> logItemTableRefs<T extends Object>(
    Expression<T> Function($$LogItemTableTableAnnotationComposer a) f,
  ) {
    final $$LogItemTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logItemTable,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogItemTableTableAnnotationComposer(
            $db: $db,
            $table: $db.logItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NutritionalPlanTableTableTableManager
    extends
        RootTableManager<
          _$DriftPowersyncDatabase,
          $NutritionalPlanTableTable,
          NutritionalPlanTableData,
          $$NutritionalPlanTableTableFilterComposer,
          $$NutritionalPlanTableTableOrderingComposer,
          $$NutritionalPlanTableTableAnnotationComposer,
          $$NutritionalPlanTableTableCreateCompanionBuilder,
          $$NutritionalPlanTableTableUpdateCompanionBuilder,
          (NutritionalPlanTableData, $$NutritionalPlanTableTableReferences),
          NutritionalPlanTableData,
          PrefetchHooks Function({bool mealTableRefs, bool logItemTableRefs})
        > {
  $$NutritionalPlanTableTableTableManager(
    _$DriftPowersyncDatabase db,
    $NutritionalPlanTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionalPlanTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionalPlanTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NutritionalPlanTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> creationDate = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<bool> onlyLogging = const Value.absent(),
                Value<int?> goalEnergy = const Value.absent(),
                Value<int?> goalProtein = const Value.absent(),
                Value<int?> goalCarbohydrates = const Value.absent(),
                Value<int?> goalFiber = const Value.absent(),
                Value<int?> goalFat = const Value.absent(),
                Value<bool> hasGoalCalories = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NutritionalPlanTableCompanion(
                id: id,
                description: description,
                creationDate: creationDate,
                startDate: startDate,
                endDate: endDate,
                onlyLogging: onlyLogging,
                goalEnergy: goalEnergy,
                goalProtein: goalProtein,
                goalCarbohydrates: goalCarbohydrates,
                goalFiber: goalFiber,
                goalFat: goalFat,
                hasGoalCalories: hasGoalCalories,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String description,
                required DateTime creationDate,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                required bool onlyLogging,
                Value<int?> goalEnergy = const Value.absent(),
                Value<int?> goalProtein = const Value.absent(),
                Value<int?> goalCarbohydrates = const Value.absent(),
                Value<int?> goalFiber = const Value.absent(),
                Value<int?> goalFat = const Value.absent(),
                required bool hasGoalCalories,
                Value<int> rowid = const Value.absent(),
              }) => NutritionalPlanTableCompanion.insert(
                id: id,
                description: description,
                creationDate: creationDate,
                startDate: startDate,
                endDate: endDate,
                onlyLogging: onlyLogging,
                goalEnergy: goalEnergy,
                goalProtein: goalProtein,
                goalCarbohydrates: goalCarbohydrates,
                goalFiber: goalFiber,
                goalFat: goalFat,
                hasGoalCalories: hasGoalCalories,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NutritionalPlanTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({mealTableRefs = false, logItemTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mealTableRefs) db.mealTable,
                    if (logItemTableRefs) db.logItemTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mealTableRefs)
                        await $_getPrefetchedData<
                          NutritionalPlanTableData,
                          $NutritionalPlanTableTable,
                          mealdomain.Meal
                        >(
                          currentTable: table,
                          referencedTable: $$NutritionalPlanTableTableReferences
                              ._mealTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NutritionalPlanTableTableReferences(
                                db,
                                table,
                                p0,
                              ).mealTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (logItemTableRefs)
                        await $_getPrefetchedData<
                          NutritionalPlanTableData,
                          $NutritionalPlanTableTable,
                          LogItemTableData
                        >(
                          currentTable: table,
                          referencedTable: $$NutritionalPlanTableTableReferences
                              ._logItemTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NutritionalPlanTableTableReferences(
                                db,
                                table,
                                p0,
                              ).logItemTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$NutritionalPlanTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftPowersyncDatabase,
      $NutritionalPlanTableTable,
      NutritionalPlanTableData,
      $$NutritionalPlanTableTableFilterComposer,
      $$NutritionalPlanTableTableOrderingComposer,
      $$NutritionalPlanTableTableAnnotationComposer,
      $$NutritionalPlanTableTableCreateCompanionBuilder,
      $$NutritionalPlanTableTableUpdateCompanionBuilder,
      (NutritionalPlanTableData, $$NutritionalPlanTableTableReferences),
      NutritionalPlanTableData,
      PrefetchHooks Function({bool mealTableRefs, bool logItemTableRefs})
    >;
typedef $$IngredientTableTableCreateCompanionBuilder =
    IngredientTableCompanion Function({
      required int id,
      Value<String> uuid,
      required int languageId,
      Value<String?> remoteId,
      Value<String?> sourceName,
      Value<String?> sourceUrl,
      Value<String?> licenseObjectURl,
      Value<String?> code,
      required String name,
      required DateTime created,
      required int energy,
      required double carbohydrates,
      Value<double?> carbohydratesSugar,
      required double protein,
      required double fat,
      Value<double?> fatSaturated,
      Value<double?> fiber,
      Value<double?> sodium,
      Value<bool?> isVegan,
      Value<bool?> isVegetarian,
      Value<NutriScore?> nutriscore,
      Value<int> rowid,
    });
typedef $$IngredientTableTableUpdateCompanionBuilder =
    IngredientTableCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<int> languageId,
      Value<String?> remoteId,
      Value<String?> sourceName,
      Value<String?> sourceUrl,
      Value<String?> licenseObjectURl,
      Value<String?> code,
      Value<String> name,
      Value<DateTime> created,
      Value<int> energy,
      Value<double> carbohydrates,
      Value<double?> carbohydratesSugar,
      Value<double> protein,
      Value<double> fat,
      Value<double?> fatSaturated,
      Value<double?> fiber,
      Value<double?> sodium,
      Value<bool?> isVegan,
      Value<bool?> isVegetarian,
      Value<NutriScore?> nutriscore,
      Value<int> rowid,
    });

final class $$IngredientTableTableReferences
    extends
        BaseReferences<
          _$DriftPowersyncDatabase,
          $IngredientTableTable,
          IngredientTableData
        > {
  $$IngredientTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $IngredientImageTableTable,
    List<IngredientImageTableData>
  >
  _ingredientImageTableRefsTable(_$DriftPowersyncDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.ingredientImageTable,
        aliasName: $_aliasNameGenerator(
          db.ingredientTable.id,
          db.ingredientImageTable.ingredientId,
        ),
      );

  $$IngredientImageTableTableProcessedTableManager
  get ingredientImageTableRefs {
    final manager = $$IngredientImageTableTableTableManager(
      $_db,
      $_db.ingredientImageTable,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _ingredientImageTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $IngredientWeightUnitTableTable,
    List<IngredientWeightUnitTableData>
  >
  _ingredientWeightUnitTableRefsTable(_$DriftPowersyncDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.ingredientWeightUnitTable,
        aliasName: $_aliasNameGenerator(
          db.ingredientTable.id,
          db.ingredientWeightUnitTable.ingredientId,
        ),
      );

  $$IngredientWeightUnitTableTableProcessedTableManager
  get ingredientWeightUnitTableRefs {
    final manager = $$IngredientWeightUnitTableTableTableManager(
      $_db,
      $_db.ingredientWeightUnitTable,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _ingredientWeightUnitTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MealItemTableTable, List<MealItem>>
  _mealItemTableRefsTable(_$DriftPowersyncDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mealItemTable,
        aliasName: $_aliasNameGenerator(
          db.ingredientTable.id,
          db.mealItemTable.ingredientId,
        ),
      );

  $$MealItemTableTableProcessedTableManager get mealItemTableRefs {
    final manager = $$MealItemTableTableTableManager(
      $_db,
      $_db.mealItemTable,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealItemTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LogItemTableTable, List<LogItemTableData>>
  _logItemTableRefsTable(_$DriftPowersyncDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.logItemTable,
        aliasName: $_aliasNameGenerator(
          db.ingredientTable.id,
          db.logItemTable.ingredientId,
        ),
      );

  $$LogItemTableTableProcessedTableManager get logItemTableRefs {
    final manager = $$LogItemTableTableTableManager(
      $_db,
      $_db.logItemTable,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_logItemTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IngredientTableTableFilterComposer
    extends Composer<_$DriftPowersyncDatabase, $IngredientTableTable> {
  $$IngredientTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get languageId => $composableBuilder(
    column: $table.languageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseObjectURl => $composableBuilder(
    column: $table.licenseObjectURl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energy => $composableBuilder(
    column: $table.energy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbohydrates => $composableBuilder(
    column: $table.carbohydrates,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbohydratesSugar => $composableBuilder(
    column: $table.carbohydratesSugar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatSaturated => $composableBuilder(
    column: $table.fatSaturated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiber => $composableBuilder(
    column: $table.fiber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sodium => $composableBuilder(
    column: $table.sodium,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVegan => $composableBuilder(
    column: $table.isVegan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVegetarian => $composableBuilder(
    column: $table.isVegetarian,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<NutriScore?, NutriScore, String>
  get nutriscore => $composableBuilder(
    column: $table.nutriscore,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> ingredientImageTableRefs(
    Expression<bool> Function($$IngredientImageTableTableFilterComposer f) f,
  ) {
    final $$IngredientImageTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ingredientImageTable,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientImageTableTableFilterComposer(
            $db: $db,
            $table: $db.ingredientImageTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ingredientWeightUnitTableRefs(
    Expression<bool> Function($$IngredientWeightUnitTableTableFilterComposer f)
    f,
  ) {
    final $$IngredientWeightUnitTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.ingredientWeightUnitTable,
          getReferencedColumn: (t) => t.ingredientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IngredientWeightUnitTableTableFilterComposer(
                $db: $db,
                $table: $db.ingredientWeightUnitTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> mealItemTableRefs(
    Expression<bool> Function($$MealItemTableTableFilterComposer f) f,
  ) {
    final $$MealItemTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealItemTable,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealItemTableTableFilterComposer(
            $db: $db,
            $table: $db.mealItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> logItemTableRefs(
    Expression<bool> Function($$LogItemTableTableFilterComposer f) f,
  ) {
    final $$LogItemTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logItemTable,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogItemTableTableFilterComposer(
            $db: $db,
            $table: $db.logItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientTableTableOrderingComposer
    extends Composer<_$DriftPowersyncDatabase, $IngredientTableTable> {
  $$IngredientTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get languageId => $composableBuilder(
    column: $table.languageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceUrl => $composableBuilder(
    column: $table.sourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseObjectURl => $composableBuilder(
    column: $table.licenseObjectURl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energy => $composableBuilder(
    column: $table.energy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbohydrates => $composableBuilder(
    column: $table.carbohydrates,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbohydratesSugar => $composableBuilder(
    column: $table.carbohydratesSugar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatSaturated => $composableBuilder(
    column: $table.fatSaturated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiber => $composableBuilder(
    column: $table.fiber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sodium => $composableBuilder(
    column: $table.sodium,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVegan => $composableBuilder(
    column: $table.isVegan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVegetarian => $composableBuilder(
    column: $table.isVegetarian,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nutriscore => $composableBuilder(
    column: $table.nutriscore,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IngredientTableTableAnnotationComposer
    extends Composer<_$DriftPowersyncDatabase, $IngredientTableTable> {
  $$IngredientTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<int> get languageId => $composableBuilder(
    column: $table.languageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceUrl =>
      $composableBuilder(column: $table.sourceUrl, builder: (column) => column);

  GeneratedColumn<String> get licenseObjectURl => $composableBuilder(
    column: $table.licenseObjectURl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<int> get energy =>
      $composableBuilder(column: $table.energy, builder: (column) => column);

  GeneratedColumn<double> get carbohydrates => $composableBuilder(
    column: $table.carbohydrates,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbohydratesSugar => $composableBuilder(
    column: $table.carbohydratesSugar,
    builder: (column) => column,
  );

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<double> get fatSaturated => $composableBuilder(
    column: $table.fatSaturated,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fiber =>
      $composableBuilder(column: $table.fiber, builder: (column) => column);

  GeneratedColumn<double> get sodium =>
      $composableBuilder(column: $table.sodium, builder: (column) => column);

  GeneratedColumn<bool> get isVegan =>
      $composableBuilder(column: $table.isVegan, builder: (column) => column);

  GeneratedColumn<bool> get isVegetarian => $composableBuilder(
    column: $table.isVegetarian,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<NutriScore?, String> get nutriscore =>
      $composableBuilder(
        column: $table.nutriscore,
        builder: (column) => column,
      );

  Expression<T> ingredientImageTableRefs<T extends Object>(
    Expression<T> Function($$IngredientImageTableTableAnnotationComposer a) f,
  ) {
    final $$IngredientImageTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.ingredientImageTable,
          getReferencedColumn: (t) => t.ingredientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IngredientImageTableTableAnnotationComposer(
                $db: $db,
                $table: $db.ingredientImageTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> ingredientWeightUnitTableRefs<T extends Object>(
    Expression<T> Function($$IngredientWeightUnitTableTableAnnotationComposer a)
    f,
  ) {
    final $$IngredientWeightUnitTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.ingredientWeightUnitTable,
          getReferencedColumn: (t) => t.ingredientId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IngredientWeightUnitTableTableAnnotationComposer(
                $db: $db,
                $table: $db.ingredientWeightUnitTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> mealItemTableRefs<T extends Object>(
    Expression<T> Function($$MealItemTableTableAnnotationComposer a) f,
  ) {
    final $$MealItemTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealItemTable,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealItemTableTableAnnotationComposer(
            $db: $db,
            $table: $db.mealItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> logItemTableRefs<T extends Object>(
    Expression<T> Function($$LogItemTableTableAnnotationComposer a) f,
  ) {
    final $$LogItemTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logItemTable,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogItemTableTableAnnotationComposer(
            $db: $db,
            $table: $db.logItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientTableTableTableManager
    extends
        RootTableManager<
          _$DriftPowersyncDatabase,
          $IngredientTableTable,
          IngredientTableData,
          $$IngredientTableTableFilterComposer,
          $$IngredientTableTableOrderingComposer,
          $$IngredientTableTableAnnotationComposer,
          $$IngredientTableTableCreateCompanionBuilder,
          $$IngredientTableTableUpdateCompanionBuilder,
          (IngredientTableData, $$IngredientTableTableReferences),
          IngredientTableData,
          PrefetchHooks Function({
            bool ingredientImageTableRefs,
            bool ingredientWeightUnitTableRefs,
            bool mealItemTableRefs,
            bool logItemTableRefs,
          })
        > {
  $$IngredientTableTableTableManager(
    _$DriftPowersyncDatabase db,
    $IngredientTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngredientTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngredientTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<int> languageId = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> sourceName = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<String?> licenseObjectURl = const Value.absent(),
                Value<String?> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<int> energy = const Value.absent(),
                Value<double> carbohydrates = const Value.absent(),
                Value<double?> carbohydratesSugar = const Value.absent(),
                Value<double> protein = const Value.absent(),
                Value<double> fat = const Value.absent(),
                Value<double?> fatSaturated = const Value.absent(),
                Value<double?> fiber = const Value.absent(),
                Value<double?> sodium = const Value.absent(),
                Value<bool?> isVegan = const Value.absent(),
                Value<bool?> isVegetarian = const Value.absent(),
                Value<NutriScore?> nutriscore = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IngredientTableCompanion(
                id: id,
                uuid: uuid,
                languageId: languageId,
                remoteId: remoteId,
                sourceName: sourceName,
                sourceUrl: sourceUrl,
                licenseObjectURl: licenseObjectURl,
                code: code,
                name: name,
                created: created,
                energy: energy,
                carbohydrates: carbohydrates,
                carbohydratesSugar: carbohydratesSugar,
                protein: protein,
                fat: fat,
                fatSaturated: fatSaturated,
                fiber: fiber,
                sodium: sodium,
                isVegan: isVegan,
                isVegetarian: isVegetarian,
                nutriscore: nutriscore,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                Value<String> uuid = const Value.absent(),
                required int languageId,
                Value<String?> remoteId = const Value.absent(),
                Value<String?> sourceName = const Value.absent(),
                Value<String?> sourceUrl = const Value.absent(),
                Value<String?> licenseObjectURl = const Value.absent(),
                Value<String?> code = const Value.absent(),
                required String name,
                required DateTime created,
                required int energy,
                required double carbohydrates,
                Value<double?> carbohydratesSugar = const Value.absent(),
                required double protein,
                required double fat,
                Value<double?> fatSaturated = const Value.absent(),
                Value<double?> fiber = const Value.absent(),
                Value<double?> sodium = const Value.absent(),
                Value<bool?> isVegan = const Value.absent(),
                Value<bool?> isVegetarian = const Value.absent(),
                Value<NutriScore?> nutriscore = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IngredientTableCompanion.insert(
                id: id,
                uuid: uuid,
                languageId: languageId,
                remoteId: remoteId,
                sourceName: sourceName,
                sourceUrl: sourceUrl,
                licenseObjectURl: licenseObjectURl,
                code: code,
                name: name,
                created: created,
                energy: energy,
                carbohydrates: carbohydrates,
                carbohydratesSugar: carbohydratesSugar,
                protein: protein,
                fat: fat,
                fatSaturated: fatSaturated,
                fiber: fiber,
                sodium: sodium,
                isVegan: isVegan,
                isVegetarian: isVegetarian,
                nutriscore: nutriscore,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IngredientTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ingredientImageTableRefs = false,
                ingredientWeightUnitTableRefs = false,
                mealItemTableRefs = false,
                logItemTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ingredientImageTableRefs) db.ingredientImageTable,
                    if (ingredientWeightUnitTableRefs)
                      db.ingredientWeightUnitTable,
                    if (mealItemTableRefs) db.mealItemTable,
                    if (logItemTableRefs) db.logItemTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ingredientImageTableRefs)
                        await $_getPrefetchedData<
                          IngredientTableData,
                          $IngredientTableTable,
                          IngredientImageTableData
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientTableTableReferences
                              ._ingredientImageTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientTableTableReferences(
                                db,
                                table,
                                p0,
                              ).ingredientImageTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ingredientWeightUnitTableRefs)
                        await $_getPrefetchedData<
                          IngredientTableData,
                          $IngredientTableTable,
                          IngredientWeightUnitTableData
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientTableTableReferences
                              ._ingredientWeightUnitTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientTableTableReferences(
                                db,
                                table,
                                p0,
                              ).ingredientWeightUnitTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mealItemTableRefs)
                        await $_getPrefetchedData<
                          IngredientTableData,
                          $IngredientTableTable,
                          MealItem
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientTableTableReferences
                              ._mealItemTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientTableTableReferences(
                                db,
                                table,
                                p0,
                              ).mealItemTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (logItemTableRefs)
                        await $_getPrefetchedData<
                          IngredientTableData,
                          $IngredientTableTable,
                          LogItemTableData
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientTableTableReferences
                              ._logItemTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientTableTableReferences(
                                db,
                                table,
                                p0,
                              ).logItemTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.ingredientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$IngredientTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftPowersyncDatabase,
      $IngredientTableTable,
      IngredientTableData,
      $$IngredientTableTableFilterComposer,
      $$IngredientTableTableOrderingComposer,
      $$IngredientTableTableAnnotationComposer,
      $$IngredientTableTableCreateCompanionBuilder,
      $$IngredientTableTableUpdateCompanionBuilder,
      (IngredientTableData, $$IngredientTableTableReferences),
      IngredientTableData,
      PrefetchHooks Function({
        bool ingredientImageTableRefs,
        bool ingredientWeightUnitTableRefs,
        bool mealItemTableRefs,
        bool logItemTableRefs,
      })
    >;
typedef $$IngredientImageTableTableCreateCompanionBuilder =
    IngredientImageTableCompanion Function({
      required int id,
      required String uuid,
      required int ingredientId,
      required String image,
      required int size,
      required int width,
      required int height,
      required DateTime created,
      required DateTime lastUpdate,
      required int licenseId,
      Value<String?> author,
      required String authorUrl,
      required String title,
      required String objectUrl,
      required String derivativeSourceUrl,
      Value<int> rowid,
    });
typedef $$IngredientImageTableTableUpdateCompanionBuilder =
    IngredientImageTableCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<int> ingredientId,
      Value<String> image,
      Value<int> size,
      Value<int> width,
      Value<int> height,
      Value<DateTime> created,
      Value<DateTime> lastUpdate,
      Value<int> licenseId,
      Value<String?> author,
      Value<String> authorUrl,
      Value<String> title,
      Value<String> objectUrl,
      Value<String> derivativeSourceUrl,
      Value<int> rowid,
    });

final class $$IngredientImageTableTableReferences
    extends
        BaseReferences<
          _$DriftPowersyncDatabase,
          $IngredientImageTableTable,
          IngredientImageTableData
        > {
  $$IngredientImageTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $IngredientTableTable _ingredientIdTable(
    _$DriftPowersyncDatabase db,
  ) => db.ingredientTable.createAlias(
    $_aliasNameGenerator(
      db.ingredientImageTable.ingredientId,
      db.ingredientTable.id,
    ),
  );

  $$IngredientTableTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientTableTableTableManager(
      $_db,
      $_db.ingredientTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IngredientImageTableTableFilterComposer
    extends Composer<_$DriftPowersyncDatabase, $IngredientImageTableTable> {
  $$IngredientImageTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get licenseId => $composableBuilder(
    column: $table.licenseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorUrl => $composableBuilder(
    column: $table.authorUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objectUrl => $composableBuilder(
    column: $table.objectUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get derivativeSourceUrl => $composableBuilder(
    column: $table.derivativeSourceUrl,
    builder: (column) => ColumnFilters(column),
  );

  $$IngredientTableTableFilterComposer get ingredientId {
    final $$IngredientTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableFilterComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientImageTableTableOrderingComposer
    extends Composer<_$DriftPowersyncDatabase, $IngredientImageTableTable> {
  $$IngredientImageTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get licenseId => $composableBuilder(
    column: $table.licenseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorUrl => $composableBuilder(
    column: $table.authorUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objectUrl => $composableBuilder(
    column: $table.objectUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get derivativeSourceUrl => $composableBuilder(
    column: $table.derivativeSourceUrl,
    builder: (column) => ColumnOrderings(column),
  );

  $$IngredientTableTableOrderingComposer get ingredientId {
    final $$IngredientTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableOrderingComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientImageTableTableAnnotationComposer
    extends Composer<_$DriftPowersyncDatabase, $IngredientImageTableTable> {
  $$IngredientImageTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
    column: $table.lastUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get licenseId =>
      $composableBuilder(column: $table.licenseId, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get authorUrl =>
      $composableBuilder(column: $table.authorUrl, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get objectUrl =>
      $composableBuilder(column: $table.objectUrl, builder: (column) => column);

  GeneratedColumn<String> get derivativeSourceUrl => $composableBuilder(
    column: $table.derivativeSourceUrl,
    builder: (column) => column,
  );

  $$IngredientTableTableAnnotationComposer get ingredientId {
    final $$IngredientTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientImageTableTableTableManager
    extends
        RootTableManager<
          _$DriftPowersyncDatabase,
          $IngredientImageTableTable,
          IngredientImageTableData,
          $$IngredientImageTableTableFilterComposer,
          $$IngredientImageTableTableOrderingComposer,
          $$IngredientImageTableTableAnnotationComposer,
          $$IngredientImageTableTableCreateCompanionBuilder,
          $$IngredientImageTableTableUpdateCompanionBuilder,
          (IngredientImageTableData, $$IngredientImageTableTableReferences),
          IngredientImageTableData,
          PrefetchHooks Function({bool ingredientId})
        > {
  $$IngredientImageTableTableTableManager(
    _$DriftPowersyncDatabase db,
    $IngredientImageTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientImageTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngredientImageTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$IngredientImageTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<int> size = const Value.absent(),
                Value<int> width = const Value.absent(),
                Value<int> height = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<DateTime> lastUpdate = const Value.absent(),
                Value<int> licenseId = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String> authorUrl = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> objectUrl = const Value.absent(),
                Value<String> derivativeSourceUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IngredientImageTableCompanion(
                id: id,
                uuid: uuid,
                ingredientId: ingredientId,
                image: image,
                size: size,
                width: width,
                height: height,
                created: created,
                lastUpdate: lastUpdate,
                licenseId: licenseId,
                author: author,
                authorUrl: authorUrl,
                title: title,
                objectUrl: objectUrl,
                derivativeSourceUrl: derivativeSourceUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required String uuid,
                required int ingredientId,
                required String image,
                required int size,
                required int width,
                required int height,
                required DateTime created,
                required DateTime lastUpdate,
                required int licenseId,
                Value<String?> author = const Value.absent(),
                required String authorUrl,
                required String title,
                required String objectUrl,
                required String derivativeSourceUrl,
                Value<int> rowid = const Value.absent(),
              }) => IngredientImageTableCompanion.insert(
                id: id,
                uuid: uuid,
                ingredientId: ingredientId,
                image: image,
                size: size,
                width: width,
                height: height,
                created: created,
                lastUpdate: lastUpdate,
                licenseId: licenseId,
                author: author,
                authorUrl: authorUrl,
                title: title,
                objectUrl: objectUrl,
                derivativeSourceUrl: derivativeSourceUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IngredientImageTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable:
                                    $$IngredientImageTableTableReferences
                                        ._ingredientIdTable(db),
                                referencedColumn:
                                    $$IngredientImageTableTableReferences
                                        ._ingredientIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IngredientImageTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftPowersyncDatabase,
      $IngredientImageTableTable,
      IngredientImageTableData,
      $$IngredientImageTableTableFilterComposer,
      $$IngredientImageTableTableOrderingComposer,
      $$IngredientImageTableTableAnnotationComposer,
      $$IngredientImageTableTableCreateCompanionBuilder,
      $$IngredientImageTableTableUpdateCompanionBuilder,
      (IngredientImageTableData, $$IngredientImageTableTableReferences),
      IngredientImageTableData,
      PrefetchHooks Function({bool ingredientId})
    >;
typedef $$IngredientWeightUnitTableTableCreateCompanionBuilder =
    IngredientWeightUnitTableCompanion Function({
      required int id,
      required String uuid,
      required int ingredientId,
      required String name,
      Value<int?> gram,
      Value<int> rowid,
    });
typedef $$IngredientWeightUnitTableTableUpdateCompanionBuilder =
    IngredientWeightUnitTableCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<int> ingredientId,
      Value<String> name,
      Value<int?> gram,
      Value<int> rowid,
    });

final class $$IngredientWeightUnitTableTableReferences
    extends
        BaseReferences<
          _$DriftPowersyncDatabase,
          $IngredientWeightUnitTableTable,
          IngredientWeightUnitTableData
        > {
  $$IngredientWeightUnitTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $IngredientTableTable _ingredientIdTable(
    _$DriftPowersyncDatabase db,
  ) => db.ingredientTable.createAlias(
    $_aliasNameGenerator(
      db.ingredientWeightUnitTable.ingredientId,
      db.ingredientTable.id,
    ),
  );

  $$IngredientTableTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientTableTableTableManager(
      $_db,
      $_db.ingredientTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IngredientWeightUnitTableTableFilterComposer
    extends
        Composer<_$DriftPowersyncDatabase, $IngredientWeightUnitTableTable> {
  $$IngredientWeightUnitTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gram => $composableBuilder(
    column: $table.gram,
    builder: (column) => ColumnFilters(column),
  );

  $$IngredientTableTableFilterComposer get ingredientId {
    final $$IngredientTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableFilterComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientWeightUnitTableTableOrderingComposer
    extends
        Composer<_$DriftPowersyncDatabase, $IngredientWeightUnitTableTable> {
  $$IngredientWeightUnitTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gram => $composableBuilder(
    column: $table.gram,
    builder: (column) => ColumnOrderings(column),
  );

  $$IngredientTableTableOrderingComposer get ingredientId {
    final $$IngredientTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableOrderingComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientWeightUnitTableTableAnnotationComposer
    extends
        Composer<_$DriftPowersyncDatabase, $IngredientWeightUnitTableTable> {
  $$IngredientWeightUnitTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get gram =>
      $composableBuilder(column: $table.gram, builder: (column) => column);

  $$IngredientTableTableAnnotationComposer get ingredientId {
    final $$IngredientTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientWeightUnitTableTableTableManager
    extends
        RootTableManager<
          _$DriftPowersyncDatabase,
          $IngredientWeightUnitTableTable,
          IngredientWeightUnitTableData,
          $$IngredientWeightUnitTableTableFilterComposer,
          $$IngredientWeightUnitTableTableOrderingComposer,
          $$IngredientWeightUnitTableTableAnnotationComposer,
          $$IngredientWeightUnitTableTableCreateCompanionBuilder,
          $$IngredientWeightUnitTableTableUpdateCompanionBuilder,
          (
            IngredientWeightUnitTableData,
            $$IngredientWeightUnitTableTableReferences,
          ),
          IngredientWeightUnitTableData,
          PrefetchHooks Function({bool ingredientId})
        > {
  $$IngredientWeightUnitTableTableTableManager(
    _$DriftPowersyncDatabase db,
    $IngredientWeightUnitTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientWeightUnitTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$IngredientWeightUnitTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$IngredientWeightUnitTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> gram = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IngredientWeightUnitTableCompanion(
                id: id,
                uuid: uuid,
                ingredientId: ingredientId,
                name: name,
                gram: gram,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required String uuid,
                required int ingredientId,
                required String name,
                Value<int?> gram = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IngredientWeightUnitTableCompanion.insert(
                id: id,
                uuid: uuid,
                ingredientId: ingredientId,
                name: name,
                gram: gram,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IngredientWeightUnitTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable:
                                    $$IngredientWeightUnitTableTableReferences
                                        ._ingredientIdTable(db),
                                referencedColumn:
                                    $$IngredientWeightUnitTableTableReferences
                                        ._ingredientIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IngredientWeightUnitTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftPowersyncDatabase,
      $IngredientWeightUnitTableTable,
      IngredientWeightUnitTableData,
      $$IngredientWeightUnitTableTableFilterComposer,
      $$IngredientWeightUnitTableTableOrderingComposer,
      $$IngredientWeightUnitTableTableAnnotationComposer,
      $$IngredientWeightUnitTableTableCreateCompanionBuilder,
      $$IngredientWeightUnitTableTableUpdateCompanionBuilder,
      (
        IngredientWeightUnitTableData,
        $$IngredientWeightUnitTableTableReferences,
      ),
      IngredientWeightUnitTableData,
      PrefetchHooks Function({bool ingredientId})
    >;
typedef $$MealTableTableCreateCompanionBuilder =
    MealTableCompanion Function({
      Value<String> id,
      required String planId,
      Value<int> order,
      Value<TimeOfDay?> time,
      Value<String> name,
      Value<int> rowid,
    });
typedef $$MealTableTableUpdateCompanionBuilder =
    MealTableCompanion Function({
      Value<String> id,
      Value<String> planId,
      Value<int> order,
      Value<TimeOfDay?> time,
      Value<String> name,
      Value<int> rowid,
    });

final class $$MealTableTableReferences
    extends
        BaseReferences<
          _$DriftPowersyncDatabase,
          $MealTableTable,
          mealdomain.Meal
        > {
  $$MealTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NutritionalPlanTableTable _planIdTable(_$DriftPowersyncDatabase db) =>
      db.nutritionalPlanTable.createAlias(
        $_aliasNameGenerator(db.mealTable.planId, db.nutritionalPlanTable.id),
      );

  $$NutritionalPlanTableTableProcessedTableManager get planId {
    final $_column = $_itemColumn<String>('plan_id')!;

    final manager = $$NutritionalPlanTableTableTableManager(
      $_db,
      $_db.nutritionalPlanTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MealItemTableTable, List<MealItem>>
  _mealItemTableRefsTable(_$DriftPowersyncDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mealItemTable,
        aliasName: $_aliasNameGenerator(
          db.mealTable.id,
          db.mealItemTable.mealId,
        ),
      );

  $$MealItemTableTableProcessedTableManager get mealItemTableRefs {
    final manager = $$MealItemTableTableTableManager(
      $_db,
      $_db.mealItemTable,
    ).filter((f) => f.mealId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mealItemTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MealTableTableFilterComposer
    extends Composer<_$DriftPowersyncDatabase, $MealTableTable> {
  $$MealTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TimeOfDay?, TimeOfDay, String> get time =>
      $composableBuilder(
        column: $table.time,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$NutritionalPlanTableTableFilterComposer get planId {
    final $$NutritionalPlanTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.nutritionalPlanTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutritionalPlanTableTableFilterComposer(
            $db: $db,
            $table: $db.nutritionalPlanTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> mealItemTableRefs(
    Expression<bool> Function($$MealItemTableTableFilterComposer f) f,
  ) {
    final $$MealItemTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealItemTable,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealItemTableTableFilterComposer(
            $db: $db,
            $table: $db.mealItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealTableTableOrderingComposer
    extends Composer<_$DriftPowersyncDatabase, $MealTableTable> {
  $$MealTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$NutritionalPlanTableTableOrderingComposer get planId {
    final $$NutritionalPlanTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.planId,
          referencedTable: $db.nutritionalPlanTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NutritionalPlanTableTableOrderingComposer(
                $db: $db,
                $table: $db.nutritionalPlanTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MealTableTableAnnotationComposer
    extends Composer<_$DriftPowersyncDatabase, $MealTableTable> {
  $$MealTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TimeOfDay?, String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$NutritionalPlanTableTableAnnotationComposer get planId {
    final $$NutritionalPlanTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.planId,
          referencedTable: $db.nutritionalPlanTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NutritionalPlanTableTableAnnotationComposer(
                $db: $db,
                $table: $db.nutritionalPlanTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> mealItemTableRefs<T extends Object>(
    Expression<T> Function($$MealItemTableTableAnnotationComposer a) f,
  ) {
    final $$MealItemTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mealItemTable,
      getReferencedColumn: (t) => t.mealId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealItemTableTableAnnotationComposer(
            $db: $db,
            $table: $db.mealItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MealTableTableTableManager
    extends
        RootTableManager<
          _$DriftPowersyncDatabase,
          $MealTableTable,
          mealdomain.Meal,
          $$MealTableTableFilterComposer,
          $$MealTableTableOrderingComposer,
          $$MealTableTableAnnotationComposer,
          $$MealTableTableCreateCompanionBuilder,
          $$MealTableTableUpdateCompanionBuilder,
          (mealdomain.Meal, $$MealTableTableReferences),
          mealdomain.Meal,
          PrefetchHooks Function({bool planId, bool mealItemTableRefs})
        > {
  $$MealTableTableTableManager(
    _$DriftPowersyncDatabase db,
    $MealTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<TimeOfDay?> time = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealTableCompanion(
                id: id,
                planId: planId,
                order: order,
                time: time,
                name: name,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String planId,
                Value<int> order = const Value.absent(),
                Value<TimeOfDay?> time = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealTableCompanion.insert(
                id: id,
                planId: planId,
                order: order,
                time: time,
                name: name,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MealTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false, mealItemTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (mealItemTableRefs) db.mealItemTable,
              ],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable: $$MealTableTableReferences
                                    ._planIdTable(db),
                                referencedColumn: $$MealTableTableReferences
                                    ._planIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mealItemTableRefs)
                    await $_getPrefetchedData<
                      mealdomain.Meal,
                      $MealTableTable,
                      MealItem
                    >(
                      currentTable: table,
                      referencedTable: $$MealTableTableReferences
                          ._mealItemTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MealTableTableReferences(
                            db,
                            table,
                            p0,
                          ).mealItemTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.mealId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MealTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftPowersyncDatabase,
      $MealTableTable,
      mealdomain.Meal,
      $$MealTableTableFilterComposer,
      $$MealTableTableOrderingComposer,
      $$MealTableTableAnnotationComposer,
      $$MealTableTableCreateCompanionBuilder,
      $$MealTableTableUpdateCompanionBuilder,
      (mealdomain.Meal, $$MealTableTableReferences),
      mealdomain.Meal,
      PrefetchHooks Function({bool planId, bool mealItemTableRefs})
    >;
typedef $$MealItemTableTableCreateCompanionBuilder =
    MealItemTableCompanion Function({
      Value<String> id,
      required String mealId,
      required int ingredientId,
      Value<int?> weightUnitId,
      Value<int> order,
      required double amount,
      Value<int> rowid,
    });
typedef $$MealItemTableTableUpdateCompanionBuilder =
    MealItemTableCompanion Function({
      Value<String> id,
      Value<String> mealId,
      Value<int> ingredientId,
      Value<int?> weightUnitId,
      Value<int> order,
      Value<double> amount,
      Value<int> rowid,
    });

final class $$MealItemTableTableReferences
    extends
        BaseReferences<
          _$DriftPowersyncDatabase,
          $MealItemTableTable,
          MealItem
        > {
  $$MealItemTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MealTableTable _mealIdTable(_$DriftPowersyncDatabase db) =>
      db.mealTable.createAlias(
        $_aliasNameGenerator(db.mealItemTable.mealId, db.mealTable.id),
      );

  $$MealTableTableProcessedTableManager get mealId {
    final $_column = $_itemColumn<String>('meal_id')!;

    final manager = $$MealTableTableTableManager(
      $_db,
      $_db.mealTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientTableTable _ingredientIdTable(
    _$DriftPowersyncDatabase db,
  ) => db.ingredientTable.createAlias(
    $_aliasNameGenerator(db.mealItemTable.ingredientId, db.ingredientTable.id),
  );

  $$IngredientTableTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientTableTableTableManager(
      $_db,
      $_db.ingredientTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MealItemTableTableFilterComposer
    extends Composer<_$DriftPowersyncDatabase, $MealItemTableTable> {
  $$MealItemTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weightUnitId => $composableBuilder(
    column: $table.weightUnitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  $$MealTableTableFilterComposer get mealId {
    final $$MealTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.mealTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTableTableFilterComposer(
            $db: $db,
            $table: $db.mealTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientTableTableFilterComposer get ingredientId {
    final $$IngredientTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableFilterComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealItemTableTableOrderingComposer
    extends Composer<_$DriftPowersyncDatabase, $MealItemTableTable> {
  $$MealItemTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weightUnitId => $composableBuilder(
    column: $table.weightUnitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  $$MealTableTableOrderingComposer get mealId {
    final $$MealTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.mealTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTableTableOrderingComposer(
            $db: $db,
            $table: $db.mealTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientTableTableOrderingComposer get ingredientId {
    final $$IngredientTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableOrderingComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealItemTableTableAnnotationComposer
    extends Composer<_$DriftPowersyncDatabase, $MealItemTableTable> {
  $$MealItemTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weightUnitId => $composableBuilder(
    column: $table.weightUnitId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$MealTableTableAnnotationComposer get mealId {
    final $$MealTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mealId,
      referencedTable: $db.mealTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MealTableTableAnnotationComposer(
            $db: $db,
            $table: $db.mealTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientTableTableAnnotationComposer get ingredientId {
    final $$IngredientTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MealItemTableTableTableManager
    extends
        RootTableManager<
          _$DriftPowersyncDatabase,
          $MealItemTableTable,
          MealItem,
          $$MealItemTableTableFilterComposer,
          $$MealItemTableTableOrderingComposer,
          $$MealItemTableTableAnnotationComposer,
          $$MealItemTableTableCreateCompanionBuilder,
          $$MealItemTableTableUpdateCompanionBuilder,
          (MealItem, $$MealItemTableTableReferences),
          MealItem,
          PrefetchHooks Function({bool mealId, bool ingredientId})
        > {
  $$MealItemTableTableTableManager(
    _$DriftPowersyncDatabase db,
    $MealItemTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealItemTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealItemTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealItemTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mealId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<int?> weightUnitId = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MealItemTableCompanion(
                id: id,
                mealId: mealId,
                ingredientId: ingredientId,
                weightUnitId: weightUnitId,
                order: order,
                amount: amount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String mealId,
                required int ingredientId,
                Value<int?> weightUnitId = const Value.absent(),
                Value<int> order = const Value.absent(),
                required double amount,
                Value<int> rowid = const Value.absent(),
              }) => MealItemTableCompanion.insert(
                id: id,
                mealId: mealId,
                ingredientId: ingredientId,
                weightUnitId: weightUnitId,
                order: order,
                amount: amount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MealItemTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mealId = false, ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mealId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.mealId,
                                referencedTable: $$MealItemTableTableReferences
                                    ._mealIdTable(db),
                                referencedColumn: $$MealItemTableTableReferences
                                    ._mealIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable: $$MealItemTableTableReferences
                                    ._ingredientIdTable(db),
                                referencedColumn: $$MealItemTableTableReferences
                                    ._ingredientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MealItemTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftPowersyncDatabase,
      $MealItemTableTable,
      MealItem,
      $$MealItemTableTableFilterComposer,
      $$MealItemTableTableOrderingComposer,
      $$MealItemTableTableAnnotationComposer,
      $$MealItemTableTableCreateCompanionBuilder,
      $$MealItemTableTableUpdateCompanionBuilder,
      (MealItem, $$MealItemTableTableReferences),
      MealItem,
      PrefetchHooks Function({bool mealId, bool ingredientId})
    >;
typedef $$LogItemTableTableCreateCompanionBuilder =
    LogItemTableCompanion Function({
      Value<String> id,
      required String planId,
      Value<String?> mealId,
      required int ingredientId,
      Value<int?> weightUnitId,
      required DateTime datetime,
      required double amount,
      Value<String?> comment,
      Value<int> rowid,
    });
typedef $$LogItemTableTableUpdateCompanionBuilder =
    LogItemTableCompanion Function({
      Value<String> id,
      Value<String> planId,
      Value<String?> mealId,
      Value<int> ingredientId,
      Value<int?> weightUnitId,
      Value<DateTime> datetime,
      Value<double> amount,
      Value<String?> comment,
      Value<int> rowid,
    });

final class $$LogItemTableTableReferences
    extends
        BaseReferences<
          _$DriftPowersyncDatabase,
          $LogItemTableTable,
          LogItemTableData
        > {
  $$LogItemTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NutritionalPlanTableTable _planIdTable(_$DriftPowersyncDatabase db) =>
      db.nutritionalPlanTable.createAlias(
        $_aliasNameGenerator(
          db.logItemTable.planId,
          db.nutritionalPlanTable.id,
        ),
      );

  $$NutritionalPlanTableTableProcessedTableManager get planId {
    final $_column = $_itemColumn<String>('plan_id')!;

    final manager = $$NutritionalPlanTableTableTableManager(
      $_db,
      $_db.nutritionalPlanTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientTableTable _ingredientIdTable(
    _$DriftPowersyncDatabase db,
  ) => db.ingredientTable.createAlias(
    $_aliasNameGenerator(db.logItemTable.ingredientId, db.ingredientTable.id),
  );

  $$IngredientTableTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientTableTableTableManager(
      $_db,
      $_db.ingredientTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LogItemTableTableFilterComposer
    extends Composer<_$DriftPowersyncDatabase, $LogItemTableTable> {
  $$LogItemTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealId => $composableBuilder(
    column: $table.mealId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weightUnitId => $composableBuilder(
    column: $table.weightUnitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get datetime => $composableBuilder(
    column: $table.datetime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  $$NutritionalPlanTableTableFilterComposer get planId {
    final $$NutritionalPlanTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.nutritionalPlanTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NutritionalPlanTableTableFilterComposer(
            $db: $db,
            $table: $db.nutritionalPlanTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientTableTableFilterComposer get ingredientId {
    final $$IngredientTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableFilterComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogItemTableTableOrderingComposer
    extends Composer<_$DriftPowersyncDatabase, $LogItemTableTable> {
  $$LogItemTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealId => $composableBuilder(
    column: $table.mealId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weightUnitId => $composableBuilder(
    column: $table.weightUnitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get datetime => $composableBuilder(
    column: $table.datetime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  $$NutritionalPlanTableTableOrderingComposer get planId {
    final $$NutritionalPlanTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.planId,
          referencedTable: $db.nutritionalPlanTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NutritionalPlanTableTableOrderingComposer(
                $db: $db,
                $table: $db.nutritionalPlanTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$IngredientTableTableOrderingComposer get ingredientId {
    final $$IngredientTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableOrderingComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogItemTableTableAnnotationComposer
    extends Composer<_$DriftPowersyncDatabase, $LogItemTableTable> {
  $$LogItemTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mealId =>
      $composableBuilder(column: $table.mealId, builder: (column) => column);

  GeneratedColumn<int> get weightUnitId => $composableBuilder(
    column: $table.weightUnitId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get datetime =>
      $composableBuilder(column: $table.datetime, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  $$NutritionalPlanTableTableAnnotationComposer get planId {
    final $$NutritionalPlanTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.planId,
          referencedTable: $db.nutritionalPlanTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NutritionalPlanTableTableAnnotationComposer(
                $db: $db,
                $table: $db.nutritionalPlanTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$IngredientTableTableAnnotationComposer get ingredientId {
    final $$IngredientTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredientTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientTableTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredientTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogItemTableTableTableManager
    extends
        RootTableManager<
          _$DriftPowersyncDatabase,
          $LogItemTableTable,
          LogItemTableData,
          $$LogItemTableTableFilterComposer,
          $$LogItemTableTableOrderingComposer,
          $$LogItemTableTableAnnotationComposer,
          $$LogItemTableTableCreateCompanionBuilder,
          $$LogItemTableTableUpdateCompanionBuilder,
          (LogItemTableData, $$LogItemTableTableReferences),
          LogItemTableData,
          PrefetchHooks Function({bool planId, bool ingredientId})
        > {
  $$LogItemTableTableTableManager(
    _$DriftPowersyncDatabase db,
    $LogItemTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogItemTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogItemTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogItemTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<String?> mealId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<int?> weightUnitId = const Value.absent(),
                Value<DateTime> datetime = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LogItemTableCompanion(
                id: id,
                planId: planId,
                mealId: mealId,
                ingredientId: ingredientId,
                weightUnitId: weightUnitId,
                datetime: datetime,
                amount: amount,
                comment: comment,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String planId,
                Value<String?> mealId = const Value.absent(),
                required int ingredientId,
                Value<int?> weightUnitId = const Value.absent(),
                required DateTime datetime,
                required double amount,
                Value<String?> comment = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LogItemTableCompanion.insert(
                id: id,
                planId: planId,
                mealId: mealId,
                ingredientId: ingredientId,
                weightUnitId: weightUnitId,
                datetime: datetime,
                amount: amount,
                comment: comment,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LogItemTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false, ingredientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable: $$LogItemTableTableReferences
                                    ._planIdTable(db),
                                referencedColumn: $$LogItemTableTableReferences
                                    ._planIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable: $$LogItemTableTableReferences
                                    ._ingredientIdTable(db),
                                referencedColumn: $$LogItemTableTableReferences
                                    ._ingredientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LogItemTableTableProcessedTableManager =
    ProcessedTableManager<
      _$DriftPowersyncDatabase,
      $LogItemTableTable,
      LogItemTableData,
      $$LogItemTableTableFilterComposer,
      $$LogItemTableTableOrderingComposer,
      $$LogItemTableTableAnnotationComposer,
      $$LogItemTableTableCreateCompanionBuilder,
      $$LogItemTableTableUpdateCompanionBuilder,
      (LogItemTableData, $$LogItemTableTableReferences),
      LogItemTableData,
      PrefetchHooks Function({bool planId, bool ingredientId})
    >;

class $DriftPowersyncDatabaseManager {
  final _$DriftPowersyncDatabase _db;
  $DriftPowersyncDatabaseManager(this._db);
  $$NutritionalPlanTableTableTableManager get nutritionalPlanTable =>
      $$NutritionalPlanTableTableTableManager(_db, _db.nutritionalPlanTable);
  $$IngredientTableTableTableManager get ingredientTable =>
      $$IngredientTableTableTableManager(_db, _db.ingredientTable);
  $$IngredientImageTableTableTableManager get ingredientImageTable =>
      $$IngredientImageTableTableTableManager(_db, _db.ingredientImageTable);
  $$IngredientWeightUnitTableTableTableManager get ingredientWeightUnitTable =>
      $$IngredientWeightUnitTableTableTableManager(
        _db,
        _db.ingredientWeightUnitTable,
      );
  $$MealTableTableTableManager get mealTable =>
      $$MealTableTableTableManager(_db, _db.mealTable);
  $$MealItemTableTableTableManager get mealItemTable =>
      $$MealItemTableTableTableManager(_db, _db.mealItemTable);
  $$LogItemTableTableTableManager get logItemTable =>
      $$LogItemTableTableTableManager(_db, _db.logItemTable);
}
