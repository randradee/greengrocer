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
        "X-Parse-Application-Id": "wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y",
        "X-Parse-REST-API-Key": "2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB",
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
