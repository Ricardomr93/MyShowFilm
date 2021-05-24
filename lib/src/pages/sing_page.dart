import 'package:flutter/material.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_text.dart';
import 'package:myshowfilm/src/widgets/logo/logo_aut.dart';
import 'package:myshowfilm/src/widgets/progress/circular_progress_wait.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/widgets/text/textfield_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:myshowfilm/src/utils/util_text.dart' as util;
import 'package:myshowfilm/src/utils/util_alert.dart' as utilAlert;

class SingUp extends StatefulWidget {
  SingUp({Key key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
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

  _onPressed() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    //crea un alertDialog para darle feedback al usuario de que está trabajando internamente
    utilAlert.showLoadingIndicator(context, 'Registering user');
    _formKey.currentState.save();
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: user.email, password: user.pass)
          .then((value) {
        utilAlert.hideLoadingIndicator(context);
        utilAlert.showAlertDialogGeneral(context, 'Correct',
            'User successfully registered', () => Navigator.pop(context));
      });
    } on FirebaseAuthException catch (e) {
      //error controlado de duplicidad de email
      if (e.code == 'email-already-in-use') {
        utilAlert.hideLoadingIndicator(context);
        utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
      }
    } catch (e) {
      utilAlert.hideLoadingIndicator(context);
      utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
    }
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
}
