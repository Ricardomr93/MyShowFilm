import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:myshowfilm/src/utils/util_alert.dart' as utilAlert;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:myshowfilm/src/providers/auth_provider.dart';

final _auth = FirebaseAuth.instance;

signInWithGoogle(context, AuthProvider authProvider) async {
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
      authProvider.mitexto = Constants.PROVIDER_GOOGLE;
      Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
    });
  } catch (e) {
    utilAlert.hideLoadingIndicator(context);
    utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
  }
}

signInWithFacebook(context, AuthProvider authProvider) async {
  try {
    utilAlert.showLoadingIndicator(context, 'Trying to login with Facebook');
    // Trigger the sign-in flow
    final result = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final facebookAuthCredential =
        FacebookAuthProvider.credential('${result.accessToken.token}');
    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(facebookAuthCredential).then((value) {
      utilAlert.hideLoadingIndicator(context);
      authProvider.mitexto = Constants.PROVIDER_FACE;
      Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
    });
  } catch (e) {
    utilAlert.hideLoadingIndicator(context);
    utilAlert.showAlertDialogGeneral(context, 'Error', e.message);
  }
}

singInWithEmailAndPass(
    context, UserModel user, AuthProvider authProvider) async {
  utilAlert.showLoadingIndicator(context, 'Trying to login');
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: user.email, password: user.pass);
    User u = result.user;
    u.updateProfile(displayName: user.userName).then((value) {
      utilAlert.hideLoadingIndicator(context);
      authProvider.mitexto = Constants.PROVIDER_EMAIL;
      Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
    }); //added this line
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

logOut(context, AuthProvider authProvider) async {
  utilAlert.showLoadingIndicator(context, 'User trying log out');
  await _auth.signOut().then((value) {
    utilAlert.hideLoadingIndicator(context);
    authProvider.mitexto = Constants.PROVIDER_LOGOUT;
    Navigator.of(context).pushReplacementNamed(Constants.ROUTE_LOGIN);
  });
}
