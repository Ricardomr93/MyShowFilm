import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/data/models/user.dart';
import 'package:myshowfilm/src/pages/o_usr_profile.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/progress/progress_simple.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentUser extends StatefulWidget {
  final String msjText;
  final String idUser;

  const CommentUser({Key key, @required this.msjText, @required this.idUser})
      : super(key: key);

  @override
  _CommentUserState createState() => _CommentUserState();
}

class _CommentUserState extends State<CommentUser> {
  CollectionReference users =
      FirebaseFirestore.instance.collection(Constants.COLL_USER);
  final _auth = FirebaseAuth.instance;
  UserModel user;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: users.doc(widget.idUser).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          user = UserModel.fromJson(snapshot.data.data());
          return _comment(snapshot, context);
        }
        if (snapshot.hasError) {
          return Center(child: Text('error'));
        }
        return ProgressSimple();
      },
    );
  }

  _comment(snapshot, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.idUser != _auth.currentUser.uid
                ? () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OUsrProfilePage(
                                  idUser: widget.idUser,
                                )),
                      )
                    }
                : null,
            child: RoundImageProfile(
              size: Constants.SIZE_ICON_COMENT,
              image: NetworkImage('${user.avatar}'),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(text: '${user.userName}'),
                  SizedBox(height: 5),
                  Text(widget.msjText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
