import 'package:json_annotation/json_annotation.dart';
import 'package:realflutter/helpers/json.dart';
import 'package:realflutter/models/nutrition/ingredient_image.dart';
import 'package:realflutter/models/nutrition/ingredient_weight_unit.dart';
import 'package:realflutter/models/nutrition/nutritional_values.dart';

part 'ingredient.g.dart';

enum NutriScore {
  @JsonValue('a')
  a,
  @JsonValue('b')
  b,
  @JsonValue('c')
  c,
  @JsonValue('d')
  d,
  @JsonValue('e')
  e,
}

@JsonSerializable()
class Ingredient {
  @JsonKey(required: true)
  final int id;

  @JsonKey(required: true, name: 'remote_id')
  final String? remoteId;

  final int? languageId;

  @JsonKey(required: true, name: 'source_name')
  final String? sourceName;

  @JsonKey(required: true, name: 'source_url')
  final String? sourceUrl;

  @JsonKey(required: true, name: 'license_object_url')
  final String? licenseObjectURl;

  @JsonKey(required: true)
  final String? code;

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true, name: 'created')
  final DateTime created;

  @JsonKey(required: true)
  final int energy;

  @JsonKey(required: true, fromJson: stringToNum, toJson: numToString)
  final num carbohydrates;

  @JsonKey(
    required: true,
    fromJson: stringToNumNull,
    toJson: numToString,
    name: 'carbohydrates_sugar',
  )
  final num? carbohydratesSugar;

  @JsonKey(required: true, fromJson: stringToNum, toJson: numToString)
  final num protein;

  @JsonKey(required: true, fromJson: stringToNum, toJson: numToString)
  final num fat;

  @JsonKey(
    required: true,
    fromJson: stringToNumNull,
    toJson: numToString,
    name: 'fat_saturated',
  )
  final num? fatSaturated;

  @JsonKey(required: true, fromJson: stringToNumNull, toJson: numToString)
  final num? fiber;

  @JsonKey(required: true, fromJson: stringToNumNull, toJson: numToString)
  final num? sodium;

  @JsonKey(name: 'is_vegan')
  final bool? isVegan;

  @JsonKey(name: 'is_vegetarian')
  final bool? isVegetarian;

  @JsonKey(name: 'nutriscore')
  final NutriScore? nutriscore;

  IngredientImage? image;

  @JsonKey(name: 'weight_units', defaultValue: <IngredientWeightUnit>[])
  List<IngredientWeightUnit> weightUnits;

  Ingredient({
    required this.remoteId,
    required this.sourceName,
    required this.sourceUrl,
    this.languageId,
    this.licenseObjectURl,
    required this.id,
    required this.code,
    required this.name,
    required this.created,
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
    this.image,
    this.weightUnits = const [],
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  NutritionalValues get nutritionalValues {
    return NutritionalValues.values(
      energy * 1,
      protein * 1,
      carbohydrates * 1,
      (carbohydratesSugar ?? 0) * 1,
      fat * 1,
      (fatSaturated ?? 0) * 1,
      (fiber ?? 0) * 1,
      (sodium ?? 0) * 1,
    );
  }
}
