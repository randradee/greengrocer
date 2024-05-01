import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/repositories/home_repository.dart';
import 'package:greengrocer/src/results/home_result.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();
  final _utilsServices = UtilsServices();

  bool isLoading = false;

  List<CategoryModel> categories = [];
  CategoryModel? currentCategory;

  @override
  void onInit() {
    super.onInit();

    getCategories();
  }

  setLoading(bool value) {
    isLoading = value;
    update();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    update();
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
}
