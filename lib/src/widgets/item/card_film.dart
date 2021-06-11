import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/api_constants.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/pages/details_film_page.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';

class CardFilm extends StatelessWidget {
  final type;
  final film;
  const CardFilm({Key key, @required this.type, @required this.film})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailsFilmPage(film: film, type: type)),
            ),
        child: Stack(
          children: [
            film.posterPath == null
                ? _emptyFilm(context)
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
                              "${ApiConstants.IMAGE_URL}${film.posterPath}"),
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
                maxLines: 2,
                text: type == Constants.LABEL_FILMS ? film.title : film.name,
              ),
            )
          ],
        ));
  }

  _emptyFilm(context) {
    return Container(
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
        padding: const EdgeInsets.symmetric(vertical: 100.0),
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
