import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/repositories/home_repository.dart';
import 'package:greengrocer/src/results/home_result.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class HomeController extends GetxController {
  final _homeRepository = HomeRepository();
  final _utilsServices = UtilsServices();

  RxBool isLoading = false.obs;

  List<CategoryModel> categories = [];

  @override
  onInit() {
    super.onInit();

    getCategories();
  }

  Future<void> getCategories() async {
    isLoading.value = true;
    HomeResult<CategoryModel> result = await _homeRepository.getCategories();
    isLoading.value = false;

    result.when(
      success: (data) {
        categories.assignAll(data);

        print(categories);
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
