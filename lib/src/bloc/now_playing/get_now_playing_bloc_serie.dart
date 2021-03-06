import 'package:myshowfilm/src/data/models/serie_response.dart';
import 'package:myshowfilm/src/data/repository/serie_repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingListBlocSerie {
  SerieRepository _repository = SerieRepository();
  final BehaviorSubject<SerieResponse> _subject =
      BehaviorSubject<SerieResponse>();

  getSeries(int page) async {
    SerieResponse response = await _repository.getPlayingSerie(page);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SerieResponse> get subject => _subject;
}

final nowPlayingSeriesBloc = NowPlayingListBlocSerie();
