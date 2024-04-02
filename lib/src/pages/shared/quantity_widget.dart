import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class QuantityWidget extends StatelessWidget {
  final int value;
  final String unitLabel;
  final Function(int quantity) result;

  const QuantityWidget({
    super.key,
    required this.value,
    required this.unitLabel,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 2,
            )
          ]),
      child: Row(
        children: [
          // Botão remover
          _QuantityButton(
            height: 25,
            width: 25,
            color: Colors.grey,
            icon: Icons.remove,
            iconColor: Colors.white,
            onPressed: () {
              if (value == 1) return;

              int resultCount = value - 1;
              result(resultCount);
            },
          ),

          // Label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '$value$unitLabel',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Botão adicionar
          _QuantityButton(
            height: 25,
            width: 25,
            color: CustomColors.customSwatchColor,
            icon: Icons.add,
            iconColor: Colors.white,
            onPressed: () {
              int resultCount = value + 1;
              result(resultCount);
            },
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final double width;
  final double height;
  final Color color;
  final Color iconColor;
  final VoidCallback onPressed;

  const _QuantityButton({
    required this.icon,
    required this.width,
    required this.height,
    required this.color,
    required this.iconColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 16,
          ),
        ),
      ),
    );
  }
}
