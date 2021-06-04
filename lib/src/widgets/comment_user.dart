import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';

class CommentUser extends StatelessWidget {
  final String nameText;
  final String msjText;
  const CommentUser({
    Key key,
    @required this.nameText,
    @required this.msjText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RoundImageProfile(size: Constants.SIZE_ICON_COMENT),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBold(text: nameText),
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
