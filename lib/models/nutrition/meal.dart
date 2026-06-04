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

  // Constructor used by Drift @UseRowClass(Meal, constructor: 'fromDrift')
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

//   factory Meal.fromJson(Map<String, dynamic> json) {
//     return Meal(
//       id: json['id']?.toString(),
//       planId: json['plan_id']?.toString(),
//       order: json['order'] as int? ?? 1,
//       time: stringToTimeNull(json['time']?.toString()),
//       name: json['name']?.toString() ?? '',
//       items: (json['mealItems'] as List<dynamic>?
//               ?? json['items'] as List<dynamic>?
//               ?? [])
//           .map((i) => MealItem.fromJson(i as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   /// Drift fromDrift constructor — used by @UseRowClass
//   Meal.fromDrift({
//     required this.id,
//     required this.planId,
//     required this.order,
//     required this.time,
//     required this.name,
//   }) : items = const [];
// }