import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        "Content-Type": "application/json",
        "X-Parse-Application-Id": "g1Oui3JqxnY4S1ykpQWHwEKGOe0dRYCPvPF4iykc",
        "X-Parse-REST-API-Key": "rFBKU8tk0m5ZlKES2CGieOaoYz6TgKxVMv8jRIsN",
      });

    var dio = Dio();

    try {
      Response response = await dio.request(
        url,
        data: body,
        options: Options(
          method: method,
          headers: defaultHeaders,
        ),
      );

      return response.data;
    } on DioException catch (error) {
      return error.response?.data ?? {};
    } catch (error) {
      return {};
    }
  }
}
