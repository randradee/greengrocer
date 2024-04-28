import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/shared/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserTab extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  UserTab({super.key});

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do usuário',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        shadowColor: Colors.black,
        elevation: 10,
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          TextEditingController().clear();
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          children: [
            // Formulário
            CustomTextField(
              text: 'Email',
              icon: Icons.mail,
              initialValue: authController.user.email,
              isReadonly: true,
            ),
            CustomTextField(
              text: 'Nome',
              icon: Icons.person,
              initialValue: authController.user.name,
              isReadonly: true,
            ),
            CustomTextField(
              text: 'Celular',
              icon: Icons.phone,
              initialValue: authController.user.phone,
              inputFormatters: [widget.phoneFormatter],
              isReadonly: true,
            ),
            CustomTextField(
              text: 'CPF',
              icon: Icons.file_copy,
              isSecret: true,
              initialValue: authController.user.cpf,
              inputFormatters: [widget.cpfFormatter],
              isReadonly: true,
            ),

            // Botão atualizar senha
            SizedBox(
              height: 50,
              child: OutlinedButton(
                onPressed: () async {
                  await updatePassword();
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  side: const BorderSide(
                    color: Colors.green,
                  ),
                ),
                child: const Text(
                  'Atualizar senha',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Dialog de atualização de senha
  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Colors.black,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: widget._formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Título
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Atualização de senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Senha atual
                      CustomTextField(
                        text: 'Senha atual',
                        controller: widget.currentPasswordController,
                        validator: passwordValidator,
                        icon: Icons.lock,
                        isSecret: true,
                      ),
                      // Nova senha
                      CustomTextField(
                        text: 'Nova senha',
                        controller: widget.newPasswordController,
                        validator: (newPassword) {
                          if (newPassword == null || newPassword.isEmpty) {
                            return 'Confirmação de senha é obrigatória';
                          }
                          if (newPassword ==
                              widget.currentPasswordController.text) {
                            return 'Não pode ser igual à senha anterior';
                          }
                          if (newPassword.length < 8) {
                            return 'A senha deve conter ao menos 8 caracteres';
                          }
                          return null;
                        },
                        icon: Icons.lock_outline,
                        isSecret: true,
                      ),
                      // Confirmar nova senha
                      CustomTextField(
                        text: 'Confirmar nova senha',
                        controller: widget.confirmPasswordController,
                        validator: (confirmPassword) {
                          if (confirmPassword == null ||
                              confirmPassword.isEmpty) {
                            return 'Confirmação de senha é obrigatória';
                          }
                          if (widget.newPasswordController.text !=
                              confirmPassword) {
                            return 'As senhas devem ser iguais';
                          }
                          return null;
                        },
                        icon: Icons.lock_outline,
                        isSecret: true,
                      ),
                      // Botão confirmar
                      SizedBox(
                        height: 45,
                        child: GetX<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              onPressed: !authController.isLoading.value
                                  ? () async {
                                      FocusScope.of(context).unfocus();

                                      if (widget._formKey.currentState!
                                          .validate()) {
                                        await authController.updatePassword(
                                          currentPassword: widget
                                              .currentPasswordController.text,
                                          newPassword:
                                              widget.newPasswordController.text,
                                        );
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: !authController.isLoading.value
                                  ? const Text(
                                      'Atualizar',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const CircularProgressIndicator(),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // Botão de fechar
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
