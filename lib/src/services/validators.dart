import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email é obrigatório';
  }
  if (!email.isEmail) {
    return 'Digite um email válido';
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Senha é obrigatória';
  }
  if (password.length < 8) {
    return 'A senha deve conter ao menos 8 caracteres';
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Nome é obrigatório';
  }
  if (!name.removeAllWhitespace.isAlphabetOnly) {
    return 'Não é permitido números ou caracteres especiais';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'CPF é obrigatório';
  }
  // Removido para testes em release
  // if (!cpf.isCpf) {
  //   return 'Digite um CPF válido';
  // }
  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return null;
  }

  if (phone.length < 14 || !phone.isPhoneNumber) {
    return 'Digite um número válido';
  }
  return null;
}
