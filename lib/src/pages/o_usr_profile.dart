import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/data/models/user.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';

class OUsrProfilePage extends StatefulWidget {
  const OUsrProfilePage({Key key}) : super(key: key);

  @override
  _OUsrProfilePageState createState() => _OUsrProfilePageState();
}

class _OUsrProfilePageState extends State<OUsrProfilePage> {
  UserModel user = UserModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ButtomBack(),
          SizedBox(
            height: 100,
          ),
          RoundImageProfile(
              size: Constants.SIZE_PROFILE,
              image: user.avatar == null
                  ? NetworkImage(Constants.IMAGE_PRED)
                  : NetworkImage(user.avatar)),
          SizedBox(
            height: 10,
          ),
          Text(
            'user.userName,', // TODO PONER SU NAME
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'user.email,', // TODO PONER SU EMAIL
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          ButtomAuth(
            text: 'Follow', // TODO CAMBIA FOLLOW UNFOLLOW SEGUN LO SIGUES O NO
            width: 140,
            onPressed: () => {},
          )
        ],
      ),
    );
  }
}
