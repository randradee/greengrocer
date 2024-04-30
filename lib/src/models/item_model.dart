import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String itemName;
  String imgUrl;
  String unit;
  double price;
  String description;

  ItemModel({
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.price,
    required this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
