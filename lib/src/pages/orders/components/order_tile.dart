import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/orders/components/order_status_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  const OrderTile({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    UtilsServices utilsServices = UtilsServices();

    return Card(
        shadowColor: Colors.black,
        color: Colors.white,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pedido: ${order.id}'),
                Text(
                  utilsServices.formatDateTime(order.createdDateTime),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // Corpo do card
            children: [
              SizedBox(
                height: 200,
                child: Row(
                  children: [
                    // Lista de produtos
                    Expanded(
                      flex: 3,
                      child: ListView(
                        children: order.items.map((orderItem) {
                          return _OrderItemWidget(
                            order: orderItem,
                          );
                        }).toList(),
                      ),
                    ),

                    // Divisão
                    VerticalDivider(
                      color: Colors.grey.shade300,
                      thickness: 2,
                      width: 8,
                    ),

                    // Status do pedido
                    Expanded(
                      flex: 2,
                      child: OrderStatusWidget(
                        status: order.status,
                        isOverdue: order.overdueDateTime.isBefore(
                          DateTime.now(),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class _OrderItemWidget extends StatelessWidget {
  final CartItemModel order;
  const _OrderItemWidget({
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final UtilsServices utilsServices = UtilsServices();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${order.quantity} ${order.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(order.item.itemName),
          ),
          Text(
            utilsServices.priceToCurrency(order.item.price),
          )
        ],
      ),
    );
  }
}
