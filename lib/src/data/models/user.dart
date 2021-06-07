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
    this.delete = false,
    this.followers,
    this.followed,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["idUser"],
        userName: json["userName"],
        email: json["email"],
        pass: json["pass"],
        avatar: json["avatar"],
        delete: json["delete"],
        followers: json["followers"],
        followed: json["followed"],
      );
  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "userName": userName,
        "email": email,
        "pass": pass,
        "avatar": avatar,
        "delete": delete,
        "followers": followers,
        "followed ": followed,
      };
}
