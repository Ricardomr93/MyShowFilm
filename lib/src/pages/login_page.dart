import 'package:flutter/material.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_round.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_text.dart';
import 'package:myshowfilm/src/widgets/logo/logo_aut.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/widgets/text/textfield_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/utils/util_text.dart' as util;
import 'package:myshowfilm/src/utils/util_alert.dart' as utilAlert;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key})
      : super(
          key: key,
        );

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //  _formKey and _autoValidate
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  UserModel user = UserModel();

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
        TextFieldForm(
          hintText: 'email',
          validator: (val) => util.validateEmail(val),
          keyboardType: TextInputType.emailAddress,
          onSaved: (val) => user.email = val,
        ),
        TextFieldForm(
          hintText: 'password',
          passtext: true,
          validator: (val) => util.validatePass(val),
          onSaved: (val) => user.pass = val,
        ),
        ButtomAuth(
          text: 'LOGIN',
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

  //evento al pulsar el botón de login
  _onPressed() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    utilAlert.showLoadingIndicator(context, 'User trying to login');
    _formKey.currentState.save();
    try {
      await _auth
          .signInWithEmailAndPassword(email: user.email, password: user.pass)
          .then((value) {
        utilAlert.hideLoadingIndicator(context);
        Navigator.of(context).pushReplacementNamed('home');
      });
    } on FirebaseAuthException catch (e) {
      //error controlado de email o contraseñas no correctas
      if (e.code == 'user-not-found') {
        utilAlert.hideLoadingIndicator(context);
        utilAlert.showAlertDialogGeneral(
            context, 'Error', 'The email or password isn\'t correct');
      }
      if (e.code == 'wrong-password') {
        utilAlert.hideLoadingIndicator(context);
        utilAlert.showAlertDialogGeneral(
            context, 'Error', 'The email or password isn\'t correct');
      } else {
        utilAlert.hideLoadingIndicator(context);
        utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
      }
    } catch (e) {
      utilAlert.hideLoadingIndicator(context);
      utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
    }
  }
}
