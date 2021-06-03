import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/pages/login_page.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/comment_user.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/widgets/text/textfield_transparent.dart';

class DetailsFilmPage extends StatefulWidget {
  DetailsFilmPage({Key key}) : super(key: key);

  @override
  _DetailsFilmPageState createState() => _DetailsFilmPageState();
}

class _DetailsFilmPageState extends State<DetailsFilmPage> {
  final _auth = FirebaseAuth.instance;
  final List<String> entries = <String>['A', 'B', 'C'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        _sliveAppBar(),
        SliverPadding(
          padding: EdgeInsets.all(0.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                    'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.' +
                        'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.'),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        child: Row(
                          children: [
                            RatingBar.builder(
                              itemSize: 20.0,
                              initialRating: 2.5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
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
                            SizedBox(width: 13),
                            Text('3.6/5'),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: MyColors.accentColor),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('5 Votes'),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true, //ocupa el espacio que necesita no mas
                  children: [
                    CommentUser(
                      nameText: 'Mariano escribar',
                      msjText:
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.' +
                              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                    ),
                    CommentUser(
                      nameText: 'Mariano escribar',
                      msjText:
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.' +
                              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                    ),
                    CommentUser(
                      nameText: 'Mariano escribar',
                      msjText:
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.' +
                              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                    ),
                    CommentUser(
                      nameText: 'Mariano escribar',
                      msjText:
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.' +
                              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                    ),
                    CommentUser(
                      nameText: 'Mariano escribar',
                      msjText:
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.' +
                              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                    ),
                    CommentUser(
                      nameText: 'Mariano escribar',
                      msjText:
                          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.' +
                              'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    ));
  }

  _sliveAppBar() {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsetsDirectional.only(start: 25, bottom: 5),
          title: TextBold(
            fontSize: 20,
            text: 'Mortal Kombat',
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
                    child: Image.asset(
                      'assets/img/mk.jpg',
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
                    0.9,
                  ],
                )),
              )
            ],
          )),
    );
  }
}
