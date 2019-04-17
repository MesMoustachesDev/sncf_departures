import 'dart:async';

import 'package:intl/intl.dart';
import 'package:sncf_schedules/data/model/departures/DeparturesResponse.dart';
import 'package:sncf_schedules/data/model/journey/JourneyResponse.dart';
import 'package:sncf_schedules/data/repo/departures/DeparturesRepository.dart';
import 'package:sncf_schedules/data/repo/departures/RoutesRepository.dart';
import 'package:sncf_schedules/domain/model/DepartureViewObject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sncf_schedules/domain/model/JourneyViewObject.dart';
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class RoutesBloc {
  final _repository = RoutesRepository();
  final _journeysFetcher = BehaviorSubject<List<JourneyViewObject>>();
//  final _departuresEventsStream = Stream<List<DepartureViewObject>>();
  final events = StreamController<JourneyRequest>();

  Observable<List<JourneyViewObject>> get journeys => _journeysFetcher.stream;

  RoutesBloc() {
    events.stream.listen((data) => fetchJourneys(data));
  }

  fetchJourneys(JourneyRequest stations) async {
//    _departuresFetcher.sink.add(null);
    String format = "yyyyMMdd'T'HHmmss";
    String date = DateFormat(format).format(DateTime.now());
    Observable<ParsedResponse<List<Journeys>>> observable =
        Observable.fromFuture(_repository.getRoutes(stations.start,
            stations.stop, date)); //"stop_area%3AOCE%3ASA%3A87271593", date));

    List<JourneyViewObject> itemModel = await observable
        .map((response) => response.body)
        .flatMap((list) => Observable.fromIterable(list))
        .where((journey) => isToday(journey))
        .map((journey) => JourneyViewObject(journey))
        .toList();

    _journeysFetcher.sink.add(itemModel);
  }

  bool isToday(Journeys journey) {
    var now = DateTime.now();
    var tomorrowAt3 = new DateTime(now.year, now.month, now.day + 1, 3, 0);
    var departureTime = DateTime.parse(journey.departureDateTime);
    return departureTime.isBefore(tomorrowAt3);
  }

  dispose() {
    _journeysFetcher.close();
    events.close();
  }
}

class JourneyRequest {
  final String start;
  final String stop;

  JourneyRequest(String start, String stop)
      : this.start = start,
        this.stop = stop;
}
