import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:realflutter/database/powersync/database.dart';
import 'package:realflutter/helpers/consts.dart';
import 'package:realflutter/helpers/date.dart';
import 'package:realflutter/models/nutrition/log.dart';
import 'package:realflutter/models/nutrition/meal_item.dart';
import 'package:realflutter/models/nutrition/nutritional_values.dart';

class Meal {
  String? id;

  late String planId;

  TimeOfDay? time;

  late String name;

  int order = 1;

  List<MealItem> mealItems = [];

  List<LogItem> diaryEntries = [];

  List<LogItem> get diaryEntriesToday => diaryEntries
      .where((element) => element.datetime.isSameDayAs(DateTime.now()))
      .toList();

  Meal({
    this.id,
    String? plan,
    this.time,
    String? name,
    List<MealItem>? mealItems,
    List<LogItem>? diaryEntries,
  }) {
    if (plan != null) {
      planId = plan;
    }

    this.mealItems = mealItems ?? [];
    this.diaryEntries = diaryEntries ?? [];
    this.name = name ?? '';
  }

factory Meal.fromJson(Map<String, dynamic> json) {
  return Meal(
    id: json['id'] as String?,
    name: json['name'] as String,
    time: json['time'] != null ? TimeOfDay(
      hour: int.parse(json['time'].split(':')[0]),
      minute: int.parse(json['time'].split(':')[1]),
    ) : null,
    // Map the list of mealItems correctly
    mealItems: (json['mealItems'] as List<dynamic>?)
        ?.map((item) => MealItem.fromJson(item as Map<String, dynamic>))
        .toList() ?? [],
  );
}
  Meal.fromDrift({
    this.id,
    required String planId,
    required int order,
    this.time,
    required String name,
  }) {
    this.planId = planId;
    this.order = order;
    this.name = name;
    mealItems = [];
    diaryEntries = [];
  }

  NutritionalValues get plannedNutritionalValues {
    return mealItems.fold(
      NutritionalValues(),
      (a, b) => a + b.nutritionalValues,
    );
  }

  NutritionalValues get loggedNutritionalValuesToday {
    return diaryEntries
        .where((l) => l.datetime.isSameDayAs(DateTime.now()))
        .fold(NutritionalValues(), (a, b) => a + b.nutritionalValues);
  }

  bool get isRealMeal {
    return id != null && id != PSEUDO_MEAL_ID;
  }

  MealTableCompanion toCompanion() {
    return MealTableCompanion(
      id: id != null ? drift.Value(id!) : const drift.Value.absent(),
      planId: drift.Value(planId),
      order: drift.Value(order),
      time: time == null ? const drift.Value.absent() : drift.Value(time!),
      name: drift.Value(name),
    );
  }

  Meal copyWith({
    String? id,
    String? planId,
    TimeOfDay? time,
    String? name,
    List<MealItem>? mealItems,
    List<LogItem>? diaryEntries,
  }) {
    return Meal(
      id: id ?? this.id,
      plan: planId ?? this.planId,
      time: time ?? this.time,
      name: name ?? this.name,
      mealItems: mealItems ?? this.mealItems,
      diaryEntries: diaryEntries ?? this.diaryEntries,
    );
  }
}
