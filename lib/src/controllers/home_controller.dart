import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/repositories/home_repository.dart';
import 'package:greengrocer/src/results/home_result.dart';
import 'package:greengrocer/src/services/utils_services.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();
  final _utilsServices = UtilsServices();

  bool isLoading = false;
  bool isLoadingProducts = false;

  List<CategoryModel> categories = [];
  CategoryModel? currentCategory;

  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) return true;

    return currentCategory!.pagination * itemsPerPage >
        currentCategory!.items.length;
  }

  @override
  void onInit() {
    super.onInit();

    getCategories();
  }

  setLoading(bool value, {bool isLoadingProduct = false}) {
    if (!isLoadingProduct) {
      isLoading = value;
    } else {
      isLoadingProduct = value;
    }

    update();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();

    if (currentCategory!.items.isNotEmpty) return;

    getProducts();
  }

  Future<void> getCategories() async {
    setLoading(true);
    HomeResult<CategoryModel> result = await _homeRepository.getCategories();
    setLoading(false);

    result.when(
      success: (data) {
        categories.assignAll(data);

        if (categories.isEmpty) return;

        selectCategory(categories.first);
      },
      error: (message) {
        _utilsServices.showToast(
          msg: message,
          isError: true,
        );
      },
    );
  }

  Future<void> getProducts({bool canLoad = true}) async {
    if (canLoad) setLoading(true, isLoadingProduct: true);

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      "itemsPerPage": itemsPerPage
    };

    HomeResult<ItemModel> result =
        await _homeRepository.getProducts(body: body);

    setLoading(false, isLoadingProduct: true);

    result.when(
      success: (data) {
        currentCategory!.items.addAll(data);

        if (currentCategory!.items.isEmpty) {
          return;
        }

        update();
      },
      error: (message) {
        _utilsServices.showToast(
          msg: message,
          isError: true,
        );
      },
    );
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getProducts(canLoad: false);
  }
}
