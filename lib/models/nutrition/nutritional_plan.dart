import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:realflutter/database/powersync/database.dart';
import 'package:realflutter/helpers/consts.dart';
import 'package:realflutter/l10n/generated/app_localizations.dart';
import 'package:realflutter/models/nutrition/log.dart';
import 'package:realflutter/models/nutrition/meal.dart';
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/models/nutrition/nutritional_goals.dart';
import 'package:realflutter/models/nutrition/nutritional_values.dart';

class NutritionalPlan {
  static const maxDescriptionChars = 80;

  static const maxGoalEnergy = 6000;
  static const maxGoalProtein = 500;
  static const maxGoalCarbohydrates = 750;
  static const maxGoalFat = 500;
  static const maxGoalFiber = 500;

  final _logger = Logger('NutritionalPlan Model');

  String? id;

  late String description;

  late DateTime creationDate;

  late DateTime startDate;

  late DateTime? endDate;

  late bool onlyLogging;

  late num? goalEnergy;

  late num? goalProtein;

  late num? goalCarbohydrates;

  late num? goalFat;

  late num? goalFiber;

  late bool hasGoalCalories;

  List<Meal> meals = [];

  List<LogItem> diaryEntries = [];

  NutritionalPlan({
    this.id,
    required this.description,
    DateTime? creationDate,
    required this.startDate,
    this.endDate,
    this.onlyLogging = false,
    this.hasGoalCalories = false,
    this.goalEnergy,
    this.goalProtein,
    this.goalCarbohydrates,
    this.goalFat,
    this.goalFiber,
    List<Meal>? meals,
    List<LogItem>? diaryEntries,
  }) : creationDate = creationDate ?? DateTime.now() {
    this.meals = meals ?? [];
    this.diaryEntries = diaryEntries ?? [];

    if (endDate != null && endDate!.isBefore(startDate)) {
      _logger.warning(
        'The end date of a nutritional plan is before the start. Setting to null! '
        'PlanId: $id, startDate: $startDate, endDate: $endDate',
      );
      endDate = null;
    }
  }

  NutritionalPlan.empty() {
    creationDate = DateTime.now();
    startDate = DateTime.now();
    endDate = null;
    description = '';
    onlyLogging = false;
    hasGoalCalories = false;
    goalEnergy = null;
    goalProtein = null;
    goalCarbohydrates = null;
    goalFiber = null;
    goalFat = null;
  }

  factory NutritionalPlan.fromJson(Map<String, dynamic> json) {
    return NutritionalPlan(
      id: json['id'] as String?,
      description: json['name'] as String? ?? '', // Mapping 'name' to 'description'
      startDate: DateTime.now(), // Defaulting since not in your current JSON
      
      // Parse Meals
      meals: (json['meals'] as List<dynamic>?)
              ?.map((m) => Meal.fromJson(m as Map<String, dynamic>))
              .toList() ?? [],
              
      // Parse Logs
      diaryEntries: (json['diaryEntries'] as List<dynamic>?)
              ?.map((l) => LogItem.fromJson(l as Map<String, dynamic>))
              .toList() ?? [],
    );
  }

  NutritionalPlanTableCompanion toCompanion() {
    return NutritionalPlanTableCompanion(
      id: id != null ? drift.Value(id!) : const drift.Value.absent(),
      description: drift.Value(description),
      creationDate: drift.Value(creationDate.toUtc()),

      startDate: drift.Value(
        DateTime.utc(startDate.year, startDate.month, startDate.day),
      ),
      endDate: endDate == null
          ? const drift.Value.absent()
          : drift.Value(
              DateTime.utc(endDate!.year, endDate!.month, endDate!.day),
            ),
      onlyLogging: drift.Value(onlyLogging),
      hasGoalCalories: drift.Value(hasGoalCalories),
      goalEnergy: goalEnergy == null
          ? const drift.Value.absent()
          : drift.Value(goalEnergy!.toInt()),
      goalProtein: goalProtein == null
          ? const drift.Value.absent()
          : drift.Value(goalProtein!.toInt()),
      goalCarbohydrates: goalCarbohydrates == null
          ? const drift.Value.absent()
          : drift.Value(goalCarbohydrates!.toInt()),
      goalFiber: goalFiber == null
          ? const drift.Value.absent()
          : drift.Value(goalFiber!.toInt()),
      goalFat: goalFat == null
          ? const drift.Value.absent()
          : drift.Value(goalFat!.toInt()),
    );
  }

