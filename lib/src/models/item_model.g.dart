// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      itemName: json['itemName'] as String,
      imgUrl: json['imgUrl'] as String,
      unit: json['unit'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'itemName': instance.itemName,
      'imgUrl': instance.imgUrl,
      'unit': instance.unit,
      'price': instance.price,
      'description': instance.description,
    };
