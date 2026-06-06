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
import 'package:realflutter/models/nutrition/meal.dart';
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    // Nutrition
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

  // ────────────────────────────────────────────────────────────────────────
  // Offline DAOs
  // ────────────────────────────────────────────────────────────────────────

  /// Fetches a fully populated NutritionalPlan (with meals and meal items)
  /// from local SQLite when the app is offline.
  ///
  /// FIX: previous version left `meals` always empty ([]) and returned
  /// NutritionalPlan without the meals field set. This version performs the
  /// nested queries and returns a properly populated domain object.
  Future<NutritionalPlan?> getFullPlanOffline(String planId) async {
    // 1. Fetch the plan row.
    final planRow = await (select(
      nutritionalPlanTable,
    )..where((t) => t.id.equals(planId))).getSingleOrNull();

    if (planRow == null) return null;

    // 2. Fetch associated meal rows.
    final mealRows = await (select(
      mealTable,
    )..where((t) => t.planId.equals(planId))).get();

    // 3. For each meal, fetch its MealItem rows.
    final List<Meal> meals = [];
    for (final mealRow in mealRows) {
      final itemRows =
          await (select(mealItemTable)
                ..where((t) => t.mealId.equals(mealRow.id))
                ..orderBy([(t) => OrderingTerm.asc(t.order)]))
              .get();

      final items = itemRows
          .map(
            (r) => MealItem(
              id: r.id,
              mealId: r.mealId,
              ingredientId: r.ingredientId,
              weightUnitId: r.weightUnitId,
              amount: r.amount,
              order: r.order,
            ),
          )
          .toList();

      // MealTable uses @UseRowClass(Meal, constructor: 'fromDrift') so
      // mealRow IS already a Meal; we just need to attach the items.
      // meals.add(
      //   Meal(
      //     id: mealRow.id,
      //     planId: mealRow.planId,
      //     name: mealRow.name,
      //     time: mealRow.time,
      //     // mealItems: items,
      //     order: mealRow.order,
      //   ),
      // );

      meals.add(mealRow.copyWith(mealItems: items));
    }

    // 4. Build and return the fully-populated domain plan.
    // return NutritionalPlan(
    //   id: planRow.id,
    //   description: planRow.description,
    //   goalEnergy: planRow.goalEnergy?.toDouble(),
    //   goalProtein: planRow.goalProtein?.toDouble(),
    //   goalCarbohydrates: planRow.goalCarbohydrates?.toDouble(),
    //   goalFat: planRow.goalFat?.toDouble(),
    //   // creationDate is a DateTimeColumn — stored as DateTime, not String.
    //   creationDate: planRow.creationDate.toString(),
    //   endDate: planRow.endDate.toString(),
    //   // meals: meals.map((meal) => Meal)
    //   meals: meals.map((meal)=> mealdomain.Meal(id: '111', planId: '1111')).toList(),
    //   // MealItem.fromDrift(id: meal, mealId: mealId, ingredientId: ingredientId, amount: amount),
    //   diaryEntries: const [],
    // );

    return NutritionalPlan(
      id: planRow.id,
      description: planRow.description,
      goalEnergy: planRow.goalEnergy?.toDouble(),
      goalProtein: planRow.goalProtein?.toDouble(),
      goalCarbohydrates: planRow.goalCarbohydrates?.toDouble(),
      goalFat: planRow.goalFat?.toDouble(),
      creationDate: planRow.creationDate.toIso8601String(),
      endDate: planRow.endDate?.toIso8601String(),
      meals: meals,
      diaryEntries: const [],
    );
  }

  /// Converts and inserts a [LogItem] domain model into the local SQLite table.
  ///
  /// Drift-generated LogItemTableCompanion (matches the LogItemTable class name).
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
