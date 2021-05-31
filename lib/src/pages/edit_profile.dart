import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_round.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/simple_dialog.dart';
import 'package:myshowfilm/src/widgets/text/textfield_form.dart';
import 'package:myshowfilm/src/utils/util_text.dart' as util;
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserModel user = UserModel();
  File _image;
  final picker = ImagePicker();

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
              RoundImageProfile(
                image: _image != null
                    ? FileImage(_image)
                    : _auth.currentUser.photoURL == null
                        ? NetworkImage(Constants.IMAGE_PRED)
                        : NetworkImage('${_auth.currentUser.photoURL}'),
              ),
              Positioned(
                top: 110,
                left: 110,
                child: ButtomRound(
                  onPressed: () => getImage(),
                  icon: Icons.edit,
                  size: 50,
                  iconSize: 30,
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          TextFieldForm(
            hintText: Constants.TEXT_NAME,
            validator: (val) => util.validateName(val),
            onSaved: (val) => user.userName = val,
            usertext: true,
            initialValue: _auth.currentUser.displayName,
          ),
          TextFieldForm(
            hintText: Constants.TEXT_EMAIL,
            validator: (val) => util.validateEmail(val),
            keyboardType: TextInputType.emailAddress,
            onSaved: (val) => user.email = val,
            initialValue: _auth.currentUser.email,
          ),
          TextFieldForm(
            hintText: Constants.TEXT_PASS,
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

  getImage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Select your device'),
            children: [
              SimpleDialogItem(
                icon: Icons.collections,
                text: 'Gallery',
                onPressed: () => _toGallery(),
              ),
              SimpleDialogItem(
                icon: Icons.camera_alt,
                text: 'Camera',
                onPressed: () => _toCamera(),
              ),
            ],
          );
        });
  }

  _toCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.pop(context);
      }
    });
  }

  _toGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.pop(context);
      }
    });
  }
}
