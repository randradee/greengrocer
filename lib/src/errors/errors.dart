class Errors {
  String authErrorsString(String? code) {
    switch (code) {
      case 'INVALID_CREDENTIALS':
        return 'Email e/ou senha incorreto(s)';
      case 'Invalid session token':
        return 'Token inválido';
      case 'Account already exists for this username.':
        return 'Já existe uma conta criada com este email';
      default:
        return 'Erro indefinido';
    }
  }
}
