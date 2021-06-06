import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshowfilm/src/core/constants.dart';
import 'package:myshowfilm/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference users =
    FirebaseFirestore.instance.collection(Constants.COLL_USER);

addUser(UserModel user) {
  return users.doc(user.idUser).set(user.toJson());
}

Future<UserModel> getUserByID(String id) async {
  UserModel u;
  users.doc(id).get().then((doc) => u = UserModel.fromJson(doc.data()));
  print(u);
  return u;
}

addUserAuth(FirebaseAuth auth) {
  users.doc(auth.currentUser.uid).get().then((doc) => {
        if (!doc.exists)
          {
            users.doc(auth.currentUser.uid).set({
              Constants.USER_ID: auth.currentUser.uid,
              Constants.USER_EMAIL: auth.currentUser.email,
              Constants.USER_AVATAR: auth.currentUser.photoURL,
              Constants.USER_NAME: auth.currentUser.displayName
            }),
          }
      });
}

updateUser(FirebaseAuth auth, [String pass]) {
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

deleteUser(FirebaseAuth auth) {
  users.doc(auth.currentUser.uid).update({
    Constants.USER_DELETE: true,
  });
}
