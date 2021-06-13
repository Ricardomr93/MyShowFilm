import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/data/models/user.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_round.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_text.dart';
import 'package:myshowfilm/src/widgets/logo/logo_aut.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/widgets/text/textfield_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myshowfilm/src/utils/util_text.dart' as util;
import 'package:myshowfilm/src/services/auth_service.dart' as authService;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //  _formKey and _autoValidate
  final _formKey = GlobalKey<FormState>();
  UserModel user = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: _ui(),
          ),
        ));
  }

  Widget _ui() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LogoAut(),
          TextFieldForm(
            hintText: Constants.TEXT_EMAIL,
            validator: (val) => util.validateEmail(val),
            keyboardType: TextInputType.emailAddress,
            onSaved: (val) => user.email = val,
          ),
          TextFieldForm(
            hintText: Constants.TEXT_PASS,
            passtext: true,
            validator: (val) => util.validatePass(val),
            onSaved: (val) => user.pass = val,
          ),
          ButtomAuth(
            text: Constants.BUTTOM_LOGIN,
            onPressed: () => _onPressed(),
          ),
          _noAccount(),
        ],
      ),
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
          child: TextBold(text: Constants.MSJ_OR),
        ),
        Text(
          Constants.MSJ_SING_USING,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.accentColor,
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
          padding: const EdgeInsets.all(15),
          child: ButtomRound(
            icon: FontAwesomeIcons.google,
            onPressed: () => authService.signInWithGoogle(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: ButtomRound(
            icon: FontAwesomeIcons.facebookF,
            onPressed: () => authService.signInWithFacebook(context),
          ),
        ),
      ],
    );
  }

  ///widget con un botón de solo texto para
  ///navegar al login
  Widget _singIN() {
    return Row(
      children: [
        TextBold(text: Constants.MSJ_NO_COUNT),
        ButtomText(
          text: Constants.MSJ_SING_UP,
          navigateTo: Constants.ROUTE_SING,
        ),
      ],
    );
  }

  //evento al pulsar el botón de login
  _onPressed() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    authService.singInWithEmailAndPass(context, user);
  }
}
