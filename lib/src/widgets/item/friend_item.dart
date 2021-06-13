import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/data/models/user.dart';
import 'package:myshowfilm/src/pages/o_usr_profile.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/progress/progress_simple.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendItem extends StatefulWidget {
  final String idUser;
  const FriendItem({Key key, @required this.idUser}) : super(key: key);

  @override
  _FriendItemState createState() => _FriendItemState();
}

class _FriendItemState extends State<FriendItem> {
  UserModel user;
  CollectionReference users =
      FirebaseFirestore.instance.collection(Constants.COLL_USER);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: users.doc(widget.idUser).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          user = UserModel.fromJson(snapshot.data.data());
          return _itemFriend();
        }
        if (snapshot.hasError) {
          return Center(child: Text('error'));
        }
        return ProgressSimple();
      },
    );
  }

  _itemFriend() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OUsrProfilePage(
                    idUser: widget.idUser,
                  )),
        )
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundImageProfile(
                image: user.avatar == null
                    ? NetworkImage(Constants.IMAGE_PRED)
                    : NetworkImage(user.avatar),
                size: 70),
            SizedBox(
              height: 10,
            ),
            TextBold(
              text: user.userName,
              fontSize: 12,
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
