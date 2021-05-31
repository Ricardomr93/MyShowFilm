import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_round.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/text/textfield_form.dart';
import 'package:myshowfilm/src/utils/util_text.dart' as util;

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserModel user = UserModel();

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          ButtomBack(),
          Stack(
            children: [
              RoundImageProfile(),
              Positioned(
                top: 110,
                left: 110,
                child: ButtomRound(
                  icon: Icons.edit,
                  size: 50,
                  iconSize: 30,
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          TextFieldForm(
            hintText: 'user name',
            validator: (val) => util.validateName(val),
            onSaved: (val) => user.userName = val,
            usertext: true,
            initialValue: _auth.currentUser.displayName,
          ),
          TextFieldForm(
            hintText: 'email',
            validator: (val) => util.validateEmail(val),
            keyboardType: TextInputType.emailAddress,
            onSaved: (val) => user.email = val,
            initialValue: _auth.currentUser.email,
          ),
          TextFieldForm(
            hintText: 'password',
            validator: (val) =>
                util.validatePass(val), //TODO encriptar contraseña
            passtext: true,
            onSaved: (val) => user.pass = val,
            initialValue: '*********',
          ),
          ButtomAuth(
              width: 160, text: Constants.BUTTOM_SAVE, onPressed: () => {}),
          ButtomAuth(text: Constants.BUTTOM_DELETE_AC, onPressed: () => {}),
        ],
      ),
    );
  }
}
