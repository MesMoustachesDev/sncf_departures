import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sncf_schedules/data/model/search/search_response.dart';
import 'package:sncf_schedules/data/repo/departures/departures_repository.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_events.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_states.dart';
import 'package:bloc/bloc.dart';
import 'package:sncf_schedules/domain/model/station_view_object.dart';

class PrefsBloc extends Bloc<PrefsEvent, PrefsState> {
  SharedPreferences sharedPreferences;

  @override
  get initialState => PrefsUninitialized();

  @override
  Stream<PrefsState> mapEventToState(PrefsEvent event) async* {
    if (event is SearchWorkPrefs) {
      var list = await searchStationRepository.getStations(event.query);
      List<StationViewObject> newList =
          list.body.map((station) => StationViewObject(station)).toList();

      yield QueryResultsSet(homeQueryResult: null, workQueryResult: newList);
    } else if (event is SearchHomePrefs) {
      var list = await searchStationRepository.getStations(event.query);
      List<StationViewObject> newList =
          list.body.map((station) => StationViewObject(station)).toList();

      yield QueryResultsSet(homeQueryResult: newList, workQueryResult: null);
    } else if (event is SetHomePrefs) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("homeId", event.homeId);
      sharedPreferences.setString("homeName", event.homeName);
      dispatch(LoadPrefs());
    } else if (event is SetWorkPrefs) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("workId", event.workId);
      sharedPreferences.setString("workName", event.workName);
      dispatch(LoadPrefs());
    } else if (event is LoadPrefs) {
      sharedPreferences = await SharedPreferences.getInstance();
      String homeId = sharedPreferences.getString("homeId");
      String homeName = sharedPreferences.getString("homeName");

      String workId = sharedPreferences.getString("workId");
      String workName = sharedPreferences.getString("workName");

      if (homeId != null &&
          homeName != null &&
          workId != null &&
          workName != null) {
        yield PrefsSet(
            home: StationViewObject.withStrings(homeName, homeId),
            work: StationViewObject.withStrings(workName, workId));
      } else if (homeId != null && homeName != null) {
        yield HomeSet(home: StationViewObject.withStrings(homeId, homeName));
      } else if (workId != null && workName != null) {
        yield WorkSet(work: StationViewObject.withStrings(workId, workName));
      } else {
        yield PrefsUninitialized();
      }
    } else if (event is ClearPrefs) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("homeId", null);
      sharedPreferences.setString("homeName", null);
      sharedPreferences.setString("workId", null);
      sharedPreferences.setString("workName", null);
      dispatch(LoadPrefs());
    }
  }

  @override
  Stream<PrefsState> transform(
    Stream<PrefsEvent> events,
    Stream<PrefsState> Function(PrefsEvent event) next,
  ) {
    return super.transform(
      (events as Observable<PrefsEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

//  getPreferredStations() async {
//    sharedPreferences = await SharedPreferences.getInstance();
//
//    String homeId = sharedPreferences.getString("homeId");
//    String homeName = sharedPreferences.getString("homeName");
//
//    String workId = sharedPreferences.getString("workId");
//    String workName = sharedPreferences.getString("workName");
//
//    dispatch(event)
//  }

//  void _savePreferredStation(StationViewObject station,
//      StationType stationType) async {
//    sharedPreferences = await SharedPreferences.getInstance();
//
//    if (stationType == StationType.home) {
//      sharedPreferences.setString("homeId", station.id);
//      sharedPreferences.setString("homeName", station.name);
//      _homeStationSubject.add(PreferredStationModel(station, stationType));
//    } else {
//      sharedPreferences.setString("workId", station.id);
//      sharedPreferences.setString("workName", station.name);
//      _workStationSubject.add(PreferredStationModel(station, stationType));
//    }
//    sharedPreferences.commit();
//  }
}
