import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sncf_schedules/domain/model/StationViewObject.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferredStationsBloc {
  Observable<PreferredStationModel> get homeStation =>
      _homeStationSubject.stream;

  Observable<PreferredStationModel> get workStation =>
      _workStationSubject.stream;

  final _homeStationSubject = BehaviorSubject<PreferredStationModel>();
  final _workStationSubject = BehaviorSubject<PreferredStationModel>();

  SharedPreferences sharedPreferences;
  final homeEvents = StreamController<StationViewObject>();
  final workEvents = StreamController<StationViewObject>();

  PreferredStationsBloc() {
    homeEvents.stream
        .listen((data) => savePreferredStation(data, StationType.home));
    workEvents.stream
        .listen((data) => savePreferredStation(data, StationType.work));
    getPreferredStations();
  }

  void savePreferredStation(
      StationViewObject station, StationType stationType) async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (stationType == StationType.home) {
      sharedPreferences.setString("homeId", station.id);
      sharedPreferences.setString("homeName", station.name);
      _homeStationSubject.add(PreferredStationModel(station, stationType));
    } else {
      sharedPreferences.setString("workId", station.id);
      sharedPreferences.setString("workName", station.name);
      _workStationSubject.add(PreferredStationModel(station, stationType));
    }
    sharedPreferences.commit();
  }

  getPreferredStations() async {
    sharedPreferences = await SharedPreferences.getInstance();

    String homeId = sharedPreferences.getString("homeId");
    String homeName = sharedPreferences.getString("homeName");

    String workId = sharedPreferences.getString("workId");
    String workName = sharedPreferences.getString("workName");

    if (homeId != null && homeName != null) {
      _homeStationSubject.add(PreferredStationModel(
          StationViewObject.withStrings(homeName, homeId), StationType.home));
    }
    if (workId != null && workName != null) {
      _workStationSubject.add(PreferredStationModel(
          StationViewObject.withStrings(workName, workId), StationType.work));
    }
  }

  dispose() {
    _homeStationSubject.close();
    _workStationSubject.close();
    homeEvents.close();
    workEvents.close();
  }

  clearPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("homeId", null);
    sharedPreferences.setString("homeName", null);
    _homeStationSubject.add(PreferredStationModel(null, StationType.home));

    sharedPreferences.setString("workId", null);
    sharedPreferences.setString("workName", null);
    _workStationSubject.add(PreferredStationModel(null, StationType.work));
  }
}

class PreferredStationModel {
  StationViewObject station;
  StationType stationType;

  PreferredStationModel(StationViewObject station, StationType stationType)
      : this.station = station,
        this.stationType = stationType;
}

enum StationType { home, work }

final preferredStationsBloc = PreferredStationsBloc();
