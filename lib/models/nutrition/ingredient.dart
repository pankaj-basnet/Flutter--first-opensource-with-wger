// lib/models/nutrition/ingredient.dart
// Mirrors nutrition_ingredient table in Drift + Django.
// Integer PK — comes from server.

enum NutriScore { a, b, c, d, e }

class Ingredient {
  final int id;
  final String uuid;
  final String name;
  final int languageId;
  final int energy; // kcal per 100 g
  final double carbohydrates;
  final double? carbohydratesSugar;
  final double protein;
  final double fat;
  final double? fatSaturated;
  final double? fiber;
  final double? sodium;
  final bool? isVegan;
  final bool? isVegetarian;
  final NutriScore? nutriscore;
  final DateTime? created;
  final List<IngredientWeightUnit> weightUnits;

  const Ingredient({
    required this.id,
    this.uuid = '',
    required this.name,
    this.languageId = 2,
    required this.energy,
    required this.carbohydrates,
    this.carbohydratesSugar,
    required this.protein,
    required this.fat,
    this.fatSaturated,
    this.fiber,
    this.sodium,
    this.isVegan,
    this.isVegetarian,
    this.nutriscore,
    this.created,
    this.weightUnits = const [],
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    NutriScore? score;
    if (json['nutriscore'] != null) {
      score = NutriScore.values.firstWhere(
        (e) => e.name == json['nutriscore'].toString().toLowerCase(),
        orElse: () => NutriScore.a,
      );
    }
    return Ingredient(
      id: json['id'] as int,
      uuid: json['uuid'] as String? ?? '',
      name: json['name'] as String,
      languageId: json['language_id'] as int? ?? 2,
      energy: _parseInt(json['energy']),
      carbohydrates: _parseDouble(json['carbohydrates']),
      carbohydratesSugar: json['carbohydrates_sugar'] != null
          ? _parseDouble(json['carbohydrates_sugar'])
          : null,
      protein: _parseDouble(json['protein']),
      fat: _parseDouble(json['fat']),
      fatSaturated: json['fat_saturated'] != null
          ? _parseDouble(json['fat_saturated'])
          : null,
      fiber: json['fiber'] != null ? _parseDouble(json['fiber']) : null,
      sodium: json['sodium'] != null ? _parseDouble(json['sodium']) : null,
      isVegan: json['is_vegan'] as bool?,
      isVegetarian: json['is_vegetarian'] as bool?,
      nutriscore: score,
      created: json['created'] != null
          ? DateTime.tryParse(json['created'].toString())
          : null,
      weightUnits: (json['weight_units'] as List<dynamic>? ?? [])
          .map((u) => IngredientWeightUnit.fromJson(u as Map<String, dynamic>))
          .toList(),
    );
  }

  static int _parseInt(dynamic v) =>
      v is int ? v : int.tryParse(v.toString()) ?? 0;

  static double _parseDouble(dynamic v) =>
      v is double ? v : double.tryParse(v.toString()) ?? 0.0;
}

class IngredientWeightUnit {
  final int id;
  final int ingredientId;
  final String name;
  final int? gram;

  const IngredientWeightUnit({
    required this.id,
    required this.ingredientId,
    required this.name,
    required this.gram,
  });

  factory IngredientWeightUnit.fromJson(Map<String, dynamic> json) =>
      IngredientWeightUnit(
        id: json['id'] as int,
        ingredientId: json['ingredient_id'] as int? ?? 0,
        name: json['name'] as String,
        gram: json['gram'] as int? ?? json['grams'] as int? ?? 0,
      );
}
