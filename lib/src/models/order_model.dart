import 'package:greengrocer/src/models/cart_item_model.dart';

class OrderModel {
  String id;
  String copyAndPaste;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  String status;
  double total;
  List<CartItemModel> items = [];

  OrderModel({
    required this.id,
    required this.copyAndPaste,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.status,
    required this.total,
    required this.items,
  });
}
