import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/home_controller.dart';
import 'package:greengrocer/src/pages/home/components/category_tile.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;
import 'package:greengrocer/src/pages/home/components/item_tile.dart';
import 'package:greengrocer/src/pages/shared/app_name_widget.dart';
import 'package:greengrocer/src/pages/shared/custom_shimmer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Cereais';

  var globalKeyCartItems = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  final _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: globalKeyCartItems,
      createAddToCartAnimation: (addToCartAnimationMethod) {
        runAddToCartAnimation = addToCartAnimationMethod;
      },
      dragAnimation: const DragToCartAnimationOptions(
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
      ),
      child: Scaffold(
        // App bar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const AppNameWidget(),
          actions: [
            SafeArea(
              child: AddToCartIcon(
                badgeOptions: BadgeOptions(
                  backgroundColor: CustomColors.customContrastColor,
                ),
                key: globalKeyCartItems,
                icon: Icon(
                  Icons.shopping_cart,
                  color: CustomColors.customSwatchColor,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            // Campo de pesquisa
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Pesquise aqui...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColors.customContrastColor,
                    size: 21,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      )),
                ),
              ),
            ),

            // Filtro de categorias
            Container(
              padding: const EdgeInsets.only(left: 25),
              height: 40,
              child: !_homeController.isLoading.value
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => CategoryTile(
                        onPressed: () {
                          setState(() {
                            selectedCategory =
                                _homeController.categories[index].title;
                          });
                        },
                        category: _homeController.categories[index].title,
                        isSelected: _homeController.categories[index].title ==
                            selectedCategory,
                      ),
                      separatorBuilder: (_, index) => const SizedBox(width: 10),
                      itemCount: _homeController.categories.length,
                    )
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        10,
                        (index) => Container(
                          margin: const EdgeInsets.only(right: 12),
                          alignment: Alignment.center,
                          child: CustomShimmer(
                            height: 20,
                            width: 80,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
            ),

            // Grid
            Expanded(
              child: !_homeController.isLoading.value
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                      ),
                      itemCount: app_data.items.length,
                      itemBuilder: (_, index) {
                        return ItemTile(
                          item: app_data.items[index],
                          cartAnimationMethod: itemSelectedCartAnimations,
                        );
                      },
                    )
                  : GridView.count(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                      children: List.generate(
                        10,
                        (index) => CustomShimmer(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          borderRadius: BorderRadius.circular(20),
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
