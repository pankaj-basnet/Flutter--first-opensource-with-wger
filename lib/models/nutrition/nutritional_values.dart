import 'package:realflutter/models/nutrition/nutritional_goals.dart';

class NutritionalValues {
  double energy = 0;
  double protein = 0;
  double carbohydrates = 0;
  double carbohydratesSugar = 0;
  double fat = 0;
  double fatSaturated = 0;
  double fiber = 0;
  double sodium = 0;

  NutritionalValues();

  NutritionalValues.values(
    this.energy,
    this.protein,
    this.carbohydrates,
    this.carbohydratesSugar,
    this.fat,
    this.fatSaturated,
    this.fiber,
    this.sodium,
  );

  double get energyKj {
    return energy * 4.184;
  }

  void add(NutritionalValues data) {
    energy += data.energy;
    protein += data.protein;
    carbohydrates += data.carbohydrates;
    carbohydratesSugar += data.carbohydratesSugar;
    fat += data.fat;
    fatSaturated += data.fatSaturated;
    fiber += data.fiber;
    sodium += data.sodium;
  }

  NutritionalValues operator +(NutritionalValues o) {
    return NutritionalValues.values(
      energy + o.energy,
      protein + o.protein,
      carbohydrates + o.carbohydrates,
      carbohydratesSugar + o.carbohydratesSugar,
      fat + o.fat,
      fatSaturated + o.fatSaturated,
      fiber + o.fiber,
      sodium + o.sodium,
    );
  }

  NutritionalValues operator /(double o) {
    return NutritionalValues.values(
      energy / o,
      protein / o,
      carbohydrates / o,
      carbohydratesSugar / o,
      fat / o,
      fatSaturated / o,
      fiber / o,
      sodium / o,
    );
  }

  @override
  bool operator ==(other) {
    return other is NutritionalValues &&
        energy == other.energy &&
        protein == other.protein &&
        carbohydrates == other.carbohydrates &&
        carbohydratesSugar == other.carbohydratesSugar &&
        fat == other.fat &&
        fatSaturated == other.fatSaturated &&
        fiber == other.fiber &&
        sodium == other.sodium;
  }

  double prop(String name) {
    return switch (name) {
      'energy' => energy,
      'protein' => protein,
      'carbohydrates' => carbohydrates,
      'carbohydratesSugar' => carbohydratesSugar,
      'fat' => fat,
      'fatSaturated' => fatSaturated,
      'fiber' => fiber,
      'sodium' => sodium,
      _ => 0,
    };
  }

  @override
  String toString() {
    return 'e: $energy, p: $protein, c: $carbohydrates, cS: $carbohydratesSugar, f: $fat, fS: $fatSaturated, fi: $fiber, s: $sodium';
  }

  NutritionalGoals toGoals() {
    return NutritionalGoals(
      energy: energy,
      protein: protein,
      carbohydrates: carbohydrates,
      carbohydratesSugar: carbohydratesSugar,
      fat: fat,
      fatSaturated: fatSaturated,
      fiber: fiber,
      sodium: sodium,
    );
  }

  @override
  int get hashCode => Object.hash(
    energy,
    protein,
    carbohydrates,
    carbohydratesSugar,
    fat,
    fatSaturated,
    fiber,
    sodium,
  );
}
