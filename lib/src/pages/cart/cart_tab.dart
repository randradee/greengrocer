import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/shared/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrinho',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        shadowColor: Colors.black,
        elevation: 10,
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Itens do carrinho
            Column(
              children: [
                AddedCartItem(item: app_data.items[0]),
                AddedCartItem(item: app_data.items[1]),
                AddedCartItem(item: app_data.items[2]),
              ],
            ),

            // Campo de total
            SizedBox(
              height: 150,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Total geral',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'R\$ 48,50',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),

                      // Botão Concluir pedido
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.customSwatchColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: const Text(
                              'Concluir pedido',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddedCartItem extends StatelessWidget {
  final ItemModel item;

  const AddedCartItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final UtilsServices utilsServices = UtilsServices();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Imagem do produto
                      SizedBox(
                        width: 70,
                        child: Image.asset(item.imgUrl),
                      ),
                      // Textos de descrição do produto
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.itemName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              utilsServices.priceToCurrency(item.price),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.customSwatchColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  QuantityWidget(
                      value: 1,
                      unitLabel: app_data.items[0].unit,
                      result: (result) {})
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
