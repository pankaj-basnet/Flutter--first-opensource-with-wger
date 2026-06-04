// lib/models/nutrition/nutritional_values.dart
// Computed macros for a given amount of an ingredient.

class NutritionalValues {
  final double energy; // kcal
  final double protein; // g
  final double carbohydrates; // g
  final double fat; // g

  const NutritionalValues({
    this.energy = 0,
    this.protein = 0,
    this.carbohydrates = 0,
    this.fat = 0,
  });

  /// Scale per-100g values to [amount] grams.
  factory NutritionalValues.fromIngredient({
    required double energy100g,
    required double protein100g,
    required double carbs100g,
    required double fat100g,
    required double amount,
  }) {
    final factor = amount / 100.0;
    return NutritionalValues(
      energy: energy100g * factor,
      protein: protein100g * factor,
      carbohydrates: carbs100g * factor,
      fat: fat100g * factor,
    );
  }

  static const NutritionalValues zero = NutritionalValues();
}
