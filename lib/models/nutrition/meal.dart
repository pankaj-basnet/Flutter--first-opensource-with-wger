// lib/models/nutrition/meal.dart

import 'package:flutter/material.dart' show TimeOfDay;
import 'package:realflutter/models/nutrition/meal_item.dart';

class Meal {
  final String id;
  final String planId;
  final String name;
  final TimeOfDay? time;
  final List<MealItem> mealItems;

  const Meal({
    required this.id,
    this.planId = '',
    this.name = '',
    this.time,
    this.mealItems = const [],
  });

  Meal.fromDrift({
    required this.id,
    required this.planId,
    required this.name,
    this.time,
    this.mealItems = const [],
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    TimeOfDay? tod;
    final t = json['time'] as String?;
    if (t != null) {
      final parts = t.split(':');
      if (parts.length >= 2) {
        tod = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      }
    }
    return Meal(
      id: json['id']?.toString() ?? '',
      planId: json['plan_id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      time: tod,
      mealItems: (json['mealItems'] as List<dynamic>? ?? [])
          .map((i) => MealItem.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
