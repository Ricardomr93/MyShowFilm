class VoteModel {
  String idUser;
  double vote;

  VoteModel(
    this.idUser,
    this.vote,
  );
  VoteModel.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    vote = json['vote'].toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['vote'] = this.vote;
    return data;
  }
}
