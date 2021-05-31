import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';

class RoundImageProfile extends StatelessWidget {
  final image;
  const RoundImageProfile({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 160.0,
        height: 160.0,
        decoration: BoxDecoration(
            border: Border.all(width: 3.5, color: MyColors.whiteGrey),
            shape: BoxShape.circle,
            image: DecorationImage(fit: BoxFit.cover, image: image)));
  }
}
