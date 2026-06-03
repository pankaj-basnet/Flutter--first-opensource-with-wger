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

  @JsonKey(required: true, name: 'last_update')
  final DateTime lastUpdate;

  @JsonKey(required: true, name: 'license')
  final int licenseId;

  @JsonKey(required: true, name: 'license_author')
  final String? author;

  @JsonKey(required: true, name: 'license_author_url')
  final String authorUrl;

  @JsonKey(required: true, name: 'license_title')
  final String title;

  @JsonKey(required: true, name: 'license_object_url')
  final String objectUrl;

  @JsonKey(required: true, name: 'license_derivative_source_url')
  final String derivativeSourceUrl;

  const IngredientImage({
    required this.id,
    required this.uuid,
    required this.ingredientId,
    required this.image,
    required this.size,
    required this.width,
    required this.height,
    required this.created,
    required this.lastUpdate,
    required this.licenseId,
    required this.author,
    required this.authorUrl,
    required this.title,
    required this.objectUrl,
    required this.derivativeSourceUrl,
  });

  factory IngredientImage.fromJson(Map<String, dynamic> json) =>
      _$IngredientImageFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientImageToJson(this);
}
