import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/data/models/user.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_text.dart';
import 'package:myshowfilm/src/widgets/logo/logo_aut.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/widgets/text/textfield_form.dart';
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
          hintText: Constants.TEXT_NAME,
          validator: (val) => util.isFieldEmpty(val),
          onSaved: (val) => user.userName = val,
          usertext: true,
        ),
        TextFieldForm(
          hintText: Constants.TEXT_EMAIL,
          validator: (val) => util.validateEmail(val),
          keyboardType: TextInputType.emailAddress,
          onSaved: (val) => user.email = val,
        ),
        TextFieldForm(
          hintText: Constants.TEXT_PASS,
          validator: (val) => util.validatePass(val),
          passtext: true,
          onSaved: (val) => user.pass = val,
        ),
        ButtomAuth(
          text: Constants.BUTTOM_SING,
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
        TextBold(text: Constants.MSJ_COUNT),
        ButtomText(
          text: Constants.MSJ_LOG_IN,
          navigateTo: Constants.ROUTE_LOGIN,
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
