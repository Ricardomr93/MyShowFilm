import 'package:flutter/material.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshowfilm/src/widgets/buttom/buttom_back.dart';
import 'package:myshowfilm/src/widgets/image/round_image_profile.dart';

class DetailsFilmPage extends StatefulWidget {
  DetailsFilmPage({Key key}) : super(key: key);

  @override
  _DetailsFilmPageState createState() => _DetailsFilmPageState();
}

class _DetailsFilmPageState extends State<DetailsFilmPage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
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
                            Text('3.6/5')
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: MyColors.accentColor),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('5 Votes')
                    ],
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  children: [
                    RoundImageProfile(
                      size: 50,
                      image: _auth.currentUser.photoURL == null
                          ? NetworkImage(Constants.IMAGE_PRED)
                          : NetworkImage(_auth.currentUser.photoURL),
                    ),
                    SizedBox(width: 15),
                    Text('Add a comment ...')
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
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
          title: Text('Mortal Kombat'),
          background: Stack(
            children: [
              ButtomBack(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/img/mk.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    MyColors.background.withOpacity(.2),
                    MyColors.background.withOpacity(.2),
                  ],
                )),
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
                    0.9,
                  ],
                )),
              )
            ],
          )),
    );
  }
}
