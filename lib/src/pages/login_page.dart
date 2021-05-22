import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_aut.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_round.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_text.dart';
import 'package:myshowfilm/src/widgets/logo_aut.dart';
import 'package:myshowfilm/src/widgets/text_bold.dart';
import 'package:myshowfilm/src/widgets/textfield_general.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LogoAut(),
            TextFieldGeneral(
              hintText: 'email',
            ),
            TextFieldGeneral(
              hintText: 'password',
              passtext: true,
            ),
            ButtomAut(text: 'LOGIN'),
            _noAccount(),
          ],
        ),
      ),
    );
  }
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
