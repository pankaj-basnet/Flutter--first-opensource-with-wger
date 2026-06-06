// lib/models/nutrition/meal.dart

import 'package:flutter/material.dart' show TimeOfDay;
import 'package:realflutter/models/nutrition/meal_item.dart';

class Meal {
  final String id;
  final String planId;
  final String name;

  /// Meal time stored as 'HH:mm' string, e.g. '08:30'.
  final TimeOfDay? time;
  final int order;
  final List<MealItem> mealItems;

  const Meal({
    required this.id,
    required this.planId,
    this.name = '',
    this.time,
    this.order = 1,
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
      time: _parseTime(json['time'] as String?),
      order: json['order'] as int? ?? 1,
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
    this.order = 1,
    this.mealItems = const [],
  });

  Meal copyWith({
    String? id,
    String? planId,
    String? name,
    final TimeOfDay? time,
    final int? order,
    List<MealItem>? mealItems,
  }) {
    return Meal(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      name: name ?? this.name,
      time: time ?? this.time,
      order: order ?? this.order,
      mealItems: mealItems ?? this.mealItems,
    );
  }

  static TimeOfDay? _parseTime(String? s) {
    if (s == null || !s.contains(':')) return null;
    final parts = s.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0,
      minute: int.tryParse(parts[1]) ?? 0,
    );
  }
}
