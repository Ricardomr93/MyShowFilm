import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/comments.dart';
import 'package:myshowfilm/src/models/film.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
CollectionReference users =
    FirebaseFirestore.instance.collection(Constants.COLL_USER);
CollectionReference films =
    FirebaseFirestore.instance.collection(Constants.COLL_FILM);
CollectionReference comments =
    FirebaseFirestore.instance.collection(Constants.COLL_COMMENT);

addComment(Film film, CommentModel comment) {
  films.doc(film.id.toString()).set({
    Constants.FILM_ID: film.id,
  }, SetOptions(merge: true)).then(
    (value) => {
      films.doc(film.id.toString()).collection(Constants.FILM_COMMENT).add({
        Constants.COMMENT_IDU: comment.idUser,
        Constants.COMMENT_MSJ: comment.msj,
      }),
    },
  );
}

getComment(Film film) async {
  List<CommentModel> list = [];
  films.doc(film.id.toString()).collection(Constants.FILM_COMMENT).get().then(
        (querySnaphot) => {
          querySnaphot.docs.forEach((element) {
            list.add(CommentModel.fromJson(element.data()));
          })
        },
      );
  return list;
}

Future<double> getAverage(Film film) async {
  double votes;
  films.doc(film.id.toString()).get().then(
        (value) => {
          film = Film.fromMap(value.data()),
          film.votes.forEach((element) {
            votes += element.vote;
            print('ELEMENTO: {$votes}');
          })
        },
      );
  return votes;
}
