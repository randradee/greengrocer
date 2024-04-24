import 'package:get/get.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/repositories/auth_repository.dart';
import 'package:greengrocer/src/results/auth_result.dart';

class AuthController extends GetxController {
  final _authRepository = AuthRepository();

  RxBool isLoading = false.obs;
  RxBool shouldLogin = false.obs;
  RxBool wrongEmailOrPassword = false.obs;
  RxBool signUpSuccess = false.obs;
  RxString token = ''.obs;
  RxString errorMessage = ''.obs;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    AuthResult result = await _authRepository.signIn(
      email: email,
      password: password,
    );

    result.when(
      success: (user) {
        shouldLogin.value = true;
      },
      error: (message) {
        wrongEmailOrPassword.value = true;
        errorMessage.value = message;
      },
    );
  }

  Future<void> signUp({required UserModel user}) async {
    AuthResult result = await _authRepository.signUp(user: user);

    result.when(
      success: (user) {
        signUpSuccess.value = true;
        token.value = user.token!;
      },
      error: (message) {
        wrongEmailOrPassword.value = true;
        errorMessage.value = message;
      },
    );
  }
}
