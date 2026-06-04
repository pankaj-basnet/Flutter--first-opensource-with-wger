// lib/models/nutrition/nutritional_plan.dart

import 'package:realflutter/models/nutrition/log.dart';
import 'package:realflutter/models/nutrition/meal.dart';

class NutritionalPlan {
  final String id;
  final String description;
  final List<Meal> meals;
  final List<LogItem> diaryEntries;

  const NutritionalPlan({
    required this.id,
    this.description = '',
    this.meals = const [],
    this.diaryEntries = const [],
  });

  factory NutritionalPlan.fromJson(Map<String, dynamic> json) {
    return NutritionalPlan(
      id: json['id']?.toString() ?? '',
      description: json['name'] as String? ?? json['description'] as String? ?? '',
      meals: (json['meals'] as List<dynamic>? ?? [])
          .map((m) => Meal.fromJson(m as Map<String, dynamic>))
          .toList(),
      diaryEntries: (json['diaryEntries'] as List<dynamic>? ?? [])
          .map((e) => LogItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

//   /// Deduplicated diary entries — by ingredient id, keeping the most recent.
//   /// Used by IngredientForm to populate the "Recently Used" list.
//   List<LogItem> get dedupDiaryEntries {
//     final seen = <int>{};
//     final result = <LogItem>[];
//     for (final entry in diaryEntries) {
//       if (seen.add(entry.ingredientId)) {
//         result.add(entry);
//       }
//     }
//     return result;
//   }

//   factory NutritionalPlan.fromJson(Map<String, dynamic> json) {
//     return NutritionalPlan(
//       id: json['id']?.toString(),
//       description: json['name']?.toString() ?? json['description']?.toString() ?? '',
//       meals: (json['meals'] as List<dynamic>? ?? [])
//           .map((m) => Meal.fromJson(m as Map<String, dynamic>))
//           .toList(),
//       diaryEntries: (json['diaryEntries'] as List<dynamic>? ?? [])
//           .map((e) => LogItem.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }
// }