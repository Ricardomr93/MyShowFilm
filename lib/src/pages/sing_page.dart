import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_aut.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_text.dart';
import 'package:myshowfilm/src/widgets/logo_aut.dart';
import 'package:myshowfilm/src/widgets/text_bold.dart';
import 'package:myshowfilm/src/widgets/textfield_general.dart';

class SingUp extends StatefulWidget {
  SingUp({Key key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          ButtomBack(),
          LogoAut(),
          TextFieldGeneral(
            hintText: 'user name',
          ),
          TextFieldGeneral(
            hintText: 'email',
          ),
          TextFieldGeneral(
            hintText: 'password',
            passtext: true,
          ),
          TextFieldGeneral(
            hintText: 'confirm password',
            passtext: true,
          ),
          ButtomAut(text: 'SING UP'),
          _haveAccount(),
        ],
      ),
    );
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
