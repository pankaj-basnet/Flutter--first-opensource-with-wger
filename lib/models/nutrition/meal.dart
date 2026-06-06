// lib/models/nutrition/meal.dart

import 'package:realflutter/models/nutrition/meal_item.dart';

class Meal {
  final String id;
  final String planId;
  final String name;
  /// Meal time stored as 'HH:mm' string, e.g. '08:30'.
  final String? time;
  final List<MealItem> mealItems;

  const Meal({
    required this.id,
    required this.planId,
    this.name = '',
    this.time,
    this.mealItems = const [],
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id']?.toString() ?? '',
      planId:
          json['planId']?.toString() ??
          json['plan_id']?.toString() ??
          json['plan']?.toString() ??
          '',
      name: json['name'] as String? ?? '',
      time: json['time'] as String?,
      mealItems: (json['items'] as List<dynamic>? ?? [])
          .map((i) => MealItem.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }


  Meal.fromDrift({
    required this.id,
    required this.planId,
    required this.name,
    this.time,
    this.mealItems = const [],
  });


  Meal copyWith({
    String? id,
    String? planId,
    String? name,
    String? time,
    List<MealItem>? mealItems,
  }) {
    return Meal(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      name: name ?? this.name,
      time: time ?? this.time,
      mealItems: mealItems ?? this.mealItems,
    );
  }
}
