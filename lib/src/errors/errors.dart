class Errors {
  String authErrorsString(String? code) {
    switch (code) {
      case 'INVALID_CREDENTIALS':
        return 'Email e/ou senha incorreto(s)';
      case 'Invalid session token':
        return 'Token inválido';
      default:
        return 'Erro indefinido';
    }
  }
}
