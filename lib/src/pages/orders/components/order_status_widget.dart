import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;
  final bool isOverdue;

  final Map<String, int> allStatus = <String, int>{
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 0,
    'shipping': 0,
    'delivered': 0,
  };

  int get currentStatus => allStatus[status]!;

  OrderStatusWidget({
    super.key,
    required this.status,
    required this.isOverdue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _StatusDot(
          isActive: true,
          orderStatus: 'Pedido confirmado',
        ),
        _CustomDivider(),
        if (currentStatus == 1) ...[
          const _StatusDot(
            isActive: true,
            orderStatus: 'Pix estornado',
            backgroundColor: Colors.orange,
          ),
        ] else if (isOverdue) ...[
          const _StatusDot(
            isActive: true,
            orderStatus: 'Pagamento Pix vencido',
            backgroundColor: Colors.red,
          ),
        ] else ...[
          const _StatusDot(
            isActive: true,
            orderStatus: 'Pagamento',
          ),
          _CustomDivider(),
          const _StatusDot(
            isActive: true,
            orderStatus: 'Preparando',
          ),
          _CustomDivider(),
          const _StatusDot(
            isActive: true,
            orderStatus: 'Envio',
          ),
          _CustomDivider(),
          const _StatusDot(
            isActive: true,
            orderStatus: 'Entregue',
          ),
        ],
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      height: 10,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  final String orderStatus;
  final Color? backgroundColor;

  const _StatusDot({
    required this.isActive,
    required this.orderStatus,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Check
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: CustomColors.customSwatchColor,
            ),
            color: isActive
                ? backgroundColor ?? CustomColors.customSwatchColor
                : Colors.transparent,
          ),
          child: isActive
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 13,
                )
              : const SizedBox.shrink(),
        ),

        // Texto de status
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            orderStatus,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ))
      ],
    );
  }
}
