import 'dart:async';

import 'package:sncf_schedules/data/model/search/SearchResponse.dart';
import 'package:sncf_schedules/data/repo/departures/Departures.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sncf_schedules/domain/model/StationViewObject.dart';
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class SearchDeparturesBloc {
  final _searchStationsFetcher = PublishSubject<List<StationViewObject>>();
  final _departuresQuery = BehaviorSubject<String>();

  Observable<List<StationViewObject>> get allResults =>
      _searchStationsFetcher.stream;

  Observable<String> get query => _departuresQuery.stream;
  StreamSink<String> get querySink => _departuresQuery.sink;

  fetchDepartures(String query) async {
    _searchStationsFetcher.sink.add(null);
    Observable<ParsedResponse<List<PtObjects>>> observable =
        Observable.fromFuture(searchStationRepository.getStations(query));

    List<StationViewObject> itemModel = await observable
        .map((response) => response.body)
        .flatMap((list) => Observable.fromIterable(list))
        .map((station) => StationViewObject(station))
        .toList();

    _searchStationsFetcher.sink.add(itemModel);
  }

  dispose() {
    _searchStationsFetcher.close();
    _departuresQuery.close();
  }
}

//final searchDeparturesBloc = SearchDeparturesBloc();
