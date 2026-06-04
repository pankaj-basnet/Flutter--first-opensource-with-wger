// lib/models/nutrition/meal_item.dart
// Mirrors nutrition_mealitem in Drift + Django.

import 'package:realflutter/models/nutrition/ingredient.dart';
import 'package:realflutter/models/nutrition/nutritional_values.dart';

class MealItem {
  final String id;
  final String mealId;
  final int ingredientId;
  final int? weightUnitId;
  final double amount;
  final int order;

  const MealItem({
    required this.id,
    required this.mealId,
    required this.ingredientId,
    this.weightUnitId,
    required this.amount,
    this.order = 1,
  });

  // Required by Drift @UseRowClass(MealItem, constructor: 'fromDrift')
  MealItem.fromDrift({
    required this.id,
    required this.mealId,
    required this.ingredientId,
    this.weightUnitId,
    required this.amount,
    this.order = 1,
  });

  MealItem copyWith({
    String? id,
    String? mealId,
    int? ingredientId,
    int? weightUnitId,
    double? amount,
    int? order,
  }) => MealItem(
    id: id ?? this.id,
    mealId: mealId ?? this.mealId,
    ingredientId: ingredientId ?? this.ingredientId,
    weightUnitId: weightUnitId ?? this.weightUnitId,
    amount: amount ?? this.amount,
    order: order ?? this.order,
  );

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      id: json['id']?.toString() ?? '',
      mealId: json['mealId']?.toString() ?? json['meal_id']?.toString() ?? '',
      ingredientId: json['ingredientId'] as int? ?? json['ingredient_id'] as int? ?? 0,
      weightUnitId: json['weight_unit_id'] as int?,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

//   /// Factory for a blank form state — safe defaults, no null dangers.
//   factory MealItem.empty() => const MealItem(ingredientId: 0, amount: 0.0);

//   /// Immutable update — returns a new MealItem with changed fields.
//   MealItem copyWith({
//     String? id,
//     String? mealId,
//     int? ingredientId,
//     int? weightUnitId,
//     int? order,
//     double? amount,
//     Ingredient? ingredient,
//     bool clearIngredient = false,
//   }) {
//     return MealItem(
//       id: id ?? this.id,
//       mealId: mealId ?? this.mealId,
//       ingredientId: ingredientId ?? this.ingredientId,
//       weightUnitId: weightUnitId ?? this.weightUnitId,
//       order: order ?? this.order,
//       amount: amount ?? this.amount,
//       ingredient: clearIngredient ? null : (ingredient ?? this.ingredient),
//     );
//   }

//   /// Computed macros delegated to NutritionalValues.
//   NutritionalValues get nutritionalValues {
//     final ing = ingredient;
//     if (ing == null || amount <= 0) return NutritionalValues.zero;
//     return NutritionalValues.fromIngredient(
//       energy100g: ing.energy.toDouble(),
//       protein100g: ing.protein,
//       carbs100g: ing.carbohydrates,
//       fat100g: ing.fat,
//       amount: amount,
//     );
//   }

//   factory MealItem.fromJson(Map<String, dynamic> json) {
//     return MealItem(
//       id: json['id']?.toString(),
//       mealId: json['meal_id']?.toString() ?? json['mealId']?.toString(),
//       ingredientId: json['ingredient_id'] as int? ?? json['ingredientId'] as int? ?? 0,
//       weightUnitId: json['weight_unit_id'] as int?,
//       order: json['order'] as int? ?? 1,
//       amount: double.tryParse(json['amount'].toString()) ?? 0.0,
//       ingredient: json['ingredient'] != null
//           ? Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'meal_id': mealId,
//         'ingredient_id': ingredientId,
//         'weight_unit_id': weightUnitId,
//         'order': order,
//         'amount': amount,
//       };
// }