import 'package:flutter/material.dart';
import 'package:myshowfilm/src/widgets/tabs/tabs_lists/list_film.dart';
import 'package:myshowfilm/src/widgets/tabs/tabs_lists/now_playing.dart';

class FilmPage extends StatefulWidget {
  final type;
  FilmPage({Key key, @required this.type}) : super(key: key);

  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NowPlaying(
          type: widget.type,
        ),
        ListFilm(
          type: widget.type,
        ),
      ],
    );
  }
}
