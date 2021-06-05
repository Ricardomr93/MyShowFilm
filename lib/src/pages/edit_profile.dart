import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/services/auth_service.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_round.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/dialog/simple_dialog.dart';
import 'package:myshowfilm/src/widgets/text/textfield_form.dart';
import 'package:myshowfilm/src/utils/util_text.dart' as util;
import 'package:image_picker/image_picker.dart';
import 'package:myshowfilm/src/utils/util_alert.dart' as utilAlert;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserModel user = UserModel();
  PickedFile pickedFile;
  File _image;
  final picker = ImagePicker();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            child: _ui(),
            key: _formKey,
          ),
        ));
  }

  _saveData() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    uploadFile();
  }

  _ui() {
    return Column(
      children: [
        ButtomBack(),
        Stack(
          children: [
            RoundImageProfile(
              size: Constants.SIZE_PROFILE,
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
              util.validatePassProfile(val), //TODO encriptar contraseña
          passtext: true,
          onSaved: (val) => user.pass = val,
        ),
        ButtomAuth(
            width: 160,
            text: Constants.BUTTOM_SAVE,
            onPressed: () => _saveData()),
        ButtomAuth(text: Constants.BUTTOM_DELETE_AC, onPressed: () => {}),
      ],
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
                text: Constants.GALLERY,
                onPressed: () => _toGallery(),
              ),
              SimpleDialogItem(
                icon: Icons.camera_alt,
                text: Constants.CAMERA,
                onPressed: () => _toCamera(),
              ),
            ],
          );
        });
  }

  _toCamera() async {
    pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 30);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.pop(context);
      }
    });
  }

  _toGallery() async {
    pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 30);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.pop(context);
      }
    });
  }

  Future<void> uploadFile() async {
    utilAlert.showLoadingIndicator(context, 'Update user');
    //compreba que no se haya modificado algún campo
    try {
      if (_auth.currentUser.displayName != user.userName ||
          _auth.currentUser.email != user.email ||
          user.pass.isNotEmpty) {
        //si se ha modificado la foto la cambia
        if (pickedFile != null) {
          updateImage();
        } else {
          //no se modifica foto pero si campo
          updateProfile(context, user);
        }
        //solo se ha modificado la imagen
      } else if (pickedFile != null) {
        updateImage();
      } else {
        utilAlert.hideLoadingIndicator(context);
        utilAlert.showAlertDialogGeneral(
            context, Constants.INFO, Constants.SOME_CHANGE);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {}
    }
  }

  updateImage() {
    firebase_storage.FirebaseStorage.instance
        .ref('img/usr/${_auth.currentUser.uid}.jpg')
        .putFile(File(pickedFile.path))
        .whenComplete(() => {
              downImage(user).then(
                () => _closeCircAndNav(),
              ),
            });
  }

  downImage(user) async {
    String url = await firebase_storage.FirebaseStorage.instance
        .ref('img/usr/${_auth.currentUser.uid}.jpg')
        .getDownloadURL();
    user.avatar = url;
    updateProfile(context, user);
  }

  _closeCircAndNav() {
    utilAlert.hideLoadingIndicator(context);
    Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
  }
}
