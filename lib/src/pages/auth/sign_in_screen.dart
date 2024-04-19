import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/shared/app_name_widget.dart';
import 'package:greengrocer/src/pages/shared/custom_text_field.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/routes/app_routes.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

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
                          text: 'Email',
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Email é obrigatório';
                            }
                            if (!email.isEmail) {
                              return 'Digite um email válido';
                            }
                            return null;
                          },
                        ),
                        // Senha
                        CustomTextField(
                          icon: Icons.lock,
                          text: 'Senha',
                          isSecret: true,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Senha é obrigatória';
                            }
                            if (password.length < 8) {
                              return 'A senha deve conter ao menos 8 caracteres.';
                            }
                            return null;
                          },
                        ),
                        // Botão entrar
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print('campos válidos');
                                  // Get.offNamed(PagesRoutes.baseRoute);
                                } else {
                                  print('campos não válidos');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      CustomColors.customSwatchColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              child: const Text(
                                'Entrar',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                        ),
                        // Esqueceu a senha?
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Esqueceu a senha?',
                                style: TextStyle(
                                    color: CustomColors.customContrastColor),
                              )),
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
}
