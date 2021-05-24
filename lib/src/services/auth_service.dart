import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:myshowfilm/src/utils/util_alert.dart' as utilAlert;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

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

signInWithFacebook(context) async {
  utilAlert.showLoadingIndicator(context, 'Trying to login with Facebook');
  // Create an instance of FacebookLogin
  final fb = FacebookLogin();

// Log in
  final res = await fb.logIn(permissions: [
    FacebookPermission.publicProfile,
    FacebookPermission.email,
  ]);

// Check result status
  switch (res.status) {
    case FacebookLoginStatus.success:

      // Send access token to server for validation and auth
      final FacebookAccessToken accessToken = res.accessToken;
      print('Access token: ${accessToken.token}');
      // Get profile data
      final profile = await fb.getUserProfile();
      print('Hello, ${profile.name}! You ID: ${profile.userId}');
      // Get user profile image url
      final imageUrl = await fb.getProfileImageUrl(width: 100);
      print('Your profile image: $imageUrl');
      // Get email (since we request email permission)
      final email = await fb.getUserEmail();
      // But user can decline permission
      if (email != null) print('And your email is $email');
      utilAlert.hideLoadingIndicator(context);
      Navigator.of(context).pushReplacementNamed('home');
      break;
    case FacebookLoginStatus.cancel:
      utilAlert.hideLoadingIndicator(context);
      break;
    case FacebookLoginStatus.error:
      utilAlert.hideLoadingIndicator(context);
      utilAlert.showAlertDialogGeneral(context, 'Error', '${res.error}');
      break;
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
