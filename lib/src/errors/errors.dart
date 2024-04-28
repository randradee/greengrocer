class Errors {
  String authErrorsString(String? code) {
    switch (code) {
      case 'INVALID_CREDENTIALS':
        return 'Email e/ou senha incorreto(s)';
      case 'Invalid session token':
        return 'Token inválido';
      case 'INVALID_FULLNAME':
        return 'Ocorreu um erro ao cadastrar usuário: Nome inválido';
      case 'INVALID_PHONE':
        return 'Ocorreu um erro ao cadastrar usuário: Celular inválido';
      case 'INVALID_CPF':
        return 'Ocorreu um erro ao cadastrar usuário: CPF inválido';
      case 'Account already exists for this username.':
        return 'Já existe uma conta criada com este email';

      default:
        return 'Erro indefinido';
    }
  }
}
