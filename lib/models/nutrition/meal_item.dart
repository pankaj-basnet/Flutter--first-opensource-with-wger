import 'package:drift/drift.dart' as drift;
import 'package:realflutter/database/powersync/database.dart';
import 'package:realflutter/models/nutrition/ingredient.dart';
import 'package:realflutter/models/nutrition/ingredient_weight_unit.dart';
import 'package:realflutter/models/nutrition/nutritional_values.dart';

class MealItem {
  String? id;

  late String mealId;

  late int ingredientId;

  Ingredient? ingredient;

  int? weightUnitId;

  IngredientWeightUnit? weightUnitObj;

  late num amount;

  int order = 1;

  MealItem({
    this.id,
    String? mealId,
    required this.ingredientId,
    this.weightUnitId,
    required this.amount,
    Ingredient? ingredient,
  }) {
    if (mealId != null) {
      this.mealId = mealId;
    }
    if (ingredient != null) {
      this.ingredient = ingredient;
      ingredientId = ingredient.id;
    }
  }

  MealItem.empty() : ingredientId = 0, mealId = '', amount = 0;
  
  MealItem.fromDrift({
    this.id,
    required String mealId,
    required int ingredientId,
    this.weightUnitId,
    required int order,
    required double amount,
  }) {
    this.mealId = mealId;
    this.ingredientId = ingredientId;
    this.amount = amount;
    this.order = order;
  }

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      id: json['id'] as String?,
      mealId: json['mealId'] as String,
      ingredientId: json['ingredientId'] as int,
      amount: json['amount'] as num,
      // If the API provides the full ingredient object, hydrate it here
      ingredient: json['ingredient'] != null
          ? Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>)
          : null,
    );
  }

  MealItemTableCompanion toCompanion() {
    return MealItemTableCompanion(
      id: id != null ? drift.Value(id!) : const drift.Value.absent(),
      mealId: drift.Value(mealId),
      ingredientId: drift.Value(ingredientId),
      weightUnitId: weightUnitId == null
          ? const drift.Value.absent()
          : drift.Value(weightUnitId!),
      order: drift.Value(order),
      amount: drift.Value(amount.toDouble()),
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

  MealItem copyWith({
    String? id,
    String? mealId,
    int? ingredientId,
    int? weightUnitId,
    num? amount,
    Ingredient? ingredient,
    IngredientWeightUnit? weightUnitObj,
  }) {
    final m = MealItem(
      id: id ?? this.id,
      mealId: mealId ?? this.mealId,
      ingredientId: ingredientId ?? this.ingredientId,
      weightUnitId: weightUnitId ?? this.weightUnitId,
      amount: amount ?? this.amount,
      ingredient: ingredient ?? this.ingredient,
    );
    m.weightUnitObj = weightUnitObj ?? this.weightUnitObj;
    return m;
  }
}
