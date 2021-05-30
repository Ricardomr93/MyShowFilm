class Film {
  int id;
  double popularity;
  String title;
  String backPoster;
  String poster;
  String overview;
  double rating;

  Film(
    this.id,
    this.title,
    this.popularity,
    this.backPoster,
    this.poster,
    this.overview,
    this.rating,
  );

  Film.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        popularity = json['popularity'],
        backPoster = json['backdrop_path'],
        poster = json['poster_path'],
        overview = json['overview'],
        rating = json['vote_average'].toDouble;
}
