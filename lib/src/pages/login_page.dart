import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_aut.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_round.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_text.dart';
import 'package:myshowfilm/src/widgets/logo/logo_aut.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/widgets/text/textfield_general.dart';
import 'package:myshowfilm/src/utils/util.dart' as util;

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //  _formKey and _autoValidate
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Form(
              key: _formKey,
              child: _ui(),
            ),
          ),
        ));
  }

  Widget _ui() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LogoAut(),
        TextFieldGeneral(
          hintText: 'email', //TODO onSaved
          validator: (val) => util.validateEmail(val),
        ),
        TextFieldGeneral(
          hintText: 'password',
          passtext: true,
          validator: (val) => util.validatePass(val),
        ),
        ButtomAut(
          text: 'LOGIN',
          forKey: _formKey,
          onPressed: () => _onPressed(),
        ),
        _noAccount(),
      ],
    );
  }

  Widget _noAccount() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _singIN(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: TextBold(text: 'OR'),
        ),
        Text(
          'Sing in using',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: myTheme.accentColor,
              fontSize: 15),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: _social(),
        ),
      ],
    ));
  }

  Widget _social() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: ButtomRound(image: 'assets/img/social/google.png'),
        ),
        ButtomRound(image: 'assets/img/social/twitter.png'),
      ],
    );
  }

  Widget _singIN() {
    return Row(
      children: [
        TextBold(text: 'Do you no hace account? '),
        ButtomText(
          text: 'Sing up',
          navigateTo: 'sing',
        ),
      ],
    );
  }

  _onPressed() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }
}
