class CommentModel {
  String idUser;
  String msj;
  CommentModel({
    this.idUser,
    this.msj,
  });
  CommentModel.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    msj = json['msj'];
  }
}
