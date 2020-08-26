import 'package:equatable/equatable.dart';

abstract class PrefsEvent extends Equatable {
  PrefsEvent() : super();
}

class SetWorkPrefs extends PrefsEvent {
  final String workName;
  final String workId;

  SetWorkPrefs({
    this.workName,
    this.workId,
  }) : super();

  @override
  String toString() => 'SetWorkPrefs';

  @override
  List<Object> get props => [workName, workId];
}

class SetHomePrefs extends PrefsEvent {
  final String homeName;
  final String homeId;

  SetHomePrefs({
    this.homeName,
    this.homeId,
  }) : super();

  @override
  List<Object> get props => [homeName, homeId];

  @override
  String toString() => 'SetHomePrefs';
}

class LoadPrefs extends PrefsEvent {
  @override
  String toString() => 'LoadPrefs';

  @override
  List<Object> get props => ['LoadPrefs'];
}

class ClearPrefs extends PrefsEvent {
  @override
  String toString() => 'clear prefs';

  @override
  List<Object> get props => ['clear prefs'];
}

class SearchHomePrefs extends PrefsEvent {
  final String query;

  SearchHomePrefs({
    this.query,
  }) : super();

  @override
  String toString() => 'SearchHomePrefs';

  @override
  List<Object> get props => [query];
}

class SearchWorkPrefs extends PrefsEvent {
  final String query;

  SearchWorkPrefs({
    this.query,
  }) : super();

  @override
  String toString() => 'SearchWorkPrefs';

  @override
  List<Object> get props => [query];
}
