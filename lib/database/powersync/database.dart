import 'package:drift/drift.dart';
import 'package:drift_sqlite_async/drift_sqlite_async.dart';
import 'package:flutter/material.dart' hide Table;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:powersync/powersync.dart' as ps;

import 'package:realflutter/database/converters/time_of_day_converter.dart';
import 'package:realflutter/database/powersync/powersync.dart';
import 'package:realflutter/database/powersync/tables/ingredient.dart';
import 'package:realflutter/database/powersync/tables/nutrition.dart';

import 'package:realflutter/models/nutrition/ingredient.dart';
import 'package:realflutter/models/nutrition/log.dart';
import 'package:realflutter/models/nutrition/meal.dart' as mealdomain;
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    NutritionalPlanTable,
    IngredientTable,
    IngredientImageTable,
    IngredientWeightUnitTable,
    MealTable,
    MealItemTable,
    LogItemTable,
  ],
)
class DriftPowersyncDatabase extends _$DriftPowersyncDatabase {
  DriftPowersyncDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {},
      onUpgrade: (m, from, to) async {
        if (from == 1) {}
      },
    );
  }

  /// Fetches a highly structured nutritional plan directly from local SQL storage.
  /// Resolves relations sequentially to populate nested child lists safely.
  Future<NutritionalPlan> getFullPlanOffline(String planId) async {
    final planRow = await (select(nutritionalPlanTable)
          ..where((t) => t.id.equals(planId)))
        .getSingle();

    final mealRows = await (select(mealTable)
          ..where((t) => t.planId.equals(planId))
          ..orderBy([(t) => OrderingTerm.asc(t.order)]))
        .get();

    final List<mealdomain.Meal> domainMeals = [];

    for (final mealRow in mealRows) {
      final itemRows = await (select(mealItemTable)
            ..where((t) => t.mealId.equals(mealRow.id))
            ..orderBy([(t) => OrderingTerm.asc(t.order)]))
          .get();

      final List<MealItem> domainItems = itemRows.map((r) {
        return MealItem(
          id: r.id,
          mealId: r.mealId,
          ingredientId: r.ingredientId,
          weightUnitId: r.weightUnitId,
          amount: r.amount,
          order: r.order,
        );
      }).toList();

      final parsedMeal = mealdomain.Meal(
        id: mealRow.id,
        planId: mealRow.planId,
        name: mealRow.name,
        time: mealRow.time, 
        order: mealRow.order,
        mealItems: domainItems,
      );

      domainMeals.add(parsedMeal);
    }

    return NutritionalPlan(
      id: planRow.id,
      description: planRow.description,
      goalEnergy: planRow.goalEnergy?.toDouble(),
      goalProtein: planRow.goalProtein?.toDouble(),
      goalCarbohydrates: planRow.goalCarbohydrates?.toDouble(),
      goalFat: planRow.goalFat?.toDouble(),
      creationDate: planRow.creationDate.toIso8601String(),
      endDate: planRow.endDate?.toIso8601String(),
      meals: domainMeals,
      diaryEntries: const [],
    );
  }

  Future<void> insertLogOffline(LogItem log) async {
    await into(logItemTable).insert(
      LogItemTableCompanion.insert(
        id: log.id.isNotEmpty ? Value(log.id) : const Value.absent(),
        planId: log.planId,
        ingredientId: log.ingredientId,
        amount: log.amount,
        datetime: log.datetime,
        weightUnitId: Value(log.weightUnitId),
        mealId: Value(log.mealId),
      ),
    );
  }
}

final driftPowerSyncDatabase = Provider((ref) {
  return DriftPowersyncDatabase(
    DatabaseConnection.delayed(
      Future(() async {
        final database = await ref.read(powerSyncInstanceProvider.future);
        return SqliteAsyncDriftConnection(database);
      }),
    ),
  );
});