import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/progress/progress_simple.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshowfilm/src/providers/user_provider.dart' as userProv;

class CommentUser extends StatelessWidget {
  final String msjText;
  final String idUser;

  const CommentUser({Key key, @required this.msjText, @required this.idUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection(Constants.COLL_USER);
    return FutureBuilder(
      future: users
          .doc(idUser)
          .get(), //filmProv.getComment(film), //TODO falta para series
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _comment(snapshot);
        }
        if (snapshot.hasError) {
          return Center(child: Text('error'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ProgressSimple();
        }
      },
    );
  }

  _comment(snapshot) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RoundImageProfile(
            size: Constants.SIZE_ICON_COMENT,
            image: NetworkImage('${snapshot.data.data()['avatar']}'),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(text: '${snapshot.data.data()['userName']}'),
                  SizedBox(height: 5),
                  Text(msjText),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
