class UserModel {
  String idUser;
  String userName;
  String email;
  String pass;
  String avatar;
  bool delete;
  List<String> followers;
  List<String> followed;

  UserModel({
    this.idUser,
    this.userName,
    this.email,
    this.pass,
    this.avatar,
    this.delete,
    this.followers,
    this.followed,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    idUser = json["idUser"];
    userName = json["userName"];
    email = json["email"];
    pass = json["pass"];
    avatar = json["avatar"];
    followers = json["followers"].cast<String>();
    followed = json["followed"].cast<String>();
  }
  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "userName": userName,
        "email": email,
        "avatar": avatar,
        "pass": pass,
        "followers": [],
        "followed": [],
      };
}
