import 'package:json_annotation/json_annotation.dart';

part 'ingredient_weight_unit.g.dart';


@JsonSerializable()
class IngredientWeightUnit {
  @JsonKey(required: true)
  final int id;

  @JsonKey(required: true)
  final String uuid;

  /// FK to the parent ingredient
  @JsonKey(required: true, name: 'ingredient')
  final int ingredientId;

  @JsonKey(required: true)
  final String name;

  @JsonKey(required: true, name: 'gram')
  final int grams;

  const IngredientWeightUnit({
    required this.id,
    required this.uuid,
    required this.ingredientId,
    required this.name,
    required this.grams,
  });

  // Boilerplate
  factory IngredientWeightUnit.fromJson(Map<String, dynamic> json) =>
      _$IngredientWeightUnitFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientWeightUnitToJson(this);
}
