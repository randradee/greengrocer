import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool shouldLogin = false.obs;
  RxBool wrongEmailOrPassword = false.obs;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    print(wrongEmailOrPassword.value);

    if (email == 'login@email.com' && password == 'teste123') {
      shouldLogin.value = true;
    } else {
      wrongEmailOrPassword.value = true;
    }
  }
}
