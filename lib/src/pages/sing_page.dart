import 'package:flutter/material.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_aut.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_text.dart';
import 'package:myshowfilm/src/widgets/logo/logo_aut.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/widgets/text/textfield_general.dart';
import 'package:myshowfilm/src/utils/util.dart' as util;

class SingUp extends StatefulWidget {
  SingUp({Key key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  //  _formKey and _autoValidate
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: _ui(),
        )));
  }

  Widget _ui() {
    return Column(
      children: [
        ButtomBack(),
        LogoAut(),
        TextFieldForm(
          hintText: 'user name',
          validator: (val) => util.isFieldEmpty(val),
        ),
        TextFieldForm(
          hintText: 'email',
          validator: (val) => util.validateEmail(val),
        ),
        TextFieldForm(
          hintText: 'password',
          validator: (val) => util.validatePass(val),
          passtext: true,
        ),
        TextFieldForm(
          hintText: 'confirm password',
          passtext: true,
          validator: (val) => util.validatePass(val),
        ),
        ButtomAut(
          text: 'SING UP',
          onPressed: () => _onPressed(),
        ),
        _haveAccount(),
      ],
    );
  }

  _onPressed() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
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
