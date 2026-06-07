import 'package:drift/drift.dart';
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

  // ── NutritionalPlan ───────────────────────────────────────────────────────

  /// Stream of all plans — UI rebuilds automatically on any change.
  Stream<List<NutritionalPlan>> watchAllPlans() {
    return (_db.select(_db.nutritionalPlanTable)
          ..orderBy([(t) => OrderingTerm.desc(t.creationDate)]))
        .watch()
        .map((rows) => rows.map(_planFromRow).toList());
  }

  /// Stream of one plan with all its meals + items (fully populated).
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
    // FIX: Companion class was misspelled as NunutritionalPlanTableCompanion.
    //      Correct generated name is NutritionalPlanTableCompanion.
    // FIX: goalEnergy/goalProtein/goalCarbohydrates/goalFat are IntColumn in
    //      the DB table but nullable double on the domain model — cast to int?.
    await _db
        .into(_db.nutritionalPlanTable)
        .insertOnConflictUpdate(
          NutritionalPlanTableCompanion(
            id: Value(plan.id.isEmpty ? _uuid.v4() : plan.id),
            description: Value(plan.description),
            goalEnergy: Value(plan.goalEnergy?.toInt()),
            goalProtein: Value(plan.goalProtein?.toInt()),
            goalCarbohydrates: Value(plan.goalCarbohydrates?.toInt()),
            goalFat: Value(plan.goalFat?.toInt()),
            // creationDate / endDate: the table column is DateTimeColumn but
            // the domain model stores them as nullable String.  We parse safely.
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
            // Required non-nullable columns — provide safe defaults.
            onlyLogging: const Value(false),
            startDate: Value(DateTime.now()),
            hasGoalCalories: const Value(false),
          ),
        );
  }

  Future<void> updatePlan(NutritionalPlan plan) async {
    // FIX: same companion name + int cast.
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

  // ── Seeding (first-launch + offline fallback) ─────────────────────────────

  /// Inserts [plan] (with all its meals and meal items) into the local
  /// Drift database only if a row with the same [plan.id] does not already
  /// exist. Safe to call on every app launch — it is idempotent.
  ///
  ///   1. insertPlan  → writes the plan row
  ///   2. insertMeal  → writes each meal row (FK: plan_id)
  ///   3. insertMealItem → writes each item row (FK: meal_id)
  Future<void> seedPlanIfAbsent(NutritionalPlan plan) async {
    // Check if plan row already exists
    final existing = await (_db.select(
      _db.nutritionalPlanTable,
    )..where((t) => t.id.equals(plan.id))).getSingleOrNull();

    if (existing != null) return;

    // Insert the plan row
    await insertPlan(plan);

    // Insert each meal and its items
    for (final meal in plan.meals) {
      await insertMeal(meal);
      for (final item in meal.mealItems) {
        await insertMealItem(item);
      }
    }
  }

  // ── Meal ──────────────────────────────────────────────────────────────────

  /// Live stream of meals for a plan; each meal includes its items.
  Stream<List<mealdomain.Meal>> watchMealsForPlan(String planId) {
    // FIX: accessor is mealTable (singular), matching the @DriftDatabase list.
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
    // FIX: accessor is mealTable; companion is MealTableCompanion.
    await _db
        .into(_db.mealTable)
        .insertOnConflictUpdate(
          MealTableCompanion(
            id: Value(meal.id.isEmpty ? _uuid.v4() : meal.id),
            planId: Value(meal.planId),
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
    // Cascade: delete items first, then the meal row.
    await (_db.delete(
      _db.mealItemTable,
    )..where((t) => t.mealId.equals(mealId))).go();
    await (_db.delete(_db.mealTable)..where((t) => t.id.equals(mealId))).go();
  }

  // ── MealItem ──────────────────────────────────────────────────────────────

  Future<void> insertMealItem(MealItem item) async {
    // FIX: accessor is mealItemTable; companion is MealItemTableCompanion.
    await _db
        .into(_db.mealItemTable)
        .insertOnConflictUpdate(
          MealItemTableCompanion(
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
    await (_db.delete(
      _db.mealItemTable,
    )..where((t) => t.id.equals(itemId))).go();
  }

  // ── LogItem ───────────────────────────────────────────────────────────────

  /// Live stream of log entries for a plan, newest first.
  Stream<List<LogItem>> watchLogsForPlan(String planId) {
    return (_db.select(_db.logItemTable)
          ..where((t) => t.planId.equals(planId))
          ..orderBy([(t) => OrderingTerm.desc(t.datetime)]))
        .watch()
        .map((rows) => rows.map(_logFromRow).toList());
  }

  Future<void> insertLog(LogItem log) async {
    // FIX: accessor is logItemTable; companion is LogItemTableCompanion.
    await _db
        .into(_db.logItemTable)
        .insertOnConflictUpdate(
          LogItemTableCompanion(
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

  // FIX: row type is NutritionalPlanTableData (generated from NutritionalPlanTable).
  // goalEnergy etc. are int? in the DB row; domain model expects double?.
  NutritionalPlan _planFromRow(NutritionalPlanTableData row) => NutritionalPlan(
    id: row.id,
    description: row.description,
    goalEnergy: row.goalEnergy?.toDouble(),
    goalProtein: row.goalProtein?.toDouble(),
    goalCarbohydrates: row.goalCarbohydrates?.toDouble(),
    goalFat: row.goalFat?.toDouble(),
    creationDate: row.creationDate.toIso8601String(),
    endDate: row.endDate?.toIso8601String(), 
  );

  // FIX: row type is MealTableData. MealTable uses @UseRowClass(Meal) so
  // Drift already returns Meal directly — but we also accept raw row data here
  // to attach the separately-fetched items list.
  // Meal _mealFromRow(MealTableData row, List<MealItem> items) => Meal(
  //       id: row.id,
  //       planId: row.planId,
  //       name: row.name,
  //       time: row.time,
  //       mealItems: items,
  //       order: row.order,
  //     );
  // D:\src_dev\flutter\F-fowd--realworld-wger-\may29-\CODE-\realflutter\lib\database\nutrition_repository.dart

  // ---

  //     D:\src_dev\flutter\F-fowd--realworld-wger-\may29-\CODE-\realflutter\lib\database\powersync\database.g.dart
  // typedef $$MealTableTableCreateCompanionBuilder =
  //     MealTableCompanion Function({
  //       Value<String> id,
  //       required String planId,
  //       Value<int> order,
  //       Value<TimeOfDay?> time,
  //       Value<String> name,
  //       Value<int> rowid,
  //     });
  // typedef $$MealTableTableUpdateCompanionBuilder =
  //     MealTableCompanion Function({
  //       Value<String> id,
  //       Value<String> planId,
  //       Value<int> order,
  //       Value<TimeOfDay?> time,
  //       Value<String> name,
  //       Value<int> rowid,
  //     });

  // final class $$MealTableTableReferences
  //     extends
  //         BaseReferences<
  //           _$DriftPowersyncDatabase,
  //           $MealTableTable,
  //           mealdomain.Meal
  //         > {
  //   $$MealTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  //   static $NutritionalPlanTableTable _planIdTable(_$DriftPowersyncDatabase db) =>
  //       db.nutritionalPlanTable.createAlias(
  //         $_aliasNameGenerator(db.mealTable.planId, db.nutritionalPlanTable.id),
  //       );

  // Undefined class 'Meal'.

  mealdomain.Meal _mealWithItems(mealdomain.Meal row, List<MealItem> items) =>
      row.copyWith(mealItems: items);

  // FIX: row type is MealItemTableData.
  // MealItem _itemFromRow(MealItemTableData row) => MealItem(
  // MealItem _itemFromRow(MealItemTableCompanion row) => MealItem(
  //       id: row.id,
  //       mealId: row.mealId,
  //       ingredientId: row.ingredientId,
  //       weightUnitId: row.weightUnitId,
  //       amount: row.amount,
  //       order: row.order,
  //     );

  MealItem _itemFromRow(MealItem row) => row;

  // FIX: row type is LogItemTableData.
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
