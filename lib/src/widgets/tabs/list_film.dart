import 'package:flutter/material.dart';
import 'package:myshowfilm/src/bloc/get_now_playing_bloc_film.dart';
import 'package:myshowfilm/src/bloc/get_now_playing_bloc_serie.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_round.dart';
import 'package:myshowfilm/src/widgets/card_film.dart';
import 'package:myshowfilm/src/widgets/progress/progress_simple.dart';

class ListFilm extends StatefulWidget {
  final type;
  final snapshot;
  ListFilm({Key key, @required this.snapshot, @required this.type})
      : super(key: key);

  @override
  _ListFilmState createState() => _ListFilmState();
}

class _ListFilmState extends State<ListFilm> {
  int page = 1;
  List films;
  ScrollController _controller;
  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    _controller.addListener(_onScrollUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.type == Constants.LABEL_FILMS
          ? nowPlayingFilmsBloc.subject.stream
          : nowPlayingSeriesBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildPopularWidget(snapshot.data, widget.type);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return ProgressSimple();
        }
      },
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildPopularWidget(data, String type) {
    films == null ? films = data.films : null;
    if (films.length == 0) {
      return Container(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  Constants.NO_MORE_FILM,
                  style: TextStyle(color: MyColors.accentColor),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.95,
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                controller: _controller,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 1.6,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 40),
                itemCount: films.length,
                itemBuilder: (context, index) {
                  if (index >= films.length) {
                    print('object');
                  }
                  return CardFilm(type: type, film: films[index]);
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  void _onScrollUpdate() {
    var maxScroll = _controller.position.maxScrollExtent;
    var currentPosition = _controller.position.pixels;
    if (currentPosition > maxScroll - 100) {
      films.add(films[12]);
      print('llegamos al final');
    }
  }
}
