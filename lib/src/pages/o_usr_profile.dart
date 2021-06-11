import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/data/models/user.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshowfilm/src/widgets/progress/progress_simple.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/data/providers/user_provider.dart' as userProv;

class OUsrProfilePage extends StatefulWidget {
  final String idUser;
  const OUsrProfilePage({Key key, @required this.idUser}) : super(key: key);

  @override
  _OUsrProfilePageState createState() => _OUsrProfilePageState();
}

class _OUsrProfilePageState extends State<OUsrProfilePage> {
  bool isFoll;
  bool init;
  CollectionReference users =
      FirebaseFirestore.instance.collection(Constants.COLL_USER);
  UserModel userFriend;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    isFoll = false;
    init = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: users.doc(widget.idUser).get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          userFriend = UserModel.fromJson(snapshot.data.data());
          if (init) {
            _isFollowed();
            init = false;
          }
          return _detailWidget();
        }
        if (snapshot.hasError) {
          return Center(child: Text('error'));
        }
        return ProgressSimple();
      },
    );
  }

  _detailWidget() {
    return Scaffold(
      body: Column(
        children: [
          ButtomBack(),
          SizedBox(
            height: 100,
          ),
          RoundImageProfile(
              size: Constants.SIZE_PROFILE,
              image: userFriend.avatar == null
                  ? NetworkImage(Constants.IMAGE_PRED)
                  : NetworkImage(userFriend.avatar)),
          SizedBox(
            height: 10,
          ),
          Text(
            userFriend.userName,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            userFriend.email,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          ButtomAuth(
            text: isFoll ? Constants.BUTTOM_UNFOLLOW : Constants.BUTTOM_FOLLOW,
            width: 140,
            onPressed: () => {refresh()},
          )
        ],
      ),
    );
  }

  void refresh() {
    _pressed();
    setState(() {
      isFoll = !isFoll;
    });
  }

  Future<void> _pressed() async {
    if (isFoll) {
      await userProv.unfollowUser(_auth.currentUser.uid, widget.idUser);
    } else {
      await userProv.followUser(_auth.currentUser.uid, widget.idUser);
    }
  }

  _isFollowed() {
    if (userFriend.followers.length > 0) {
      if (userFriend.followers.contains(_auth.currentUser.uid)) {
        isFoll = true;
      }
    } else {
      isFoll = false;
    }
  }
}
