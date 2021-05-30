import 'package:flutter/material.dart';
import 'package:myshowfilm/src/widgets/now_playing.dart';

class FilmPage extends StatefulWidget {
  FilmPage({Key key}) : super(key: key);

  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NowPlaying(),
      ],
    );
  }
}
