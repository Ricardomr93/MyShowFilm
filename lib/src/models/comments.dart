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
  CommentModel.fromMap(Map<String, dynamic> map) {
    idUser = map['idUser'];
    msj = map['msj'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['msj'] = this.msj;
    return data;
  }
}
