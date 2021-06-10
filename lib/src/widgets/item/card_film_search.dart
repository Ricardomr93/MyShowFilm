import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/api_constants.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/pages/details_film_page.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';

class CardFilmSearch extends StatefulWidget {
  final film;
  CardFilmSearch({Key key, @required this.film}) : super(key: key);

  @override
  _CardFilmSearchState createState() => _CardFilmSearchState();
}

class _CardFilmSearchState extends State<CardFilmSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsFilmPage(
                        film: widget.film, type: Constants.LABEL_FILMS)),
              ),
            },
            child: Container(
              child: Row(
                children: [
                  widget.film.posterPath == null
                      ? _emptyFilm()
                      : Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${ApiConstants.IMAGE_URL}${widget.film.posterPath}"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 5,
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
                          ],
                        ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBold(text: widget.film.title),
                          SizedBox(height: 15),
                          Text(
                            widget.film.overview,
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  _emptyFilm() {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
        color: MyColors.whiteGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45.0),
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
    );
  }
}
