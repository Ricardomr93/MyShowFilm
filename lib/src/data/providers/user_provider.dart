import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference users =
    FirebaseFirestore.instance.collection(Constants.COLL_USER);

///Añade un usuario a firestore.
Future<void> addUser(UserModel user) async {
  users.doc(user.idUser).set(user.toJson());
}

Future<UserModel> getUserByID(String id) async {
  UserModel u;
  users.doc(id).get().then((doc) => u = UserModel.fromJson(doc.data()));
  return u;
}

///Añade un usuario de proveedor a firestore.
Future<void> addUserAuth(FirebaseAuth auth) async {
  users.doc(auth.currentUser.uid).get().then((doc) => {
        if (!doc.exists) // si no existe se añade
          {
            users.doc(auth.currentUser.uid).set({
              Constants.USER_ID: auth.currentUser.uid,
              Constants.USER_EMAIL: auth.currentUser.email,
              Constants.USER_AVATAR: auth.currentUser.photoURL,
              Constants.USER_NAME: auth.currentUser.displayName,
              Constants.USER_FOLLOWED: [],
              Constants.USER_FOLLOWER: [],
            }),
          }
      });
}

///Modifica un usuario ya registrado.
///
///La contraseña [String pass] es opcional.
Future<void> updateUser(FirebaseAuth auth, [String pass]) async {
  if (pass == null) {
    users.doc(auth.currentUser.uid).update({
      Constants.USER_EMAIL: auth.currentUser.email,
      Constants.USER_AVATAR: auth.currentUser.photoURL,
      Constants.USER_NAME: auth.currentUser.displayName
    });
  } else {
    users.doc(auth.currentUser.uid).update({
      Constants.USER_EMAIL: auth.currentUser.email,
      Constants.USER_AVATAR: auth.currentUser.photoURL,
      Constants.USER_NAME: auth.currentUser.displayName,
      Constants.USER_PASS: pass,
    });
  }
}

Future<void> deleteUser(FirebaseAuth auth) async {
  users.doc(auth.currentUser.uid).update({
    Constants.USER_DELETE: true,
  });
}

Future<void> followUser(String idAuth, String idUser) async {
  users.doc(idAuth).set({
    Constants.USER_FOLLOWED: FieldValue.arrayUnion([idUser])
  }, SetOptions(merge: true)).then((value) => users.doc(idUser).set({
        Constants.USER_FOLLOWER: FieldValue.arrayUnion([idAuth])
      }, SetOptions(merge: true)));
}

Future<void> unfollowUser(String idAuth, String idUser) async {
  users.doc(idAuth).update({
    Constants.USER_FOLLOWED: FieldValue.arrayRemove([idUser])
  }).then((value) => users.doc(idUser).update({
        Constants.USER_FOLLOWER: FieldValue.arrayRemove([idAuth])
      }));
}
