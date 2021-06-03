import 'package:flutter/material.dart';
import 'package:myshowfilm/src/models/film_response.dart';
import 'package:myshowfilm/src/widgets/list_film.dart';
import 'package:myshowfilm/src/widgets/now_playing.dart';

class FilmPage extends StatefulWidget {
  final snapshot;
  final type;
  FilmPage({Key key, this.snapshot, @required this.type}) : super(key: key);

  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
  AsyncSnapshot<FilmResponse> sn;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        NowPlaying(
          snapshot: widget.snapshot,
          type: widget.type,
        ),
        ListFilm(
          snapshot: widget.snapshot,
          type: widget.type,
        ),
      ],
    );
  }
}
