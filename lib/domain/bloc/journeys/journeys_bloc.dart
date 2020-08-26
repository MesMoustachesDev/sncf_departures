import 'dart:async';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sncf_schedules/data/model/journey/journey_response.dart';
import 'package:sncf_schedules/data/repo/departures/journeys_repository.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_bloc.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_states.dart';
import 'package:bloc/bloc.dart';
import 'package:sncf_schedules/domain/model/journey_view_object.dart';
import 'package:sncf_schedules/domain/model/station_view_object.dart';

import 'journeys_events.dart';
import 'journeys_states.dart';

class JourneysBloc extends Bloc<JourneysEvent, JourneysState> {
  final PrefsBloc prefsBloc;
  final _repository = RoutesRepository();
  SharedPreferences sharedPreferences;

  List<JourneyViewObject> oldHomeList;
  List<JourneyViewObject> oldWorkList;

  StreamSubscription _prefsSubscription;

  StationViewObject _home;
  StationViewObject _work;

  JourneysBloc(this.prefsBloc, JourneysState initialState)
      : super(initialState) {
    _prefsSubscription = prefsBloc.listen((state) {
      if (state is PrefsSet) {
        _home = state.home;
        _work = state.work;
      }
    });
  }

  @override
  Stream<JourneysState> mapEventToState(JourneysEvent event) async* {
    if (event is LoadHomeJourneys) {
      String format = "yyyyMMdd'T'HHmmss";
      String date = DateFormat(format).format(DateTime.now());
      sharedPreferences = await SharedPreferences.getInstance();
      String homeId = sharedPreferences.getString("homeId");
      String homeName = sharedPreferences.getString("homeName");

      if (homeId != null && homeName != null) {
        _home = StationViewObject.withStrings(homeName, homeId);
      }
      String workId = sharedPreferences.getString("workId");
      String workName = sharedPreferences.getString("workName");

      if (workId != null && workName != null) {
        _work = StationViewObject.withStrings(workName, workId);
      }

      if (oldHomeList == null) {
        yield JourneysLoading();
      } else {
        yield JourneysLoaded(
            homeToWorkJourneys: oldHomeList, workToHomeJourneys: oldWorkList);
      }

      var list = await _repository.getRoutes(_home.id, _work.id, date);

      List<JourneyViewObject> newList = list.body
          .where((departure) => isToday(departure))
          .map((departure) => JourneyViewObject(departure))
          .toList();

      oldHomeList = newList;
      yield JourneysLoaded(
          homeToWorkJourneys: oldHomeList, workToHomeJourneys: oldWorkList);
    } else if (event is LoadWorkJourneys) {
      String homeId = sharedPreferences.getString("homeId");
      String homeName = sharedPreferences.getString("homeName");

      if (homeId != null && homeName != null) {
        _home = StationViewObject.withStrings(homeName, homeId);
      }
      String workId = sharedPreferences.getString("workId");
      String workName = sharedPreferences.getString("workName");

      if (workId != null && workName != null) {
        _work = StationViewObject.withStrings(workName, workId);
      }
      String format = "yyyyMMdd'T'HHmmss";
      String date = DateFormat(format).format(DateTime.now());

      if (oldWorkList == null) {
        yield JourneysLoading();
      } else {
        yield JourneysLoaded(
            homeToWorkJourneys: oldHomeList, workToHomeJourneys: oldWorkList);
      }

      var list = await _repository.getRoutes(_work.id, _home.id, date);

      List<JourneyViewObject> newList = list.body
          .where((departure) => isToday(departure))
          .map((departure) => JourneyViewObject(departure))
          .toList();

      oldWorkList = newList;
      yield JourneysLoaded(
          homeToWorkJourneys: oldHomeList, workToHomeJourneys: oldWorkList);
    }
  }

  @override
  Future<void> close() {
    _prefsSubscription?.cancel();
    return super.close();
  }

  bool isToday(Journeys journey) {
    var now = DateTime.now();
    var tomorrowAt3 = new DateTime(now.year, now.month, now.day + 1, 3, 0);
    var departureTime = DateTime.parse(journey.departureDateTime);
    return departureTime.isBefore(tomorrowAt3);
  }
}
