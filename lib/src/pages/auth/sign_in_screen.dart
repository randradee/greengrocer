import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/shared/app_name_widget.dart';
import 'package:greengrocer/src/pages/shared/custom_text_field.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/routes/app_routes.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/services/validators.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final utilsServices = UtilsServices();

  final _formKey = GlobalKey<FormState>();
  final _dialogFormKey = GlobalKey<FormState>();

  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final passwwordResetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          TextEditingController().clear();
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nome do app
                    const AppNameWidget(
                      greenTileColor: Colors.white,
                      textSize: 40,
                    ),
                    // Categorias
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 25),
                        child: AnimatedTextKit(
                            isRepeatingAnimation: true,
                            repeatForever: true,
                            pause: Duration.zero,
                            animatedTexts: [
                              FadeAnimatedText('Frutas'),
                              FadeAnimatedText('Verduras'),
                              FadeAnimatedText('Legumes'),
                              FadeAnimatedText('Carnes'),
                              FadeAnimatedText('Cereais'),
                              FadeAnimatedText('Laticínios'),
                            ]),
                      ),
                    )
                  ],
                )),
                // Formulário
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45))),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Email
                        CustomTextField(
                          icon: Icons.email,
                          controller: loginController,
                          text: 'Email',
                          validator: emailValidator,
                        ),
                        // Senha
                        CustomTextField(
                          icon: Icons.lock,
                          controller: passwordController,
                          text: 'Senha',
                          isSecret: true,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Senha é obrigatória';
                            }
                            if (password.length < 8) {
                              return 'A senha deve conter ao menos 8 caracteres';
                            }
                            return null;
                          },
                        ),
                        // Botão entrar
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 50,
                              child: GetX<AuthController>(
                                builder: (authController) {
                                  return ElevatedButton(
                                    onPressed: authController.isLoading.value
                                        ? null
                                        : () async {
                                            FocusScope.of(context).unfocus();

                                            if (_formKey.currentState!
                                                .validate()) {
                                              String email =
                                                  loginController.text;
                                              String password =
                                                  passwordController.text;

                                              await authController.signIn(
                                                email: email,
                                                password: password,
                                              );
                                            } else {
                                              return;
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          CustomColors.customSwatchColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                    ),
                                    child: authController.isLoading.value
                                        ? CircularProgressIndicator(
                                            color:
                                                CustomColors.customSwatchColor,
                                          )
                                        : const Text(
                                            'Entrar',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        // Esqueceu a senha?
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () async {
                              await resetPassword(context);
                            },
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                  color: CustomColors.customContrastColor),
                            ),
                          ),
                        ),
                        // Divisor
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.withAlpha(90),
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'Ou',
                                  style: TextStyle(
                                      color: Colors.grey.withAlpha(90)),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey.withAlpha(90),
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Botão criar conta
                        SizedBox(
                            height: 50,
                            child: OutlinedButton(
                                onPressed: () {
                                  Get.toNamed(PagesRoutes.signUpRoute);
                                },
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    side: BorderSide(
                                        width: 2,
                                        color: CustomColors.customSwatchColor)),
                                child: Text(
                                  'Criar conta',
                                  style: TextStyle(
                                      color: CustomColors.customSwatchColor,
                                      fontSize: 18),
                                )))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> resetPassword(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Form(
                  key: _dialogFormKey,
                  child: Padding(
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
                          text: 'Email',
                          controller: passwwordResetController,
                          validator: emailValidator,
                          icon: Icons.email,
                        ),
                        // Botão Recuperar
                        SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Recuperar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
            ));
      },
    );
  }
}
