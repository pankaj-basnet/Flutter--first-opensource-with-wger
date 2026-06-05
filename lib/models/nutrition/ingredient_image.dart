import 'package:json_annotation/json_annotation.dart';

part 'ingredient_image.g.dart';

@JsonSerializable()
class IngredientImage {
  @JsonKey(required: true)
  final int id;

  @JsonKey(required: true)
  final String uuid;

  @JsonKey(required: true, name: 'ingredient_id')
  final int ingredientId;

  @JsonKey(required: true)
  final String image;

  @JsonKey(required: true)
  final int size;

  @JsonKey(required: true)
  final int width;

  @JsonKey(required: true)
  final int height;

  @JsonKey(required: true)
  final DateTime created;

  const IngredientImage({
    required this.id,
    required this.uuid,
    required this.ingredientId,
    required this.image,
    required this.size,
    required this.width,
    required this.height,
    required this.created,
  });

  factory IngredientImage.fromJson(Map<String, dynamic> json) =>
      _$IngredientImageFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientImageToJson(this);
}
D:\src_dev\flutter\F-fowd--realworld-wger-\may29-\CODE-\realflutter\lib\models\nutrition\ingredient_image.dart