import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:myshowfilm/src/providers/share_prefs.dart';
import 'package:myshowfilm/src/providers/user_provider.dart' as userProv;
import 'package:myshowfilm/src/utils/util_alert.dart' as utilAlert;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:myshowfilm/src/utils/util_text.dart' as util;

final _auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();
signInWithGoogle(context) async {
  try {
    utilAlert.showLoadingIndicator(context, Constants.TRY_LOGIN_G);
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential).then((value) {
      userProv.addUserAuth(_auth);
      utilAlert.hideLoadingIndicator(context);
      SharePrefs.instance.provider = (Constants.PROVIDER_GOOGLE);
      Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
    });
  } catch (e) {
    utilAlert.hideLoadingIndicator(context);
    _errorAlert(context, e.message);
  }
}

signInWithFacebook(context) async {
  try {
    utilAlert.showLoadingIndicator(context, Constants.TRY_LOGIN_F);
    // Trigger the sign-in flow
    final result = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final facebookAuthCredential =
        FacebookAuthProvider.credential('${result.accessToken.token}');
    // Once signed in, return the UserCredential

    await _auth.signInWithCredential(facebookAuthCredential).then((value) {
      userProv.addUserAuth(_auth);
      utilAlert.hideLoadingIndicator(context);
      SharePrefs.instance.provider = (Constants.PROVIDER_FACE);
      Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
    });
    utilAlert.hideLoadingIndicator(context);
  } catch (e) {
    utilAlert.hideLoadingIndicator(context);
    _errorAlert(context, e.message);
  }
}

singInWithEmailAndPass(context, UserModel user) async {
  utilAlert.showLoadingIndicator(context, Constants.TRY_LOGIN);
  try {
    await _auth
        .signInWithEmailAndPassword(
            email: user.email, password: util.sha256Password(user.pass))
        .then((value) {
      utilAlert.hideLoadingIndicator(context);
      SharePrefs.instance.provider = (Constants.PROVIDER_EMAIL);
      Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
    }); //added this line
  } on FirebaseAuthException catch (e) {
    //error controlado de email o contraseñas no correctas
    if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      _errorAlert(context, Constants.EM_OR_PAS_NO);
    } else {
      _errorAlert(context, e.message);
    }
  } catch (e) {
    _errorAlert(context, e.message);
  }
}

createUserWithEmailAndPassword(context, UserModel user) async {
  user.pass = util.sha256Password(user.pass); //resume la constraseña
  //crea un alertDialog para darle feedback al usuario de que está trabajando internamente
  utilAlert.showLoadingIndicator(context, Constants.TRY_SING);
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: user.email, password: user.pass);
    User u = result.user;
    u.updateProfile(displayName: user.userName).then((value) {
      utilAlert.hideLoadingIndicator(context);
      utilAlert.showAlertDialogGeneral(context, 'Registro',
          'Registrado correctamente', () => Navigator.pop(context));
    });
    user.idUser = _auth.currentUser.uid;
    userProv.addUser(user);
  } on FirebaseAuthException catch (e) {
    //error controlado de duplicidad de email
    if (e.code == 'email-already-in-use') {
      _errorAlert(context, e.message);
    } else {
      _errorAlert(context, e.message);
    }
  } catch (e) {
    utilAlert.hideLoadingIndicator(context);
    _errorAlert(context, e.message);
  }
}

Future<void> updateProfile(context, UserModel user) async {
  try {
    if (user.pass.isNotEmpty) {
      _auth.currentUser
          .updatePassword(util.sha256Password(user.pass))
          .then((value) => {
                if (_auth.currentUser.email ==
                    user.email) //evita salirse si se tiene que modificar el email
                  {_closeCircAndNav(context, user)}
              });
    }
    if (_auth.currentUser.email != user.email) {
      _auth.currentUser
          .updateEmail(user.email)
          .then((value) => _closeCircAndNav(context, user));
    }
    if (user.avatar == null) {
      _auth.currentUser
          .updateProfile(displayName: user.userName)
          .then((value) => _closeCircAndNav(context, user));
    } else {
      _auth.currentUser
          .updateProfile(displayName: user.userName, photoURL: user.avatar)
          .then((value) => _closeCircAndNav(context, user));
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      _errorAlert(context, Constants.REQUIRE_LOGIN);
    }
  }
}

logOut(context) async {
  //solo entra si el provider es google
  if (SharePrefs.instance.provider == Constants.PROVIDER_GOOGLE) {
    await googleSignIn.disconnect();
  }
  await _auth.signOut().then((value) {
    Navigator.of(context).pushReplacementNamed(Constants.ROUTE_LOGIN);
  });
}

_errorAlert(context, val) {
  utilAlert.hideLoadingIndicator(context);
  utilAlert.showAlertDialogGeneral(context, Constants.ERROR, val);
}

_closeCircAndNav(context, user) {
  userProv.updateUser(_auth, user.pass == null ? null : user.pass);
  utilAlert.hideLoadingIndicator(context);
  Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
}
