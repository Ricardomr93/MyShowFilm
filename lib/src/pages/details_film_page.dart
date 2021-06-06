import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/api_constants.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/widgets/comment_user.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/widgets/text/textfield_transparent.dart';

class DetailsFilmPage extends StatefulWidget {
  final film;
  final String type;
  DetailsFilmPage({Key key, @required this.film, this.type}) : super(key: key);

  @override
  _DetailsFilmPageState createState() => _DetailsFilmPageState(film);
}

class _DetailsFilmPageState extends State<DetailsFilmPage> {
  final _auth = FirebaseAuth.instance;
  final film;

  _DetailsFilmPageState(this.film);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _sliveAppBar(film, widget.type),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding:
                  EdgeInsets.only(right: 25, top: 30, left: 25, bottom: 10),
              child: Text(film.overview),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3),
                      child: Row(
                        children: [
                          RatingBar.builder(
                            itemSize: 16.0,
                            initialRating: 2.5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: MyColors.accentColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          SizedBox(width: 12),
                          TextBold(
                            text: '3.6/5',
                            fontSize: 14,
                            color: MyColors.accentColor,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: MyColors.accentColor, width: 3),
                      ),
                    ),
                    SizedBox(width: 12),
                    TextBold(
                      text: '5 Votes',
                      fontSize: 14,
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 1),
              child: Container(
                  child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: RoundImageProfile(
                      size: Constants.SIZE_ICON_COMENT,
                      image: _auth.currentUser.photoURL == null
                          ? NetworkImage(Constants.IMAGE_PRED)
                          : NetworkImage(_auth.currentUser.photoURL),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: TextFieldTransparent(),
                  ),
                ],
              )),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextBold(text: 'Comentarios'),
            ),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 25),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true, //ocupa el espacio que necesita no mas
              children: [
                CommentUser(
                  nameText: 'Mariano escribar',
                  msjText:
                      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.' +
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                ),
              ],
            ),
          ]),
        ),
      ],
    ));
  }

  _sliveAppBar(film, type) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          //titlePadding: EdgeInsetsDirectional.only(start: 48, bottom: 20, end: 50),
          // centerTitle: true,
          title: TextBold(
            fontSize: 15,
            maxLines: 3,
            text: type == Constants.LABEL_FILMS ? film.title : film.name,
            fontWeight: FontWeight.w900,
            overflow: true,
          ),
          background: Stack(
            children: [
              Opacity(
                opacity: 0.6,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 245,
                  child: ClipRRect(
                    child: Image.network(
                      "${ApiConstants.IMAGE_URL}${film.backdropPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
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
              )
            ],
          )),
    );
  }
}
