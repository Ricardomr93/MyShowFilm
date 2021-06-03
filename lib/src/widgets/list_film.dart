import 'package:flutter/material.dart';
import 'package:myshowfilm/src/bloc/get_now_playing_bloc_film.dart';
import 'package:myshowfilm/src/bloc/get_now_playing_bloc_serie.dart';
import 'package:myshowfilm/src/core/api_constants.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/widgets/progress/progress_simple.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';

class ListFilm extends StatefulWidget {
  final snapshot;
  final type;
  ListFilm({Key key, @required this.snapshot, @required this.type})
      : super(key: key);

  @override
  _ListFilmState createState() => _ListFilmState();
}

class _ListFilmState extends State<ListFilm> {
  @override
  void initState() {
    super.initState();
    if (widget.type == Constants.LABEL_FILMS) {
      nowPlayingFilmsBloc.getFilms();
    } else {
      nowPlayingSeriesBloc.getSeries();
    }
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
    List films = data.films;
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
        child: Container(
          height: 400,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1 / 1.6,
                crossAxisSpacing: 20,
                mainAxisSpacing: 40),
            itemCount: films.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  films[index].posterPath == null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: MyColors.whiteGrey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 100.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.image_not_supported_outlined,
                                  color: MyColors.whiteGrey,
                                  size: 60,
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${ApiConstants.IMAGE_URL}${films[index].posterPath}"),
                                fit: BoxFit.cover),
                          ),
                        ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        MyColors.background.withOpacity(1.0),
                        MyColors.background.withOpacity(0.0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [
                        0.0,
                        0.6,
                      ],
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.bottomCenter,
                    child: TextBold(
                      overflow: true,
                      text: widget.type == Constants.LABEL_FILMS
                          ? films[index].title
                          : films[index].name,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    }
  }
}