  String getLabel(BuildContext context) {
    return description != ''
        ? description
        // : AppLocalizations.of(context).nutritionalPlan;
        : 'nutritional Plan';
  }

  bool get hasAnyGoals {
    return goalEnergy != null ||
        goalFat != null ||
        goalProtein != null ||
        goalCarbohydrates != null;
  }

  bool get hasAnyAdvancedGoals {
    return goalFiber != null;
  }

  NutritionalGoals get nutritionalGoals {
    if (hasAnyGoals || hasAnyAdvancedGoals) {
      return NutritionalGoals(
        energy: goalEnergy?.toDouble(),
        fat: goalFat?.toDouble(),
        protein: goalProtein?.toDouble(),
        carbohydrates: goalCarbohydrates?.toDouble(),
        fiber: goalFiber?.toDouble(),
      );
    }

    if (meals.isEmpty) {
      return NutritionalGoals();
    }

    final sumValues = meals.fold(
      NutritionalValues(),
      (a, b) => a + b.plannedNutritionalValues,
    );
    return NutritionalGoals(
      energy: sumValues.energy,
      fat: sumValues.fat,
      protein: sumValues.protein,
      carbohydrates: sumValues.carbohydrates,
      carbohydratesSugar: sumValues.carbohydratesSugar,
      fatSaturated: sumValues.fatSaturated,
      fiber: sumValues.fiber,
      sodium: sumValues.sodium,
    );
  }

  NutritionalValues get loggedNutritionalValuesToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return logEntriesValues.containsKey(today)
        ? logEntriesValues[today]!
        : NutritionalValues();
  }

  NutritionalValues get loggedNutritionalValues7DayAvg {
    final currentDate = DateTime.now();
    final sevenDaysAgo = currentDate.subtract(const Duration(days: 7));

    return diaryEntries
            .where((obj) => obj.datetime.isAfter(sevenDaysAgo))
            .fold(NutritionalValues(), (a, b) => a + b.nutritionalValues) /
        7;
  }

  Map<DateTime, NutritionalValues> get logEntriesValues {
    final out = <DateTime, NutritionalValues>{};
    for (final log in diaryEntries) {
      final date = DateTime(
        log.datetime.year,
        log.datetime.month,
        log.datetime.day,
      );

      if (!out.containsKey(date)) {
        out[date] = NutritionalValues();
      }

      out[date]!.add(log.nutritionalValues);
    }

    return out;
  }

  NutritionalValues? getValuesForDate(DateTime date) {
    final values = logEntriesValues;
    final dateKey = DateTime(date.year, date.month, date.day);

    return values.containsKey(dateKey) ? values[dateKey] : null;
  }

  List<LogItem> getLogsForDate(DateTime date) {
    final List<LogItem> out = [];
    for (final log in diaryEntries) {
      final dateKey = DateTime(date.year, date.month, date.day);
      final logKey = DateTime(
        log.datetime.year,
        log.datetime.month,
        log.datetime.day,
      );

      if (dateKey == logKey) {
        out.add(log);
      }
    }

    return out;
  }

  List<MealItem> get dedupMealItems {
    final List<MealItem> out = [];
    for (final meal in meals) {
      for (final mealItem in meal.mealItems) {
        final found = out.firstWhereOrNull(
          (e) =>
              e.amount == mealItem.amount &&
              e.ingredientId == mealItem.ingredientId,
        );

        if (found == null) {
          out.add(mealItem);
        }
      }
    }
    return out;
  }

  List<LogItem> get dedupDiaryEntries {
    final out = <LogItem>[];
    for (final log in diaryEntries) {
      final found = out.firstWhereOrNull(
        (e) => e.amount == log.amount && e.ingredientId == log.ingredientId,
      );
      if (found == null) {
        out.add(log);
      }
    }
    out.sort((a, b) => b.datetime.compareTo(a.datetime));
    return out;
  }

  Meal pseudoMealOthers(String name) {
    return Meal(
      id: PSEUDO_MEAL_ID,
      plan: id,
      name: name,
      diaryEntries: diaryEntries.where((e) => e.mealId == null).toList(),
    );
  }
}
