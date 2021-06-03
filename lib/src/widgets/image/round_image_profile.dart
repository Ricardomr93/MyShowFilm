import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';

class RoundImageProfile extends StatelessWidget {
  final ImageProvider<Object> image;
  final double size;
  const RoundImageProfile({Key key, this.image, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: FadeInImage(
        width: size,
        height: size,
        placeholder: AssetImage('assets/img/load.gif'),
        fit: BoxFit.cover,
        image: image == null ? NetworkImage(Constants.IMAGE_PRED) : image,
      ),
    );
  }
}
