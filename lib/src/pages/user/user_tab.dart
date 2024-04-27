import 'package:flutter/material.dart';
import 'package:greengrocer/src/controllers/auth_controller.dart';
import 'package:greengrocer/src/pages/shared/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;

class UserTab extends StatefulWidget {
  final _authController = AuthController();

  UserTab({super.key});

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  @override
  Widget build(BuildContext context) {
    final phoneFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    final cpfFormatter = MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

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
              widget._authController.signOut();
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
              initialValue: app_data.user.email,
              isReadonly: true,
            ),
            CustomTextField(
              text: 'Nome',
              icon: Icons.person,
              initialValue: app_data.user.name,
              isReadonly: true,
            ),
            CustomTextField(
              text: 'Celular',
              icon: Icons.phone,
              initialValue: app_data.user.phone,
              inputFormatters: [phoneFormatter],
              isReadonly: true,
            ),
            CustomTextField(
              text: 'CPF',
              icon: Icons.file_copy,
              isSecret: true,
              initialValue: app_data.user.cpf,
              inputFormatters: [cpfFormatter],
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
                    )))
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
                    const CustomTextField(
                      text: 'Senha atual',
                      icon: Icons.lock,
                      isSecret: true,
                    ),
                    // Nova senha
                    const CustomTextField(
                      text: 'Nova senha',
                      icon: Icons.lock_outline,
                      isSecret: true,
                    ),
                    // Confirmar nova senha
                    const CustomTextField(
                      text: 'Confirmar nova senha',
                      icon: Icons.lock_outline,
                      isSecret: true,
                    ),
                    // Botão confirmar
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
                            'Atualizar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                    )
                  ],
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
