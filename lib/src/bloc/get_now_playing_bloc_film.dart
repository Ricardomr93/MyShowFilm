import 'package:myshowfilm/src/data/models/film_response.dart';
import 'package:myshowfilm/src/data/repository/film_repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingListBlocFilm {
  FilmRepository _repository = FilmRepository();
  final BehaviorSubject<FilmResponse> _subject =
      BehaviorSubject<FilmResponse>();

  getFilms(int numPage) async {
    FilmResponse response = await _repository.getPlayingFilm(numPage);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<FilmResponse> get subject => _subject;
}

final nowPlayingFilmsBloc = NowPlayingListBlocFilm();
