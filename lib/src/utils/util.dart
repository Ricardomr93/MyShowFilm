//clase de utilidades para la aplicación

//comprueba si el email es válido
bool _isMailValid(val) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(val);
}

//comprueba si el campo está vacío
isFieldEmpty(val) => val.isEmpty ? 'the text field must not be empty' : null;

//valida por campo email y devuelve un texto informativo
validateEmail(val) {
  String msj;
  msj = isFieldEmpty(val);
  if (msj == null) {
    if (!_isMailValid(val)) {
      msj = 'the email is not valid';
    }
  }
  return msj;
}

//valida por campo password y devuelve un texto informativo
validatePass(val) {
  String msj;
  msj = isFieldEmpty(val);
  if (msj == null) {
    if (val.length < 6) {
      msj = 'The password must be at least 6 characters';
    }
  }
  return msj;
}
