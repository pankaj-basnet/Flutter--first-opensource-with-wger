// lib/database/nutrition_repository.dart

import 'package:drift/drift.dart';
import 'package:realflutter/database/powersync/database.dart';
import 'package:uuid/uuid.dart';
// import 'nutrition_database.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';
import 'package:realflutter/models/nutrition/meal.dart';
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/models/nutrition/log.dart';

const _uuid = Uuid();

class NutritionRepository {
  final DriftPowersyncDatabase  _db;
  NutritionRepository(this._db);

  // ── NutritionalPlan ───────────────────────────────────────────────────────

  /// Stream of all plans — UI rebuilds automatically on any change.
  Stream<List<NutritionalPlan>> watchAllPlans() {
    return (_db.select(_db.nutritionalPlanTable)
          ..orderBy([(t) => OrderingTerm.desc(t.creationDate)]))
        .watch()
        .map((rows) => rows.map(_planFromRow).toList());
  }

  /// Stream of one plan with all its meals + items.
  Stream<NutritionalPlan?> watchPlan(String planId) {
    return (_db.select(_db.nutritionalPlanTable)
          ..where((t) => t.id.equals(planId)))
        .watchSingleOrNull()
        .asyncMap((row) async {
      if (row == null) return null;
      final meals = await _mealsForPlan(planId);
      return _planFromRow(row).copyWith(meals: meals);
    });
  }

  Future<void> insertPlan(NutritionalPlan plan) async {
    await _db.into(_db.nutritionalPlanTable).insertOnConflictUpdate(
          NunutritionalPlanTableCompanion(
            id: Value(plan.id.isEmpty ? _uuid.v4() : plan.id),
            description: Value(plan.description),
            goalEnergy: Value(plan.goalEnergy),
            goalProtein: Value(plan.goalProtein),
            goalCarbohydrates: Value(plan.goalCarbohydrates),
            goalFat: Value(plan.goalFat),
            creationDate: Value(plan.creationDate),
            endDate: Value(plan.endDate),
          ),
        );
  }

  Future<void> updatePlan(NutritionalPlan plan) async {
    await (_db.update(_db.nutritionalPlanTable)
          ..where((t) => t.id.equals(plan.id)))
        .write(
      NunutritionalPlanTableCompanion(
        description: Value(plan.description),
        goalEnergy: Value(plan.goalEnergy),
        goalProtein: Value(plan.goalProtein),
        goalCarbohydrates: Value(plan.goalCarbohydrates),
        goalFat: Value(plan.goalFat),
        endDate: Value(plan.endDate),
      ),
    );
  }

  Future<void> deletePlan(String planId) async {
    await (_db.delete(_db.nutritionalPlanTable)
          ..where((t) => t.id.equals(planId)))
        .go();
  }

  // ── Meal ──────────────────────────────────────────────────────────────────

  Stream<List<Meal>> watchMealsForPlan(String planId) {
    return (_db.select(_db.mealsTable)
          ..where((t) => t.planId.equals(planId)))
        .watch()
        .asyncMap((rows) async {
      final result = <Meal>[];
      for (final row in rows) {
        final items = await _itemsForMeal(row.id);
        result.add(_mealFromRow(row, items));
      }
      return result;
    });
  }

  Future<void> insertMeal(Meal meal) async {
    await _db.into(_db.mealsTable).insertOnConflictUpdate(
          MealsTableCompanion(
            id: Value(meal.id.isEmpty ? _uuid.v4() : meal.id),
            planId: Value(meal.planId),
            name: Value(meal.name),
            time: Value(meal.time),
          ),
        );
  }

  Future<void> updateMeal(Meal meal) async {
    await (_db.update(_db.mealsTable)..where((t) => t.id.equals(meal.id)))
        .write(
      MealsTableCompanion(
        name: Value(meal.name),
        time: Value(meal.time),
      ),
    );
  }

  Future<void> deleteMeal(String mealId) async {
    // Cascade: delete items first
    await (_db.delete(_db.mealItemsTable)
          ..where((t) => t.mealId.equals(mealId)))
        .go();
    await (_db.delete(_db.mealsTable)..where((t) => t.id.equals(mealId))).go();
  }

  // ── MealItem ──────────────────────────────────────────────────────────────

  Future<void> insertMealItem(MealItem item) async {
    await _db.into(_db.mealItemsTable).insertOnConflictUpdate(
          MealItemsTableCompanion(
            id: Value(item.id.isEmpty ? _uuid.v4() : item.id),
            mealId: Value(item.mealId),
            ingredientId: Value(item.ingredientId),
            weightUnitId: Value(item.weightUnitId),
            amount: Value(item.amount),
            order: Value(item.order),
          ),
        );
  }

  Future<void> deleteMealItem(String itemId) async {
    await (_db.delete(_db.mealItemsTable)..where((t) => t.id.equals(itemId)))
        .go();
  }

  // ── LogItem ───────────────────────────────────────────────────────────────

  Stream<List<LogItem>> watchLogsForPlan(String planId) {
    return (_db.select(_db.logItemsTable)
          ..where((t) => t.planId.equals(planId))
          ..orderBy([(t) => OrderingTerm.desc(t.datetime)]))
        .watch()
        .map((rows) => rows.map(_logFromRow).toList());
  }

  Future<void> insertLog(LogItem log) async {
    await _db.into(_db.logItemsTable).insertOnConflictUpdate(
          LogItemsTableCompanion(
            id: Value(log.id.isEmpty ? _uuid.v4() : log.id),
            planId: Value(log.planId),
            mealId: Value(log.mealId),
            ingredientId: Value(log.ingredientId),
            weightUnitId: Value(log.weightUnitId),
            datetime: Value(log.datetime),
            amount: Value(log.amount),
          ),
        );
  }

  // ── Private mappers ───────────────────────────────────────────────────────

  NutritionalPlan _planFromRow(NunutritionalPlanTableData row) =>
      NutritionalPlan(
        id: row.id,
        description: row.description,
        goalEnergy: row.goalEnergy,
        goalProtein: row.goalProtein,
        goalCarbohydrates: row.goalCarbohydrates,
        goalFat: row.goalFat,
        creationDate: row.creationDate,
        endDate: row.endDate,
      );

  Meal _mealFromRow(MealsTableData row, List<MealItem> items) => Meal(
        id: row.id,
        planId: row.planId,
        name: row.name,
        time: row.time,
        mealItems: items,
      );

  MealItem _itemFromRow(MealItemsTableData row) => MealItem(
        id: row.id,
        mealId: row.mealId,
        ingredientId: row.ingredientId,
        weightUnitId: row.weightUnitId,
        amount: row.amount,
        order: row.order,
      );

  LogItem _logFromRow(LogItemsTableData row) => LogItem(
        id: row.id,
        planId: row.planId,
        mealId: row.mealId,
        ingredientId: row.ingredientId,
        weightUnitId: row.weightUnitId,
        datetime: row.datetime,
        amount: row.amount,
      );

  Future<List<MealItem>> _itemsForMeal(String mealId) async {
    final rows = await (_db.select(_db.mealItemsTable)
          ..where((t) => t.mealId.equals(mealId))
          ..orderBy([(t) => OrderingTerm.asc(t.order)]))
        .get();
    return rows.map(_itemFromRow).toList();
  }

  Future<List<Meal>> _mealsForPlan(String planId) async {
    final rows = await (_db.select(_db.mealsTable)
          ..where((t) => t.planId.equals(planId)))
        .get();
    final result = <Meal>[];
    for (final row in rows) {
      final items = await _itemsForMeal(row.id);
      result.add(_mealFromRow(row, items));
    }
    return result;
  }
}