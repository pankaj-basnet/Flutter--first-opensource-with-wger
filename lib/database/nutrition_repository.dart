import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:realflutter/database/powersync/database.dart';
import 'package:uuid/uuid.dart';
import 'package:realflutter/models/nutrition/nutritional_plan.dart';
import 'package:realflutter/models/nutrition/meal.dart' as mealdomain;
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/models/nutrition/log.dart';

const _uuid = Uuid();

class NutritionRepository {
  final DriftPowersyncDatabase _db;
  NutritionRepository(this._db);

  Stream<List<NutritionalPlan>> watchAllPlans() {
    return (_db.select(_db.nutritionalPlanTable)
          ..orderBy([(t) => OrderingTerm.desc(t.creationDate)]))
        .watch()
        .map((rows) => rows.map(_planFromRow).toList());
  }

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
    await _db
        .into(_db.nutritionalPlanTable)
        .insertOnConflictUpdate(
          NutritionalPlanTableCompanion(
            id: Value(plan.id.isEmpty ? _uuid.v7() : plan.id),
            description: Value(plan.description),
            goalEnergy: Value(plan.goalEnergy?.toInt()),
            goalProtein: Value(plan.goalProtein?.toInt()),
            goalCarbohydrates: Value(plan.goalCarbohydrates?.toInt()),
            goalFat: Value(plan.goalFat?.toInt()),
            creationDate: Value(
              plan.creationDate is DateTime
                  ? plan.creationDate as DateTime
                  : DateTime.tryParse(plan.creationDate?.toString() ?? '') ??
                        DateTime.now(),
            ),
            endDate: Value(
              plan.endDate != null
                  ? DateTime.tryParse(plan.endDate.toString())
                  : null,
            ),
            onlyLogging: const Value(false),
            startDate: Value(DateTime.now()),
            hasGoalCalories: const Value(false),
          ),
        );
  }

  Future<void> updatePlan(NutritionalPlan plan) async {
    await (_db.update(
      _db.nutritionalPlanTable,
    )..where((t) => t.id.equals(plan.id))).write(
      NutritionalPlanTableCompanion(
        description: Value(plan.description),
        goalEnergy: Value(plan.goalEnergy?.toInt()),
        goalProtein: Value(plan.goalProtein?.toInt()),
        goalCarbohydrates: Value(plan.goalCarbohydrates?.toInt()),
        goalFat: Value(plan.goalFat?.toInt()),
        endDate: Value(
          plan.endDate != null
              ? DateTime.tryParse(plan.endDate.toString())
              : null,
        ),
      ),
    );
  }

  Future<void> deletePlan(String planId) async {
    await (_db.delete(
      _db.nutritionalPlanTable,
    )..where((t) => t.id.equals(planId))).go();
  }

  // -- Meals --

  Stream<List<mealdomain.Meal>> watchMealsForPlan(String planId) {
    return (_db.select(
      _db.mealTable,
    )..where((t) => t.planId.equals(planId))).watch().asyncMap((rows) async {
      final result = <mealdomain.Meal>[];
      for (final row in rows) {
        final items = await _itemsForMeal(row.id);
        result.add(_mealWithItems(row, items));
      }
      return result;
    });
  }

  Future<void> insertMeal(mealdomain.Meal meal) async {
    final finalId = meal.id.isNotEmpty ? meal.id : _uuid.v7();
    await _db
        .into(_db.mealTable)
        .insert(
          MealTableCompanion.insert(
            id: Value(finalId),
            planId: meal.planId,
            name: Value(meal.name),
            time: Value(meal.time),
            order: Value(meal.order),
          ),
        );
  }

  Future<void> updateMeal(mealdomain.Meal meal) async {
    await (_db.update(_db.mealTable)..where((t) => t.id.equals(meal.id))).write(
      MealTableCompanion(
        name: Value(meal.name),
        time: Value(meal.time),
        order: Value(meal.order),
      ),
    );
  }

  Future<void> deleteMeal(String mealId) async {
    await _db.transaction(() async {
      await (_db.delete(
        _db.mealItemTable,
      )..where((t) => t.mealId.equals(mealId))).go();
      await (_db.delete(_db.mealTable)..where((t) => t.id.equals(mealId))).go();
    });
  }

  // -- MealItem --
  Future<void> insertMealItem(MealItem item) async {
    final finalId = item.id.isNotEmpty ? item.id : _uuid.v7();
    await _db
        .into(_db.mealItemTable)
        .insert(
          MealItemTableCompanion.insert(
            id: Value(finalId),
            mealId: item.mealId,
            ingredientId: item.ingredientId,
            weightUnitId: Value(item.weightUnitId),
            order: Value(item.order),
            amount: item.amount,
          ),
        );
  }

  Future<void> deleteMealItem(String itemId) async {
    await (_db.delete(
      _db.mealItemTable,
    )..where((t) => t.id.equals(itemId))).go();
  }

  // -- LogItem --

  Stream<List<LogItem>> watchLogsForPlan(String planId) {
    return (_db.select(_db.logItemTable)
          ..where((t) => t.planId.equals(planId))
          ..orderBy([(t) => OrderingTerm.desc(t.datetime)]))
        .watch()
        .map((rows) => rows.map(_logFromRow).toList());
  }

  Future<void> insertLog(LogItem log) async {
    await _db
        .into(_db.logItemTable)
        .insertOnConflictUpdate(
          LogItemTableCompanion(
            id: Value(log.id.isEmpty ? _uuid.v7() : log.id),
            planId: Value(log.planId),
            mealId: Value(log.mealId),
            ingredientId: Value(log.ingredientId),
            weightUnitId: Value(log.weightUnitId),
            datetime: Value(log.datetime),
            amount: Value(log.amount),
          ),
        );
  }

  Future<String> seedHardcodedInitialPlans() {
    _db.transaction<String>(() {
      final currentPlans = _db.select(_db.nutritionalPlanTable).get();
      // if (currentPlans.isNotEmpty) return;

      final nowUtc = DateTime.now().toUtc();

      // PLAN 1: Lean Bulk
      final plan1Id = 'plan-uuid-001';
      _db
          .into(_db.nutritionalPlanTable)
          .insert(
            NutritionalPlanTableCompanion.insert(
              id: Value(plan1Id),
              description: 'Lean Bulk Plan',
              creationDate: nowUtc,
              startDate: nowUtc,
              onlyLogging: false,
              hasGoalCalories: false,
              goalEnergy: const Value(3200),
              goalProtein: const Value(180),
              goalCarbohydrates: const Value(400),
              goalFat: const Value(90),
            ),
          );

      _db
          .into(_db.ingredientTable)
          .insertOnConflictUpdate(
            IngredientTableCompanion.insert(
              id: (101),
              name: 'Oatmeal',
              languageId: 2,
              created: nowUtc,
              energy: 389,
              carbohydrates: 66.0,
              protein: 13.0,
              fat: 7.0,
            ),
          );

      _db
          .into(_db.ingredientTable)
          .insertOnConflictUpdate(
            IngredientTableCompanion.insert(
              id: (104),
              name: 'Juice',
              languageId: 2,
              created: nowUtc,
              energy: 285,
              carbohydrates: 66.0,
              protein: 13.0,
              fat: 7.0,
            ),
          );

      final p1Meal1Id = 'meal-uuid-001';
      _db
          .into(_db.mealTable)
          .insert(
            MealTableCompanion.insert(
              id: Value(p1Meal1Id),
              planId: plan1Id,
              name: Value('Breakfast'),
              time: const Value(TimeOfDay(hour: 8, minute: 0)),
              order: const Value(1),
            ),
          );

      _db
          .into(_db.mealItemTable)
          .insert(
            MealItemTableCompanion.insert(
              id: Value(_uuid.v7()),
              mealId: p1Meal1Id,
              ingredientId: 101,
              amount: 100.0,
              order: const Value(1),
            ),
          );

      final p1Meal2Id = 'meal-uuid-002';
      _db
          .into(_db.mealTable)
          .insert(
            MealTableCompanion.insert(
              id: Value(p1Meal2Id),
              planId: plan1Id,
              name: Value('Snacks'),
              time: const Value(TimeOfDay(hour: 10, minute: 0)),
              order: const Value(2),
            ),
          );

      _db
          .into(_db.mealItemTable)
          .insert(
            MealItemTableCompanion.insert(
              id: Value(_uuid.v7()),
              mealId: p1Meal2Id,
              ingredientId: 104,
              amount: 100.0,
              order: const Value(1),
            ),
          );

      // PLAN 2: Cutting
      final plan2Id = 'plan-uuid-002';
      _db
          .into(_db.nutritionalPlanTable)
          .insert(
            NutritionalPlanTableCompanion.insert(
              id: Value(plan2Id),
              description: 'Keto Shred Protocol',
              creationDate: nowUtc,
              startDate: nowUtc,
              onlyLogging: false,
              hasGoalCalories: false,
              goalEnergy: const Value(1800),
              goalProtein: const Value(160),
              goalCarbohydrates: const Value(30),
              goalFat: const Value(120),
            ),
          );

      _db
          .into(_db.ingredientTable)
          .insertOnConflictUpdate(
            IngredientTableCompanion.insert(
              id: (202),
              name: 'Grilled Chicken Breast',
              languageId: 2,
              created: nowUtc,
              energy: 165,
              carbohydrates: 0.0,
              protein: 31.0,
              fat: 3.6,
            ),
          );

      final p2Meal1Id = 'meal-uuid-201';
      _db
          .into(_db.mealTable)
          .insert(
            MealTableCompanion.insert(
              id: Value(p2Meal1Id),
              planId: plan2Id,
              name: Value('Main Lunch Feeding'),
              time: const Value(TimeOfDay(hour: 13, minute: 15)),
              order: const Value(1),
            ),
          );

      _db
          .into(_db.mealItemTable)
          .insert(
            MealItemTableCompanion.insert(
              id: Value(_uuid.v7()),
              mealId: p2Meal1Id,
              ingredientId: 202,
              amount: 250.0,
              order: const Value(1),
            ),
          );
      return Future.value('temp');
    });

    // return 'temp';
    return Future.value('temp');
  }

  // Mappers
  NutritionalPlan _planFromRow(NutritionalPlanTableData row) => NutritionalPlan(
    id: row.id,
    description: row.description,
    goalEnergy: row.goalEnergy?.toDouble(),
    goalProtein: row.goalProtein?.toDouble(),
    goalCarbohydrates: row.goalCarbohydrates?.toDouble(),
    goalFat: row.goalFat?.toDouble(),
    creationDate: row.creationDate.toString(),
    endDate: row.endDate.toString(),
  );

  mealdomain.Meal _mealWithItems(mealdomain.Meal row, List<MealItem> items) {
    return row.copyWith(mealItems: items);
  }

  MealItem _itemFromRow(MealItem row) => row;

  LogItem _logFromRow(LogItemTableData row) => LogItem(
    id: row.id,
    planId: row.planId,
    mealId: row.mealId,
    ingredientId: row.ingredientId,
    weightUnitId: row.weightUnitId,
    datetime: row.datetime,
    amount: row.amount,
  );

  Future<List<MealItem>> _itemsForMeal(String mealId) async {
    final rows =
        await (_db.select(_db.mealItemTable)
              ..where((t) => t.mealId.equals(mealId))
              ..orderBy([(t) => OrderingTerm.asc(t.order)]))
            .get();
    return rows.map(_itemFromRow).toList();
  }

  Future<List<mealdomain.Meal>> _mealsForPlan(String planId) async {
    final rows = await (_db.select(
      _db.mealTable,
    )..where((t) => t.planId.equals(planId))).get();
    final result = <mealdomain.Meal>[];
    for (final row in rows) {
      final items = await _itemsForMeal(row.id);
      result.add(_mealWithItems(row, items));
    }
    return result;
  }
}
