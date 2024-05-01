import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/results/home_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class HomeRepository {
  final _httpManager = HttpManager();

  List<CategoryModel> categories = [];
  List<ItemModel> items = [];

  Future<HomeResult<CategoryModel>> getCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCategoryList,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult<CategoryModel>.error(
          'Ocorreu um erro ao recuperar as categorias');
    }
  }

  Future<HomeResult<ItemModel>> getProducts(
      {required Map<String, dynamic> body}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getProductList,
      method: HttpMethods.post,
      body: body,
    );

    if (result['result'] != null) {
      List<ItemModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map(ItemModel.fromJson)
          .toList();

      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult<ItemModel>.error(
          'Ocorreu um erro ao recuperar os itens');
    }
  }
}
