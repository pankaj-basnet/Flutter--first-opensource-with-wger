import 'package:drift/drift.dart' as drift;
import 'package:realflutter/database/powersync/database.dart';
import 'package:realflutter/models/nutrition/ingredient.dart';
import 'package:realflutter/models/nutrition/ingredient_weight_unit.dart';
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/models/nutrition/nutritional_values.dart';

class LogItem {
  String? id;

  String planId;

  String? mealId;

  int ingredientId;
  int? weightUnitId;
  late DateTime datetime;
  late num amount;
  String? comment;

  Ingredient? ingredient;

  IngredientWeightUnit? weightUnitObj;

  LogItem({
    this.id,
    this.mealId,
    required this.ingredientId,
    this.weightUnitId,
    required num amount,
    required this.planId,
    required DateTime datetime,
    this.comment,
  }) {
    this.amount = amount;
    this.datetime = datetime;
  }

  LogItem.fromMealItem(
    MealItem mealItem,
    this.planId,
    this.mealId, [
    DateTime? dateTime,
  ]) : ingredientId = mealItem.ingredientId,
       weightUnitId = mealItem.weightUnitId {
    ingredient = mealItem.ingredient;
    datetime = dateTime ?? DateTime.now();
    amount = mealItem.amount;
  }

  factory LogItem.fromJson(Map<String, dynamic> json) {
    // Ensure we safely isolate nested map parsing issues
    final mealItemMap = json['mealItem'] as Map<String, dynamic>? ?? {};
    final mealItem = MealItem.fromJson(mealItemMap);

    return LogItem.fromMealItem(
      mealItem,
      (json['planId'] as String?) ?? '',
      json['mealId'] as String?,
      json['datetime'] != null
          ? DateTime.parse(json['datetime'] as String)
          : DateTime.now(),
    );
  }

  LogItemTableCompanion toCompanion() {
    return LogItemTableCompanion(
      id: id != null ? drift.Value(id!) : const drift.Value.absent(),
      planId: drift.Value(planId),
      mealId: mealId == null
          ? const drift.Value.absent()
          : drift.Value(mealId!),
      ingredientId: drift.Value(ingredientId),
      weightUnitId: weightUnitId == null
          ? const drift.Value.absent()
          : drift.Value(weightUnitId!),
      datetime: drift.Value(datetime.toUtc()),
      amount: drift.Value(amount.toDouble()),
      comment: comment == null
          ? const drift.Value.absent()
          : drift.Value(comment!),
    );
  }

  NutritionalValues get nutritionalValues {
    final ing = ingredient;
    if (ing == null) {
      return NutritionalValues();
    }
    final weight = weightUnitObj == null
        ? amount
        : amount * weightUnitObj!.grams;
    return ing.nutritionalValues / (100 / weight);
  }
}
