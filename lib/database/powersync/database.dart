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
import 'package:realflutter/models/nutrition/ingredient_image.dart';
import 'package:realflutter/models/nutrition/log.dart';
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
