class Film {
  List<int> genreIds;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  int id;
  bool video;
  double voteAverage;
  String overview;
  String releaseDate;
  int voteCount;
  bool adult;
  String backdropPath;
  String title;
  double popularity;
  String mediaType;

  Film(
      {this.genreIds,
      this.originalLanguage,
      this.originalTitle,
      this.posterPath,
      this.id,
      this.video,
      this.voteAverage,
      this.overview,
      this.releaseDate,
      this.voteCount,
      this.adult,
      this.backdropPath,
      this.title,
      this.popularity,
      this.mediaType});

  Film.fromJson(Map<String, dynamic> json) {
    genreIds = json['genre_ids'].cast<int>();
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    voteCount = json['vote_count'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    title = json['title'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genre_ids'] = this.genreIds;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['vote_count'] = this.voteCount;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['title'] = this.title;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    return data;
  }
}
