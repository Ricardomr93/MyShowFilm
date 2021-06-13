import 'package:flutter/material.dart';
import 'package:myshowfilm/src/bloc/now_playing/get_now_playing_bloc_film.dart';
import 'package:myshowfilm/src/bloc/now_playing/get_now_playing_bloc_serie.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_round.dart';
import 'package:myshowfilm/src/widgets/item/card_film.dart';
import 'package:myshowfilm/src/widgets/progress/progress_simple.dart';

class ListFilm extends StatefulWidget {
  final type;

  ListFilm({Key key, @required this.type}) : super(key: key);

  @override
  _ListFilmState createState() => _ListFilmState();
}

class _ListFilmState extends State<ListFilm> {
  int page = 1;
  List films;
  bool nextPage = false;
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    if (widget.type == Constants.LABEL_FILMS) {
      nowPlayingFilmsBloc.getFilms(page);
    } else {
      nowPlayingSeriesBloc.getSeries(page);
    }
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
          films = snapshot.data.films;
          return _buildPopularWidget(widget.type);
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
        Text("Ha ocurrido un error"),
      ],
    ));
  }

  Widget _buildPopularWidget(String type) {
    if (films.length == 0) {
      return Container(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
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
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.95,
              child: GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                controller: _controller,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 1.6,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 40),
                itemCount: films.length,
                itemBuilder: (context, index) {
                  return CardFilm(type: type, film: films[index]);
                },
              ),
            ),
            nextPage
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtomRound(
                            onPressed: () {
                              page++;
                              _controller.jumpTo(0.0);
                              if (widget.type == Constants.LABEL_FILMS) {
                                nowPlayingFilmsBloc.getFilms(page);
                              } else {
                                nowPlayingSeriesBloc.getSeries(page);
                              }
                              setState(() {});
                            },
                            size: 55,
                            iconSize: 35,
                            icon: Icons.queue_play_next_rounded),
                      ],
                    ))
                : Container(),
          ],
        ),
      );
    }
  }

  _onScrollUpdate() {
    var maxScroll = _controller.position.maxScrollExtent;
    var currentPosition = _controller.position.pixels;
    setState(() {
      if (currentPosition >= maxScroll) {
        nextPage = true;
      } else {
        nextPage = false;
      }
    });
  }
}
