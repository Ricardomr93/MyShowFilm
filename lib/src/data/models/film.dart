import 'package:myshowfilm/src/data/models/comments.dart';
import 'package:myshowfilm/src/data/models/vote.dart';

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
  List<CommentModel> comments;
  List<VoteModel> votes;

  Film({
    this.genreIds,
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
    this.mediaType,
    this.comments,
    this.votes,
  });

  Film.fromJson(Map<String, dynamic> json) {
    genreIds = json['genre_ids'].cast<int>();
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'].toDouble();
    overview = json['overview'];
    releaseDate = json['release_date'];
    voteCount = json['vote_count'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    title = json['title'];
    popularity = json['popularity'].toDouble();
    mediaType = json['media_type'];
    //comments = json['comments'].cast<CommentModel>();
    //votes = json['votes'].cast<VoteModel>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['id'] = this.id;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['votes'] = this.votes;
    data['vote_count'] = this.voteCount;
    if (this.genreIds != null) {
      data['genre_ids'] = this.genreIds;
    }
    if (this.comments != null) {
      data['comments'] = this.comments;
    }
    return data;
  }
}
