import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/api_constants.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/comments.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/providers/film_provider.dart' as filmProv;
import 'package:myshowfilm/src/widgets/comment_user.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/progress/progress_simple.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/utils/util_text.dart' as util;
import 'package:myshowfilm/src/widgets/text/textfield_transparent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsFilmPage extends StatefulWidget {
  final film;
  final String type;

  DetailsFilmPage({Key key, @required this.film, this.type}) : super(key: key);

  @override
  _DetailsFilmPageState createState() => _DetailsFilmPageState(film);
}

class _DetailsFilmPageState extends State<DetailsFilmPage> {
  final _auth = FirebaseAuth.instance;
  CommentModel comment = CommentModel();
  final film;
  final _formKey = GlobalKey<FormState>();
  _DetailsFilmPageState(this.film);
  CollectionReference filmsss =
      FirebaseFirestore.instance.collection(Constants.COLL_FILM);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: filmsss
            .doc(film.id.toString())
            .collection(Constants.FILM_COMMENT)
            .get(), //filmProv.getComment(film), //TODO falta para series
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //return Center(child: Text('${snapshot.data.docs.length}'));
            return _detailswid(snapshot);
          }
          if (snapshot.hasError) {
            return Center(child: Text('error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ProgressSimple();
          }
        },
      ),
    );
  }

  _detailswid(AsyncSnapshot<dynamic> snapshot) {
    final double votes = 0.0;
    return CustomScrollView(
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
                            initialRating: votes,
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
                            text: '$votes/5',
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
                      text: film.votes == null
                          ? '0 votes'
                          : '${film.votes.lenght} Votes',
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
                    child: Form(
                      key: _formKey,
                      child: TextFieldTransparent(
                        validator: (val) => util.isFieldEmpty(val),
                        onSaved: (val) => comment.msj = val,
                        onPressed: () => _sendComment(),
                      ),
                    ),
                  ),
                ],
              )),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextBold(text: 'Comentarios'),
            ),
            snapshot.data.docs.length <= 0
                ? Center(
                    child: TextBold(
                      text: Constants.NOT_COMMENTS,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return CommentUser(
                        idUser: '${snapshot.data.docs[index].data()['idUser']}',
                        msjText: '${snapshot.data.docs[index].data()['msj']}',
                      );
                    },
                    shrinkWrap: true, //ocupa el espacio que necesita no mas
                  ),
          ]),
        ),
      ],
    );
  }

  _sliveAppBar(film, type) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height / 5,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
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
                  height: MediaQuery.of(context).size.height,
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

  _sendComment() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    comment.idUser = _auth.currentUser.uid;
    filmProv.addComment(film, comment);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => DetailsFilmPage(
                film: film,
                type: widget.type,
              )),
    );
  }
}
