//clase de utilidades para la aplicación

//comprueba si el email es válido
import 'dart:convert';

import 'package:myshowfilm/src/core/constants.dart';
import 'package:crypto/crypto.dart';

bool _isMailValid(String val) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(val);
}

//comprueba si el campo está vacío
isFieldEmpty(String val) => val.isEmpty ? Constants.MSJ_TXT_EMPTY : null;

//valida por campo email y devuelve un texto informativo
validateEmail(String val) {
  String msj;
  msj = isFieldEmpty(val);
  if (msj == null) {
    if (!_isMailValid(val)) {
      msj = Constants.EMAIL_NO_VALID;
    }
  }
  return msj;
}

validateName(String val) {
  String msj;
  msj = isFieldEmpty(val);
  if (msj == null) {
    if (val.trim().contains(' ')) {
      msj = Constants.NAME_SPACE;
    }
  }
  return msj;
}

validatePassProfile(String val) {
  String msj;
  if (val.isNotEmpty && val.length < 6) {
    msj = Constants.PASS_WEAK;
  }
  return msj;
}

//valida por campo password y devuelve un texto informativo
validatePass(String val) {
  String msj;
  msj = isFieldEmpty(val);
  if (msj == null) {
    if (val.length < 6) {
      msj = Constants.PASS_WEAK;
    }
  }
  return msj;
}

String sha256Password(String pass) {
  var bytes = utf8.encode(pass);
  var digest = sha256.convert(bytes);
  return digest.toString();
}
