import 'dart:async';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sncf_schedules/data/model/departures/departures_response.dart';
import 'package:sncf_schedules/data/repo/departures/departures_repository.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_bloc.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_states.dart';
import 'package:bloc/bloc.dart';
import 'package:sncf_schedules/domain/model/departure_view_object.dart';
import 'package:sncf_schedules/domain/model/station_view_object.dart';

import 'departure_events.dart';
import 'departures_states.dart';

class DeparturesBloc extends Bloc<DeparturesEvent, DepartureState> {
  final PrefsBloc prefsBloc;
  final _repository = DeparturesRepository();

  List<DepartureViewObject> oldHomeList;
  List<DepartureViewObject> oldWorkList;

  StreamSubscription _prefsSubscription;

  StationViewObject _home;
  StationViewObject _work;

  DeparturesBloc({@required this.prefsBloc}) {
    _prefsSubscription = prefsBloc.state.listen((state) {
      if (state is PrefsSet) {
        _home = state.home;
        _work = state.work;
      }
    });
  }

  @override
  get initialState => DeparturesInitial();

  @override
  Stream<DepartureState> mapEventToState(DeparturesEvent event) async* {
    if (event is LoadHomeDeparture) {
      String format = "yyyyMMdd'T'HHmmss";
      String date = DateFormat(format).format(DateTime.now());

      if (oldHomeList == null) {
        yield DeparturesLoading();
      } else {
        yield DeparturesLoaded(
            homeToWorkJourneys: oldHomeList, workToHomeJourneys: oldWorkList);
      }

      var list = await _repository.getDepartures(_home.id, date);

      List<DepartureViewObject> newList = list.body
          .where((departure) => isToday(departure))
          .map((departure) => DepartureViewObject(departure))
          .toList();

      oldHomeList = newList;
      yield DeparturesLoaded(
          homeToWorkJourneys: oldHomeList, workToHomeJourneys: oldWorkList);
    } else if (event is LoadWorkDeparture) {
      String format = "yyyyMMdd'T'HHmmss";
      String date = DateFormat(format).format(DateTime.now());

      if (oldWorkList == null) {
        yield DeparturesLoading();
      } else {
        yield DeparturesLoaded(
            homeToWorkJourneys: oldHomeList, workToHomeJourneys: oldWorkList);
      }

      var list = await _repository.getDepartures(_work.id, date);

      List<DepartureViewObject> newList = list.body
          .where((departure) => isToday(departure))
          .map((departure) => DepartureViewObject(departure))
          .toList();

      oldWorkList = newList;
      yield DeparturesLoaded(
          homeToWorkJourneys: oldHomeList, workToHomeJourneys: oldWorkList);
    }
  }

  @override
  Stream<DepartureState> transform(
    Stream<DeparturesEvent> events,
    Stream<DepartureState> Function(DeparturesEvent event) next,
  ) {
    return super.transform(
      (events as Observable<DeparturesEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  void dispose() {
    _prefsSubscription.cancel();
    super.dispose();
  }

  bool isToday(Departures departure) {
    var now = DateTime.now();
    var tomorrowAt3 = new DateTime(now.year, now.month, now.day + 1, 3, 0);
    var departureTime =
        DateTime.parse(departure.stopDateTime.departureDateTime);
    return departureTime.isBefore(tomorrowAt3);
  }
}
