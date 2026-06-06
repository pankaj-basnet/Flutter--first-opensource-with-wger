import 'package:drift/drift.dart';
import 'package:drift_sqlite_async/drift_sqlite_async.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:powersync/powersync.dart' as ps;

import 'package:realflutter/database/converters/time_of_day_converter.dart';
import 'package:realflutter/database/powersync/powersync.dart';
import 'package:realflutter/database/powersync/tables/ingredient.dart';
import 'package:realflutter/database/powersync/tables/nutrition.dart';

import 'package:realflutter/models/nutrition/ingredient.dart';
import 'package:realflutter/models/nutrition/log.dart';
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

  // ➕ ADD: Offline Data Access Objects (DAOs) below

  /// Fetches a fully populated NutritionalPlan from local SQLite
  /// Fetches a fully populated NutritionalPlan from local SQLite
  Future<NutritionalPlan?> getFullPlanOffline(String planId) async {
    // 1. Fetch raw plan data from the NutritionalPlanTable
    final planRow = await (select(nutritionalPlanTable)
          ..where((t) => t.id.equals(planId)))
        .getSingleOrNull();

    if (planRow == null) return null;

    // 2. Fetch associated meals
    // Drift returns a list of database-layer Meal objects
    final driftMeals = await (select(mealTable)
          ..where((t) => t.planId.equals(planId)))
        .get();

    // 3. Map the Drift database models to your domain models
    // We assume your domain 'Meal' class has a constructor 
    // or a way to be initialized from the database row data.
    final List<Meal> domainMeals = driftMeals.map((row) {
      return Meal(
        id: row.id,
        planId: row.planId,
        name: row.name,
        time: row.time,
        // You would perform a nested query here to fetch 
        // MealItems for each meal if needed.
        // mealItems: const [], 
        order: row.order
      );
    }).toList();

    // 4. Return the domain NutritionalPlan
    return NutritionalPlan(
      id: planRow.id,
      description: planRow.description,
      // Pass the converted domain list
      // meals: planRow.,
      diaryEntries: [], 
    );
  }

  /// Converts and inserts a LogItem Domain Model into the local SQLite table
  Future<void> insertLogOffline(LogItem log) async {
    await into(logItemTable).insert(
      LogItemTableCompanion.insert(
        id: log.id.isNotEmpty ? Value(log.id) : const Value.absent(),
        planId: log.planId,
        ingredientId: log.ingredientId,
        amount: log.amount,
        datetime: log.datetime,
        // weightUnitId and mealId handle nullability automatically
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
