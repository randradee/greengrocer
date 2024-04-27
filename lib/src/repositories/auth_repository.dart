import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/errors/errors.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/results/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      method: HttpMethods.post,
      url: Endpoints.signin,
      body: {
        "email": email,
        "password": password,
      },
    );

    if (result['result'] == null) {
      return AuthResult.error(Errors().authErrorsString(result['error']));
    }

    return AuthResult.success(UserModel.fromJson(result['result']));
  }

  Future<AuthResult> signUp({required UserModel user}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    if (result['result'] == null) {
      return AuthResult.error(Errors().authErrorsString(result['error']));
    }

    return AuthResult.success(UserModel.fromJson(result['result']));
  }

  Future<AuthResult> validateToken({required String token}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: HttpMethods.post,
      headers: {
        "X-Parse-Session-Token": token,
      },
    );

    if (result['result'] == null) {
      return AuthResult.error(Errors().authErrorsString(result['error']));
    }

    return AuthResult.success(UserModel.fromJson(result['result']));
  }
}
