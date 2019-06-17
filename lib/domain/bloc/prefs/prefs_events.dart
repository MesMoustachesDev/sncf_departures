import 'package:equatable/equatable.dart';

abstract class PrefsEvent extends Equatable {
  PrefsEvent([List props = const []]) : super(props);
}

class SetWorkPrefs extends PrefsEvent {
  final String workName;
  final String workId;

  SetWorkPrefs({
    this.workName,
    this.workId,
  }) : super([workName, workId]);

  @override
  String toString() => 'SetWorkPrefs';
}

class SetHomePrefs extends PrefsEvent {
  final String homeName;
  final String homeId;

  SetHomePrefs({
    this.homeName,
    this.homeId,
  }) : super([homeName, homeId]);

  @override
  String toString() => 'SetHomePrefs';
}

class LoadPrefs extends PrefsEvent {
  @override
  String toString() => 'LoadPrefs';
}

class ClearPrefs extends PrefsEvent {
  @override
  String toString() => 'clear prefs';
}

class SearchHomePrefs extends PrefsEvent {
  final String query;

  SearchHomePrefs({
    this.query,
  }) : super([
          query,
        ]);

  @override
  String toString() => 'SearchHomePrefs';
}

class SearchWorkPrefs extends PrefsEvent {
  final String query;

  SearchWorkPrefs({
    this.query,
  }) : super([
          query,
        ]);

  @override
  String toString() => 'SearchWorkPrefs';
}
