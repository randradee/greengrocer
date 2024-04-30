import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/shared/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final emailController = TextEditingController();

  ForgotPasswordDialog({
    super.key,
    required String email,
  }) {
    emailController.text = email;
  }

  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Título
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Center(
                    child: Text(
                      'Recuperação de senha',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Texto de hint
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      'Digite o email para recuperar a senha',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                // Campo de email
                CustomTextField(
                  formFieldKey: _formFieldKey,
                  text: 'Email',
                  controller: emailController,
                  icon: Icons.email,
                  validator: emailValidator,
                ),
                // Botão Recuperar
                SizedBox(
                  height: 45,
                  child: GetX<AuthController>(
                    builder: (authController) {
                      return ElevatedButton(
                        onPressed: !authController.isLoadingDialog.value
                            ? () async {
                                FocusScope.of(context).unfocus();
                                if (_formFieldKey.currentState!.validate()) {
                                  await authController.resetPassword(
                                      email: emailController.text);
                                  Get.back(result: true);
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: !authController.isLoadingDialog.value
                            ? const Text(
                                'Recuperar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              )
                            : const CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Botão fechar
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
