import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/shared/custom_text_field.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final authController = AuthController();
  final utilsServices = UtilsServices();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cpfController = TextEditingController();

  final phoneFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final cpfFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: Scaffold(
        backgroundColor: CustomColors.customSwatchColor,
        body: SingleChildScrollView(
          child: SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  // Botão voltar
                  Positioned(
                    top: 10,
                    left: 10,
                    child: SafeArea(
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                              color: Colors.white, Icons.arrow_back_rounded)),
                    ),
                  ),
                  Column(
                    children: [
                      // Título
                      const Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Cadastro',
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white),
                              ))),

                      // Formulário
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 40),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(45))),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextField(
                                text: 'Email',
                                controller: emailController,
                                icon: Icons.email,
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
                              CustomTextField(
                                text: 'Senha',
                                controller: passwordController,
                                validator: (password) {
                                  if (password == null || password.isEmpty) {
                                    return 'Senha é obrigatória';
                                  }
                                  if (password.length < 8) {
                                    return 'A senha deve conter ao menos 8 caracteres';
                                  }
                                  return null;
                                },
                                icon: Icons.lock,
                                isSecret: true,
                              ),
                              CustomTextField(
                                text: 'Nome',
                                controller: nameController,
                                validator: (name) {
                                  if (name == null || name.isEmpty) {
                                    return 'Nome é obrigatório';
                                  }
                                  if (!name
                                      .removeAllWhitespace.isAlphabetOnly) {
                                    return 'Não é permitido números ou caracteres especiais';
                                  }
                                  return null;
                                },
                                icon: Icons.person,
                              ),
                              CustomTextField(
                                inputFormatters: [phoneFormatter],
                                controller: phoneController,
                                text: 'Celular',
                                icon: Icons.phone,
                              ),
                              CustomTextField(
                                inputFormatters: [cpfFormatter],
                                controller: cpfController,
                                validator: (cpf) {
                                  if (cpf == null || cpf.isEmpty) {
                                    return 'CPF é obrigatório';
                                  }
                                  // Removido para testes
                                  // if (!cpf.isCpf) {
                                  //   return 'Digite um CPF válido';
                                  // }
                                  return null;
                                },
                                text: 'CPF',
                                icon: Icons.file_copy,
                              ),
                              SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();

                                    if (_formKey.currentState!.validate()) {
                                      String email =
                                          emailController.text.trim();
                                      String password =
                                          passwordController.text.trim();
                                      String name = nameController.text.trim();
                                      String phone =
                                          phoneController.text.trim();
                                      String cpf = cpfController.text.trim();

                                      await authController.signUp(
                                        email: email,
                                        password: password,
                                        name: name,
                                        phone: phone,
                                        cpf: cpf,
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
                                  child: const Text(
                                    'Cadastrar usuário',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
