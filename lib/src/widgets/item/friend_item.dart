import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundImageProfile(
              image: NetworkImage(Constants.IMAGE_PRED), size: 70),
          SizedBox(
            height: 10,
          ),
          TextBold(
            text: 'Amigo cenmenten',
            fontSize: 12,
          )
        ],
      ),
    );
  }
}
