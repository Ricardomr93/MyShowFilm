import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/services/auth_service.dart' as authService;
import 'package:myshowfilm/src/widgets/text/separator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 160.0,
              height: 160.0,
              decoration: BoxDecoration(
                  border: Border.all(width: 3.5, color: MyColors.whiteGrey),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: _auth.currentUser.photoURL != null
                          ? NetworkImage(_auth.currentUser.photoURL)
                          : NetworkImage("https://i.imgur.com/BoN9kdC.png")))),
          SizedBox(
            height: 10,
          ),
          Text(
            '${_auth.currentUser.displayName}',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${_auth.currentUser.email}',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MySeparator(
            text: Constants.LABEL_EDIT_PROFILE,
            icon: FontAwesomeIcons.edit,
          ),
          MySeparator(
            text: Constants.LABEL_FRIENDS,
            icon: FontAwesomeIcons.userFriends,
          ),
          MySeparator(
              text: Constants.LABEL_LOGOUT,
              icon: Icons.logout,
              size: 25.0,
              onPressed: () => authService.logOut(context)),
          /*ButtomAuth(
              text: 'LOG OUT', onPressed: () => authService.logOut(context)),*/
        ],
      ),
    );
  }
}
