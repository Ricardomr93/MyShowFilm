import 'package:flutter/material.dart';
import 'package:myshowfilm/src/theme/my_colors.dart';
import 'package:myshowfilm/src/widgets/text/text_bold.dart';

class CardFilmSearch extends StatefulWidget {
  CardFilmSearch({Key key}) : super(key: key);

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
            onTap: () {},
            child: Container(
              child: Row(
                children: [
                  Stack(
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
                                  'https://i.blogs.es/aaa129/1136691/1366_2000.jpeg'),
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
                          TextBold(text: 'Mortal Kombat'),
                          SizedBox(height: 15),
                          Text(
                            'En "Mortal Kombat", Cole Young, un luchador de MMA acostumbrado a recibir palizas a cambio de plata, no sabe lo que heredó, ni por qué el emperador Shang Tsung del Mundo Exterior mandó a Sub-Zero, su mejor guerrero, un criomante de otro mundo, a cazarlo. Cole teme por la seguridad de su familia, y sale en busca de Sonya Blade por indicación de Jax, un comandante de las Fuerzas Especiales que tiene la misma marca rara de nacimiento que Cole, con forma de dragón. ',
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
}
