import 'package:myshowfilm/src/models/serie_response.dart';
import 'package:myshowfilm/src/repository/serie_repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingListBlocSerie {
  SerieRepository _repository = SerieRepository();
  final BehaviorSubject<SerieResponse> _subject =
      BehaviorSubject<SerieResponse>();

  getSeries() async {
    SerieResponse response = await _repository.getPlayingSerie();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SerieResponse> get subject => _subject;
}

final nowPlayingSeriesBloc = NowPlayingListBlocSerie();
