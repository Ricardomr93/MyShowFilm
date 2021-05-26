import 'package:flutter/material.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/services/auth_service.dart' as authService;
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Container(
        child: Column(
      children: [
        Spacer(),
        Container(
            width: 160.0,
            height: 160.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: _auth.currentUser.photoURL != null
                        ? NetworkImage(_auth.currentUser.photoURL)
                        : NetworkImage("https://i.imgur.com/BoN9kdC.png")))),
        SizedBox(
          height: 30,
        ),
        TextBold(text: '${_auth.currentUser.displayName}'),
        SizedBox(
          height: 10,
        ),
        TextBold(text: '${_auth.currentUser.email}'),
        ButtomAuth(
            text: 'LOG OUT', onPressed: () => authService.logOut(context)),
        Spacer(),
      ],
    ));
  }
}
