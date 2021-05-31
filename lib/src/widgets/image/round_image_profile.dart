import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class RoundImageProfile extends StatelessWidget {
  const RoundImageProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Container(
        width: 160.0,
        height: 160.0,
        decoration: BoxDecoration(
            border: Border.all(width: 3.5, color: MyColors.whiteGrey),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: _auth.currentUser.photoURL != null
                    ? NetworkImage(_auth.currentUser.photoURL)
                    : NetworkImage(Constants.IMAGE_PRED))));
  }
}
