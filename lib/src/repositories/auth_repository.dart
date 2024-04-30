import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/errors/errors.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/results/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult _handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] == null) {
      return AuthResult.error(Errors().authErrorsString(result['error']));
    }

    return AuthResult.success(UserModel.fromJson(result['result']));
  }

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

    return _handleUserOrError(result);
  }

  Future<AuthResult> signUp({required UserModel user}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    return _handleUserOrError(result);
  }

  Future<AuthResult> validateToken({required String token}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: HttpMethods.post,
      headers: {
        "X-Parse-Session-Token": token,
      },
    );

    return _handleUserOrError(result);
  }

  Future updatePassword({
    required String token,
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.changePassword,
        method: HttpMethods.post,
        headers: {
          "X-Parse-Session-Token": token,
        },
        body: {
          "email": email,
          "currentPassword": currentPassword,
          "newPassword": newPassword,
        });

    return result['error'] == null;
  }

  Future<void> resetPassword({required String email}) async {
    await _httpManager.restRequest(
      url: Endpoints.resetPassword,
      method: HttpMethods.post,
      body: {
        "email": email,
      },
    );
  }
}
