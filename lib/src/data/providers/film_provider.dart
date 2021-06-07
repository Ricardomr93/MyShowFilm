import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/data/models/comments.dart';
import 'package:myshowfilm/src/data/models/film.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();
CollectionReference users =
    FirebaseFirestore.instance.collection(Constants.COLL_USER);
CollectionReference films =
    FirebaseFirestore.instance.collection(Constants.COLL_FILM);
CollectionReference series =
    FirebaseFirestore.instance.collection(Constants.COLL_SERIE);
CollectionReference comments =
    FirebaseFirestore.instance.collection(Constants.COLL_COMMENT);

addComment(film, CommentModel comment, String type) async {
  if (type == Constants.LABEL_FILMS) {
    films.doc(film.id.toString()).set({
      Constants.FILM_ID: film.id,
    }).then(
      (value) => {
        films.doc(film.id.toString()).collection(Constants.FILM_COMMENT).add({
          Constants.COMMENT_IDU: comment.idUser,
          Constants.COMMENT_MSJ: comment.msj,
        }),
      },
    );
  } else {
    series.doc(film.id.toString()).set({
      Constants.FILM_ID: film.id,
    }).then(
      (value) => {
        series.doc(film.id.toString()).collection(Constants.FILM_COMMENT).add({
          Constants.COMMENT_IDU: comment.idUser,
          Constants.COMMENT_MSJ: comment.msj,
        }),
      },
    );
  }
}

addAverage(film, String idUser, double vote, String type) async {
  if (type == Constants.LABEL_FILMS) {
    films.doc(film.id.toString()).set({
      Constants.FILM_ID: film.id,
    }).then(
      (value) => {
        films
            .doc(film.id.toString())
            .collection(Constants.FILM_VOTES)
            .doc(idUser)
            .set(
                {
              Constants.VOTE_IDU: idUser,
              Constants.VOTE_VOTE: vote,
            },
                SetOptions(
                    merge:
                        true)), //impide que un mismo usuario vote mas de una vez
      },
    );
  } else {
    series.doc(film.id.toString()).set({
      Constants.FILM_ID: film.id,
    }).then((value) => {
          series
              .doc(film.id.toString())
              .collection(Constants.FILM_VOTES)
              .doc(idUser)
              .set(
                  {
                Constants.VOTE_IDU: idUser,
                Constants.VOTE_VOTE: vote,
              },
                  SetOptions(
                      merge:
                          true)), //impide que un mismo usuario vote mas de una vez
        });
  }
}
