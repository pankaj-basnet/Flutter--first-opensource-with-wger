// lib/models/nutrition/log.dart
// Mirrors nutrition_logitem in Drift + Django.

// import 'package:drift/drift.dart';
// import 'package:realflutter/models/nutrition/ingredient.dart';
// import 'package:realflutter/models/nutrition/meal_item.dart';
// import 'package:realflutter/models/nutrition/nutritional_values.dart';
// import 'package:realflutter/database/powersync/database.dart';

class LogItem {
  final String id;
  final String planId;
  final String? mealId;
  final int ingredientId;
  final int? weightUnitId;
  final DateTime datetime;
  final double amount;

  const LogItem({
    required this.id,
    required this.planId,
    this.mealId,
    required this.ingredientId,
    this.weightUnitId,
    required this.datetime,
    required this.amount,
  });

  factory LogItem.fromJson(Map<String, dynamic> json) {
    final mealItem = json['mealItem'] as Map<String, dynamic>?;
    return LogItem(
      id: json['id']?.toString() ?? '',
      planId: json['planId']?.toString() ?? '',
      mealId: json['mealId']?.toString(),
      ingredientId: mealItem?['ingredientId'] as int? ?? 0,
      weightUnitId: mealItem?['weight_unit_id'] as int?,
      datetime: DateTime.tryParse(json['datetime']?.toString() ?? '') ?? DateTime.now(),
      amount: (mealItem?['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

  // /// Create a LogItem from a filled MealItem + context.
  // factory LogItem.fromMealItem(
  //   MealItem item,
  //   String planId,
  //   String? mealId,
  //   DateTime dt,
  // ) {
  //   return LogItem(
  //     planId: planId,
  //     mealId: mealId,
  //     ingredientId: item.ingredientId,
  //     weightUnitId: item.weightUnitId,
  //     datetime: dt,
  //     amount: item.amount,
  //     ingredient: item.ingredient,
  //   );
  // }

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

//   /// Build a Drift Companion for db.into(db.logItemTable).insert()
//   LogItemTableCompanion toCompanion() {
//     return LogItemTableCompanion.insert(
//       planId: planId,
//       mealId: Value(mealId),
//       ingredientId: ingredientId,
//       weightUnitId: Value(weightUnitId),
//       datetime: datetime,
//       amount: amount,
//       comment: Value(comment),
//     );
//   }

//   factory LogItem.fromJson(Map<String, dynamic> json) {
//     final mealItemJson = json['mealItem'] as Map<String, dynamic>?;
//     final ingredientJson = mealItemJson?['ingredient'] as Map<String, dynamic>?
//         ?? json['ingredient'] as Map<String, dynamic>?;

//     return LogItem(
//       id: json['id']?.toString(),
//       planId: json['planId']?.toString() ?? json['plan_id']?.toString() ?? '',
//       mealId: json['mealId']?.toString() ?? json['meal_id']?.toString(),
//       ingredientId: ingredientJson?['id'] as int?
//           ?? json['ingredient_id'] as int? ?? 0,
//       datetime: DateTime.tryParse(json['datetime'].toString()) ?? DateTime.now(),
//       amount: double.tryParse(
//             (mealItemJson?['amount'] ?? json['amount']).toString(),
//           ) ??
//           0.0,
//       ingredient: ingredientJson != null
//           ? Ingredient.fromJson(ingredientJson)
//           : null,
//     );
//   }
// }