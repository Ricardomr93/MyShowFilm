import 'package:flutter/material.dart';

class RoundImageProfile extends StatelessWidget {
  final image;
  final size;
  const RoundImageProfile({Key key, this.image, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: FadeInImage(
        width: size.toDouble(),
        height: size.toDouble(),
        placeholder: AssetImage('assets/img/load.gif'),
        fit: BoxFit.cover,
        image: image,
      ),
    );
  }
}
