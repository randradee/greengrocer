import 'package:get/get.dart';
import 'package:greengrocer/src/constants/storage_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/repositories/auth_repository.dart';
import 'package:greengrocer/src/results/auth_result.dart';
import 'package:greengrocer/src/routes/app_routes.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingDialog = false.obs;

  final _authRepository = AuthRepository();
  final _utilsServices = UtilsServices();

  UserModel user = UserModel();

  Future<void> validateToken() async {
    String? token = await _utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await _authRepository.validateToken(token: token);

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProcceedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    // Loading do botão
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    AuthResult result = await _authRepository.signIn(
      email: email,
      password: password,
    );

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndProcceedToBase();
      },
      error: (message) {
        _utilsServices.showToast(msg: message, isError: true);
      },
    );
  }

  Future<void> saveTokenAndProcceedToBase() async {
    await _utilsServices.saveLocalData(
      key: StorageKeys.token,
      data: user.token!,
    );

    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signOut() async {
    // Resetar dados do user
    user = UserModel();

    // Remover token do storage
    _utilsServices.deleteLocalData(key: StorageKeys.token);

    // Redirecionar para tela de login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String cpf,
  }) async {
    var user = UserModel(
      email: email,
      password: password,
      name: name,
      phone: phone,
      cpf: cpf,
    );

    isLoading.value = true;

    AuthResult result = await _authRepository.signUp(user: user);

    isLoading.value = false;

    result.when(
      success: (user) {
        _utilsServices.showToast(msg: 'Cadastro realizado com sucesso');
        Get.offAllNamed(PagesRoutes.signInRoute);
      },
      error: (message) {
        _utilsServices.showToast(msg: message, isError: true);
      },
    );
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // Loading do botão
    isLoading.value = true;

    final result = await _authRepository.updatePassword(
      token: user.token!,
      email: user.email!,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    isLoading.value = false;

    if (result) {
      _utilsServices.showToast(msg: 'Senha atualizada com sucesso');
      signOut();
    } else {
      _utilsServices.showToast(msg: 'Senha atual incorreta', isError: true);
    }
  }

  Future<void> resetPassword({required String email}) async {
    isLoadingDialog.value = true;
    await _authRepository.resetPassword(email: email);
    isLoadingDialog.value = false;
  }
}
