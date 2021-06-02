import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoundImageProfile extends StatelessWidget {
  final image;
  final size;
  const RoundImageProfile({Key key, this.image, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: FadeInImage(
        width: 160.0,
        height: 160.0,
        placeholder: AssetImage('assets/img/loading.gif'),
        fit: BoxFit.cover,
        image: image,
      ),
    );
  }
}
