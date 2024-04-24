class Errors {
  String authErrorsString(String? code) {
    switch (code) {
      case 'INVALID_CREDENTIALS':
        return 'Email e/ou senha ';
      default:
        return 'Erro indefinido';
    }
  }
}
