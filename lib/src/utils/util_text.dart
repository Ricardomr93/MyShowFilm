//clase de utilidades para la aplicación

//comprueba si el email es válido
bool _isMailValid(String val) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(val);
}

//comprueba si el campo está vacío
isFieldEmpty(String val) => val.isEmpty ? 'Text field must not be empty' : null;

//valida por campo email y devuelve un texto informativo
validateEmail(String val) {
  String msj;
  msj = isFieldEmpty(val);
  if (msj == null) {
    if (!_isMailValid(val)) {
      msj = 'Email is not valid';
    }
  }
  return msj;
}

validateName(String val) {
  String msj;
  msj = isFieldEmpty(val);
  if (msj == null) {
    if (val.trim().contains(' ')) {
      msj = 'Username contains spaces';
    }
  }
  return msj;
}

//valida por campo password y devuelve un texto informativo
validatePass(String val) {
  String msj;
  msj = isFieldEmpty(val);
  if (msj == null) {
    if (val.length < 6) {
      msj = 'Password must be at least 6 characters';
    }
  }
  return msj;
}
