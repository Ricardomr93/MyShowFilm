import 'package:flutter/material.dart';
import 'package:myshowfilm/src/bloc/get_now_playing_bloc.dart';
import 'package:myshowfilm/src/core/api_constants.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/film.dart';
import 'package:myshowfilm/src/models/film_response.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/theme/my_theme.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatefulWidget {
  NowPlaying({Key key}) : super(key: key);

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc.getFilms();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<FilmResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget(); //TODO cambiar por el propio
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        heightFactor: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(myTheme.accentColor),
              strokeWidth: 6,
            ),
          ],
        ));
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

  Widget _buildHomeWidget(FilmResponse data) {
    List<Film> films = data.films;
    if (films.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  Constants.NO_MORE_FILM,
                  style: TextStyle(color: myTheme.accentColor),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 210.0,
        child: PageIndicatorContainer(
            align: IndicatorAlign.bottom,
            length: films.take(Constants.NUM_FILMS_NOW).length,
            indicatorSpace: 9,
            padding: EdgeInsets.all(5.0),
            indicatorColor: MyColors.whiteGrey,
            indicatorSelectorColor: myTheme.accentColor,
            shape: IndicatorShape.circle(size: 8),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: films.take(Constants.NUM_FILMS_NOW).length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: NetworkImage(
                                "${ApiConstants.IMAGE_URL}${films[index].backdropPath}"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          myTheme.backgroundColor.withOpacity(1.0),
                          myTheme.backgroundColor.withOpacity(0.0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0.0,
                          0.9,
                        ],
                      )),
                    ),
                    Positioned(
                        bottom: 30.0,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          width: 250.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [TextBold(text: films[index].title)],
                          ),
                        ))
                  ],
                );
              },
            )),
      );
  }
}
