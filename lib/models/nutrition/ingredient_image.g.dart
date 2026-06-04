// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientImage _$IngredientImageFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'uuid',
      'ingredient_id',
      'image',
      'size',
      'width',
      'height',
      'created',
    ],
  );
  return IngredientImage(
    id: (json['id'] as num).toInt(),
    uuid: json['uuid'] as String,
    ingredientId: (json['ingredient_id'] as num).toInt(),
    image: json['image'] as String,
    size: (json['size'] as num).toInt(),
    width: (json['width'] as num).toInt(),
    height: (json['height'] as num).toInt(),
    created: DateTime.parse(json['created'] as String),
  );
}

Map<String, dynamic> _$IngredientImageToJson(IngredientImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'ingredient_id': instance.ingredientId,
      'image': instance.image,
      'size': instance.size,
      'width': instance.width,
      'height': instance.height,
      'created': instance.created.toIso8601String(),
    };
