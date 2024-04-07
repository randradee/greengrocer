import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/shared/custom_text_field.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final phoneFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    final cpfFormatter = MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Scaffold(
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
                          Navigator.of(context).pop();
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
                              style:
                                  TextStyle(fontSize: 40, color: Colors.white),
                            ))),

                    // Formulário
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 40),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(45))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CustomTextField(
                              text: 'Email', icon: Icons.email),
                          const CustomTextField(
                            text: 'Senha',
                            icon: Icons.lock,
                            isSecret: true,
                          ),
                          const CustomTextField(
                              text: 'Nome', icon: Icons.person),
                          CustomTextField(
                              inputFormatters: [phoneFormatter],
                              text: 'Celular',
                              icon: Icons.phone),
                          CustomTextField(
                              inputFormatters: [cpfFormatter],
                              text: 'CPF',
                              icon: Icons.file_copy),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        CustomColors.customSwatchColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                child: const Text(
                                  'Cadastrar usuário',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
