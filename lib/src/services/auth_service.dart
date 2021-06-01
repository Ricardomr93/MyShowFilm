import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:myshowfilm/src/providers/share_prefs.dart';
import 'package:myshowfilm/src/utils/util_alert.dart' as utilAlert;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

final _auth = FirebaseAuth.instance;
signInWithGoogle(
  context,
) async {
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
      SharePrefs.instance.provider = (Constants.PROVIDER_GOOGLE);
      Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
    });
  } catch (e) {
    _errorAlert(context, e.message);
  }
}

signInWithFacebook(context) async {
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
      SharePrefs.instance.provider = (Constants.PROVIDER_FACE);
      Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
    });
  } catch (e) {
    _errorAlert(context, e.message);
  }
}

singInWithEmailAndPass(context, UserModel user) async {
  utilAlert.showLoadingIndicator(context, 'Trying to login');
  try {
    await _auth
        .signInWithEmailAndPassword(email: user.email, password: user.pass)
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
  //crea un alertDialog para darle feedback al usuario de que está trabajando internamente
  utilAlert.showLoadingIndicator(context, 'Trying to register');
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: user.email, password: user.pass);
    User u = result.user;
    u.updateProfile(displayName: user.userName).then((value) {
      utilAlert.hideLoadingIndicator(context);
      utilAlert.showAlertDialogGeneral(context, 'Correct',
          'Successfully registered', () => Navigator.pop(context));
    });
  } on FirebaseAuthException catch (e) {
    //error controlado de duplicidad de email
    if (e.code == 'email-already-in-use') {
      _errorAlert(context, e.message);
    } else {
      _errorAlert(context, e.message);
    }
  } catch (e) {
    _errorAlert(context, e.message);
  }
}

logOut(context) async {
  utilAlert.showLoadingIndicator(context, 'User trying log out');
  await _auth.signOut().then((value) {
    utilAlert.hideLoadingIndicator(context);
    Navigator.of(context).pushReplacementNamed(Constants.ROUTE_LOGIN);
  });
}

Future<void> updateProfile(context, UserModel user) async {
  try {
    if (user.pass.isNotEmpty) {
      _auth.currentUser.updatePassword(user.pass).then((value) => {
            if (_auth.currentUser.email ==
                user.email) //evita salirse si se tiene que modificar el email
              {_closeCircAndNav(context)}
          });
    }
    if (_auth.currentUser.email != user.email) {
      _auth.currentUser
          .updateEmail(user.email)
          .then((value) => _closeCircAndNav(context));
    }
    if (user.avatar == null) {
      _auth.currentUser
          .updateProfile(displayName: user.userName)
          .then((value) => _closeCircAndNav(context));
    } else {
      _auth.currentUser
          .updateProfile(displayName: user.userName, photoURL: user.avatar)
          .then((value) => _closeCircAndNav(context));
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      _errorAlert(context, e.message);
    }
  }
}

_errorAlert(context, val) {
  utilAlert.hideLoadingIndicator(context);
  utilAlert.showAlertDialogGeneral(context, Constants.ERROR, val);
}

_closeCircAndNav(context) {
  utilAlert.hideLoadingIndicator(context);
  Navigator.of(context).pushReplacementNamed(Constants.ROUTE_HOME);
}
