import 'package:flutter/material.dart';
import 'package:myshowfilm/src/widgets/item/card_film_search.dart';
import 'package:myshowfilm/src/widgets/text/textfield_linear.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
        child: Container(
          child: Column(
            children: [
              TextFieldLinear(),
              Divider(
                height: 20,
                thickness: 2,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.316,
                child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    CardFilmSearch(),
                    CardFilmSearch(),
                    CardFilmSearch(),
                    CardFilmSearch(),
                    CardFilmSearch(),
                    CardFilmSearch(),
                    CardFilmSearch(),
                    CardFilmSearch(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
