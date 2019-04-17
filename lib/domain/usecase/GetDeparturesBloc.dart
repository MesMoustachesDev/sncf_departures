import 'dart:async';

import 'package:intl/intl.dart';
import 'package:sncf_schedules/data/model/departures/DeparturesResponse.dart';
import 'package:sncf_schedules/data/repo/departures/DeparturesRepository.dart';
import 'package:sncf_schedules/domain/model/DepartureViewObject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class DeparturesBloc {
  final _repository = DeparturesRepository();
  final _departuresFetcher = BehaviorSubject<List<DepartureViewObject>>();
//  final _departuresEventsStream = Stream<List<DepartureViewObject>>();
  final events = StreamController<String>();

  Observable<List<DepartureViewObject>> get allDepartures =>
      _departuresFetcher.stream;

  DeparturesBloc() {
    events.stream.listen((data) => fetchDepartures(data));
  }

  fetchDepartures(String station) async {
//    _departuresFetcher.sink.add(null);
    String format = "yyyyMMdd'T'HHmmss";
    String date = DateFormat(format).format(DateTime.now());
    Observable<ParsedResponse<List<Departures>>> observable =
        Observable.fromFuture(_repository.getDepartures(
            station, date)); //"stop_area%3AOCE%3ASA%3A87271593", date));

    List<DepartureViewObject> itemModel = await observable
        .map((response) => response.body)
        .flatMap((list) => Observable.fromIterable(list))
        .where((departure) => isToday(departure))
        .map((departure) => DepartureViewObject(departure))
        .toList();

    _departuresFetcher.sink.add(itemModel);
  }

  bool isToday(Departures departure) {
    var now = DateTime.now();
    var tomorrowAt3 = new DateTime(now.year, now.month, now.day + 1, 3, 0);
    var departureTime =
        DateTime.parse(departure.stopDateTime.departureDateTime);
    return departureTime.isBefore(tomorrowAt3);
  }

  dispose() {
    _departuresFetcher.close();
    events.close();
  }
}
