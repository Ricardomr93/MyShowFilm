import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
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
  CollectionReference users =
      FirebaseFirestore.instance.collection(Constants.COLL_USER);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: users.doc(widget.idUser).get(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return _detailWidget(snapshot);
        }
        if (snapshot.hasError) {
          return Center(child: Text('error'));
        }
        return ProgressSimple();
      },
    );
  }

  _detailWidget(snapshot) {
    return Scaffold(
      body: Column(
        children: [
          ButtomBack(),
          SizedBox(
            height: 100,
          ),
          RoundImageProfile(
              size: Constants.SIZE_PROFILE,
              image: snapshot.data.data()['avatar'] == null
                  ? NetworkImage(Constants.IMAGE_PRED)
                  : NetworkImage('${snapshot.data.data()['avatar']}')),
          SizedBox(
            height: 10,
          ),
          Text(
            '${snapshot.data.data()['userName']}',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${snapshot.data.data()['email']}',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          ButtomAuth(
            text: _isFollowed(snapshot, _auth.currentUser.uid)
                ? Constants.BUTTOM_UNFOLLOW
                : Constants.BUTTOM_FOLLOW,
            width: 140,
            onPressed: () => {_pressed(snapshot)},
          )
        ],
      ),
    );
  }

  _pressed(snapshot) {
    //TODO ARREGLAR SETSTATE
    _isFollowed(snapshot, _auth.currentUser.uid)
        ? userProv
            .unfollowUser(_auth.currentUser.uid, widget.idUser)
            .then((value) => setState(() {}))
        : userProv
            .followUser(_auth.currentUser.uid, widget.idUser)
            .then((value) => setState(() {}));
  }

  bool _isFollowed(snapshot, idUser) {
    bool isFoll = false;
    if (snapshot.data.data()[Constants.USER_FOLLOWER] != null) {
      if (snapshot.data.data()[Constants.USER_FOLLOWER].contains(idUser)) {
        isFoll = true;
      }
    }
    return isFoll;
  }
}
