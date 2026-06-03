import 'package:realflutter/helpers/consts.dart';
import 'package:realflutter/models/nutrition/nutritional_values.dart';

class NutritionalGoals {
  double? energy = 0;
  double? protein = 0;
  double? carbohydrates = 0;
  double? carbohydratesSugar = 0;
  double? fat = 0;
  double? fatSaturated = 0;
  double? fiber = 0;
  double? sodium = 0;

  NutritionalGoals({
    this.energy,
    this.protein,
    this.carbohydrates,
    this.carbohydratesSugar,
    this.fat,
    this.fatSaturated,
    this.fiber,
    this.sodium,
  }) {
    if (energy == null) {
      if (protein != null && carbohydrates != null && fat != null) {
        energy =
            protein! * ENERGY_PROTEIN +
            carbohydrates! * ENERGY_CARBOHYDRATES +
            fat! * ENERGY_FAT;
      }
      return;
    }

    if (protein == null && carbohydrates != null && fat != null) {
      protein =
          (energy! -
              carbohydrates! * ENERGY_CARBOHYDRATES -
              fat! * ENERGY_FAT) /
          ENERGY_PROTEIN;
      assert(protein! > 0);
    } else if (carbohydrates == null && protein != null && fat != null) {
      carbohydrates =
          (energy! - protein! * ENERGY_PROTEIN - fat! * ENERGY_FAT) /
          ENERGY_CARBOHYDRATES;
      assert(carbohydrates! > 0);
    } else if (fat == null && protein != null && carbohydrates != null) {
      fat =
          (energy! -
              protein! * ENERGY_PROTEIN -
              carbohydrates! * ENERGY_CARBOHYDRATES) /
          ENERGY_FAT;
      assert(fat! > 0);
    }
  }

  NutritionalGoals operator /(double v) {
    return NutritionalGoals(
      energy: energy != null ? energy! / v : null,
      protein: protein != null ? protein! / v : null,
      carbohydrates: carbohydrates != null ? carbohydrates! / v : null,
      carbohydratesSugar: carbohydratesSugar != null
          ? carbohydratesSugar! / v
          : null,
      fat: fat != null ? fat! / v : null,
      fatSaturated: fatSaturated != null ? fatSaturated! / v : null,
      fiber: fiber != null ? fiber! / v : null,
      sodium: sodium != null ? sodium! / v : null,
    );
  }

  bool isComplete() {
    return energy != null &&
        protein != null &&
        carbohydrates != null &&
        fat != null;
  }

  NutritionalValues toValues() {
    return NutritionalValues.values(
      energy ?? 0,
      protein ?? 0,
      carbohydrates ?? 0,
      carbohydratesSugar ?? 0,
      fat ?? 0,
      fatSaturated ?? 0,
      fiber ?? 0,
      sodium ?? 0,
    );
  }

  NutritionalGoals energyPercentage() {
    final goals = NutritionalGoals();

    if (energy == null || energy == 0) {
      return goals;
    }

    if (protein != null) {
      goals.protein = (100 * protein! * ENERGY_PROTEIN) / energy!;
    }
    if (carbohydrates != null) {
      goals.carbohydrates =
          (100 * carbohydrates! * ENERGY_CARBOHYDRATES) / energy!;
    }
    if (fat != null) {
      goals.fat = (100 * fat! * ENERGY_FAT) / energy!;
    }
    return goals;
  }

  double? prop(String name) {
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is NutritionalGoals &&
        other.energy == energy &&
        other.protein == protein &&
        other.carbohydrates == carbohydrates &&
        other.carbohydratesSugar == carbohydratesSugar &&
        other.fat == fat &&
        other.fatSaturated == fatSaturated &&
        other.fiber == fiber &&
        other.sodium == sodium;
  }
}
