import 'package:flutter/material.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_text.dart';
import 'package:myshowfilm/src/widgets/logo/logo_aut.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/widgets/text/textfield_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:myshowfilm/src/services/auth_service.dart' as authService;
import 'package:myshowfilm/src/utils/util_text.dart' as util;

class SingUpPage extends StatefulWidget {
  SingUpPage({Key key}) : super(key: key);

  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  //  _formKey and _autoValidate
  final _formKey = GlobalKey<FormState>();
  //auth
  final _auth = FirebaseAuth.instance;
  UserModel user = UserModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: _ui(),
        )),
      ]),
    );
  }

  Widget _ui() {
    return Column(
      children: [
        ButtomBack(),
        LogoAut(),
        TextFieldForm(
          hintText: 'user name',
          validator: (val) => util.validateName(val),
          onSaved: (val) => user.userName = val,
          usertext: true,
        ),
        TextFieldForm(
          hintText: 'email',
          validator: (val) => util.validateEmail(val),
          keyboardType: TextInputType.emailAddress,
          onSaved: (val) => user.email = val,
        ),
        TextFieldForm(
          hintText: 'password',
          validator: (val) =>
              util.validatePass(val), //TODO encriptar contraseña
          passtext: true,
          onSaved: (val) => user.pass = val,
        ),
        /*TextFieldForm(
          hintText: 'confirm password',
          passtext: true,
          validator: (val) => util.validatePass(val),
          onSaved: (val) => _pass2 = val,
        ),*/ //borrado temporal de la confirmacion del password
        ButtomAuth(
          text: 'SING UP',
          onPressed: () => _onPressed(),
        ),
        _haveAccount(),
      ],
    );
  }

  Widget _haveAccount() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logIn(),
          ],
        ),
      ],
    ));
  }

  Widget _logIn() {
    return Row(
      children: [
        TextBold(text: 'Already have account? '),
        ButtomText(
          text: 'Log in',
          navigateTo: 'login',
        ),
      ],
    );
  }

  //Evento al pulsar el botón de registro
  _onPressed() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    authService.createUserWithEmailAndPassword(context, user);
  }
}
