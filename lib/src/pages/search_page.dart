import 'package:flutter/material.dart';
import 'package:myshowfilm/src/bloc/search/search_bloc_film.dart';
import 'package:myshowfilm/src/data/models/film_response.dart';
import 'package:myshowfilm/src/utils/util_text.dart' as util;
import 'package:myshowfilm/src/widgets/item/card_film_search.dart';
import 'package:myshowfilm/src/widgets/progress/progress_simple.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';
import 'package:myshowfilm/src/widgets/text/textfield_linear.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  AsyncSnapshot<FilmResponse> snapshotFilm;
  final _formKey = GlobalKey<FormState>();
  List films;
  bool stateInit = true;
  String query;
  @override
  void initState() {
    stateInit = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: TextFieldLinear(
                    validator: (val) => util.isFieldEmpty(val),
                    onSaved: (val) => query = val,
                    onPresed: () => _searchFilm(),
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                ),
                stateInit ? Container() : _listsearch()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _searchFilm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    FocusScope.of(context).requestFocus(FocusNode());
    searchBlocFilm.searchFilms(query);
    stateInit = false;
    setState(() {});
  }

  Widget _buildErrorWidget(String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 250),
      child: Text("Ha ocurrido un error"),
    );
  }

  _listsearch() {
    return StreamBuilder(
        stream: searchBlocFilm.subject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            films = snapshot.data.films;
            print('$films');
            return films.length <= 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 250),
                    child: TextBold(text: "No se han encontrado resultados..."),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.316,
                    child: ListView.builder(
                      itemCount: films.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return CardFilmSearch(
                          film: films[index],
                        );
                      },
                    ),
                  );
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else if (films != null) {
            return ProgressSimple();
          } else if (!snapshot.hasData) {}
          return Container();
        });
  }
}
