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
  RxString searchTitle = ''.obs;

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

    debounce(
      searchTitle,
      (_) => filterByTitle(),
      time: const Duration(milliseconds: 600),
    );

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

  void filterByTitle() {
    // Remover todos os produtos das categorias
    for (CategoryModel category in categories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      categories.removeAt(0);
    } else {
      CategoryModel? c =
          categories.firstWhereOrNull((element) => element.id == '');

      if (c == null) {
        // Criar uma nova categoria com todos os produtos
        final allProductsCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        categories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }

    currentCategory = categories.first;

    update();

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

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;

      if (currentCategory!.title == 'Todos') {
        body.remove('categoryId');
      }
    }

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
