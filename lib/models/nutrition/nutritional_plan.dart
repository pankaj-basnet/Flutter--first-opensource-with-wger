// lib/models/nutrition/nutritional_plan.dart

import 'package:realflutter/models/nutrition/log.dart';
import 'package:realflutter/models/nutrition/meal.dart';

class NutritionalPlan {
  final String id;
  final String description;
  final List<Meal> meals;
  final List<LogItem> diaryEntries;

  // ── Goal fields (all optional — user may not set targets) ─────────────────
  final double? goalEnergy; // kcal / day
  final double? goalProtein; // g / day
  final double? goalCarbohydrates; // g / day
  final double? goalFat; // g / day

  // ── Date range ────────────────────────────────────────────────────────────
  // Stored as ISO-8601 date strings ('YYYY-MM-DD') to stay simple at the
  // 50% milestone. Will be converted to DateTime in the 70% polish step.
  final String? creationDate;
  final String? endDate;

  const NutritionalPlan({
    required this.id,
    this.description = '',
    this.meals = const [],
    this.diaryEntries = const [],
    this.goalEnergy,
    this.goalProtein,
    this.goalCarbohydrates,
    this.goalFat,
    this.creationDate,
    this.endDate,
  });

  factory NutritionalPlan.fromJson(Map<String, dynamic> json) {
    return NutritionalPlan(
      id: json['id']?.toString() ?? '',
      description:
          json['name'] as String? ?? json['description'] as String? ?? '',
      meals: (json['meals'] as List<dynamic>? ?? [])
          .map((m) => Meal.fromJson(m as Map<String, dynamic>))
          .toList(),
      diaryEntries: (json['diaryEntries'] as List<dynamic>? ?? [])
          .map((e) => LogItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      // Goal fields — server sends them as num or null.
      goalEnergy: _toDouble(json['goal_energy'] ?? json['goalEnergy']),
      goalProtein: _toDouble(json['goal_protein'] ?? json['goalProtein']),
      goalCarbohydrates: _toDouble(
        json['goal_carbohydrates'] ?? json['goalCarbohydrates'],
      ),
      goalFat: _toDouble(json['goal_fat'] ?? json['goalFat']),
      // Date fields.
      creationDate:
          json['creation_date'] as String? ?? json['creationDate'] as String?,
      endDate: json['end_date'] as String? ?? json['endDate'] as String?,
    );
  }

  static double? _toDouble(dynamic v) {
    if (v == null) return null;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString());
  }

  /// Creates a copy with selected fields replaced.
  NutritionalPlan copyWith({
    String? id,
    String? description,
    List<Meal>? meals,
    List<LogItem>? diaryEntries,
    double? goalEnergy,
    double? goalProtein,
    double? goalCarbohydrates,
    double? goalFat,
    String? creationDate,
    String? endDate,
  }) {
    return NutritionalPlan(
      id: id ?? this.id,
      description: description ?? this.description,
      meals: meals ?? this.meals,
      diaryEntries: diaryEntries ?? this.diaryEntries,
      goalEnergy: goalEnergy ?? this.goalEnergy,
      goalProtein: goalProtein ?? this.goalProtein,
      goalCarbohydrates: goalCarbohydrates ?? this.goalCarbohydrates,
      goalFat: goalFat ?? this.goalFat,
      creationDate: creationDate ?? this.creationDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
