// lib/models/nutrition/meal_item.dart

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
      ingredientId:
          json['ingredientId'] as int? ?? json['ingredient_id'] as int? ?? 0,
      weightUnitId: json['weight_unit_id'] as int?,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
