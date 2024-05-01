import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/home_controller.dart';
import 'package:greengrocer/src/pages/home/components/category_tile.dart';
import 'package:greengrocer/src/pages/home/components/item_tile.dart';
import 'package:greengrocer/src/pages/shared/app_name_widget.dart';
import 'package:greengrocer/src/pages/shared/custom_shimmer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var globalKeyCartItems = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

  final searchFieldController = TextEditingController();

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
              GetBuilder<HomeController>(
                builder: (homeController) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      controller: searchFieldController,
                      onChanged: (value) {
                        homeController.searchTitle.value = value;
                      },
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
                        suffixIcon: homeController.searchTitle.value.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  searchFieldController.clear();
                                  homeController.searchTitle.value =
                                      searchFieldController.text;
                                  FocusScope.of(context).unfocus();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: CustomColors.customContrastColor,
                                  size: 21,
                                ),
                              )
                            : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            )),
                      ),
                    ),
                  );
                },
              ),

              // Filtro de categorias
              GetBuilder<HomeController>(
                builder: (homeController) {
                  return Container(
                    padding: const EdgeInsets.only(left: 25),
                    height: 40,
                    child: !homeController.isLoading
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => CategoryTile(
                              onPressed: () {
                                homeController.selectCategory(
                                    homeController.categories[index]);
                              },
                              category: homeController.categories[index].title,
                              isSelected: homeController.categories[index] ==
                                  homeController.currentCategory,
                            ),
                            separatorBuilder: (_, index) =>
                                const SizedBox(width: 10),
                            itemCount: homeController.categories.length,
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
                  );
                },
              ),

              // Grid de produtos
              GetBuilder<HomeController>(builder: (homeController) {
                return Expanded(
                  child: !homeController.isLoading
                      ? Visibility(
                          visible: (homeController.currentCategory?.items ?? [])
                              .isNotEmpty,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 40,
                                color: CustomColors.customContrastColor,
                              ),
                              const Text('Não há items para apresentar'),
                            ],
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 11.5,
                            ),
                            itemCount:
                                homeController.currentCategory!.items.length,
                            itemBuilder: (_, index) {
                              if (((index + 1) ==
                                      homeController
                                          .currentCategory!.items.length) &&
                                  !homeController.isLastPage) {
                                homeController.loadMoreProducts();
                              }

                              return ItemTile(
                                item: homeController
                                    .currentCategory!.items[index],
                                cartAnimationMethod: itemSelectedCartAnimations,
                              );
                            },
                          ),
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
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
