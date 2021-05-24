import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:myshowfilm/src/utils/util_alert.dart' as utilAlert;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

final _auth = FirebaseAuth.instance;

signInWithGoogle(context) async {
  try {
    utilAlert.showLoadingIndicator(context, 'Trying to login with Google');
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential).then((value) {
      utilAlert.hideLoadingIndicator(context);
      Navigator.of(context).pushReplacementNamed('home');
    });
  } catch (e) {
    utilAlert.hideLoadingIndicator(context);
    utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
  }
}

singInWithEmailAndPass(context, UserModel user) async {
  utilAlert.showLoadingIndicator(context, 'Trying to login');
  try {
    await _auth
        .signInWithEmailAndPassword(email: user.email, password: user.pass)
        .then((value) {
      utilAlert.hideLoadingIndicator(context);
      Navigator.of(context).pushReplacementNamed('home');
    });
  } on FirebaseAuthException catch (e) {
    //error controlado de email o contraseñas no correctas
    if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      utilAlert.hideLoadingIndicator(context);
      utilAlert.showAlertDialogGeneral(
          context, 'Error', 'Email or password isn\'t correct');
    } else {
      utilAlert.hideLoadingIndicator(context);
      utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
    }
  } catch (e) {
    utilAlert.hideLoadingIndicator(context);
    utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
  }
}

createUserWithEmailAndPassword(context, UserModel user) async {
  //crea un alertDialog para darle feedback al usuario de que está trabajando internamente
  utilAlert.showLoadingIndicator(context, 'Trying to register');
  try {
    await _auth
        .createUserWithEmailAndPassword(email: user.email, password: user.pass)
        .then((value) {
      utilAlert.hideLoadingIndicator(context);
      utilAlert.showAlertDialogGeneral(context, 'Correct',
          'Successfully registered', () => Navigator.pop(context));
    });
  } on FirebaseAuthException catch (e) {
    //error controlado de duplicidad de email
    if (e.code == 'email-already-in-use') {
      utilAlert.hideLoadingIndicator(context);
      utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
    } else {
      utilAlert.hideLoadingIndicator(context);
      utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
    }
  } catch (e) {
    utilAlert.hideLoadingIndicator(context);
    utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
  }
}
