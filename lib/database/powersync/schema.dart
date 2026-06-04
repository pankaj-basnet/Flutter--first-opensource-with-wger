import 'package:powersync/powersync.dart';
import 'package:realflutter/database/powersync/tables/ingredient.dart';
import 'package:realflutter/database/powersync/tables/nutrition.dart';

Schema schema = const Schema([
  // Nutrition
  PowersyncIngredientTable,
  PowersyncIngredientImageTable,
  PowersyncIngredientWeightUnitTable,
  PowersyncNutritionalPlanTable,
  PowersyncMealTable,
  PowersyncMealItemTable,
  PowersyncLogItemTable,
]);
