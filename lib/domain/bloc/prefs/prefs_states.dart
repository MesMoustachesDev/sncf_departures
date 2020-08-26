import 'package:equatable/equatable.dart';
import 'package:sncf_schedules/domain/model/station_view_object.dart';

abstract class PrefsState extends Equatable {
  PrefsState() : super();
}

class PrefsUninitialized extends PrefsState {
  @override
  String toString() => 'PrefsUninitialized';

  @override
  List<Object> get props => ['PrefsUninitialized'];
}

class PrefsError extends PrefsState {
  final String error;

  PrefsError({
    this.error,
  }) : super();

  @override
  String toString() => 'PostError';

  @override
  List<Object> get props => [error];
}

class PrefsLoading extends PrefsState {
  @override
  String toString() => 'PrefsLoading';

  @override
  List<Object> get props => ['PrefsLoading'];
}

class PrefsSet extends PrefsState {
  final StationViewObject home;
  final StationViewObject work;

  PrefsSet({
    this.home,
    this.work,
  }) : super();

  PrefsSet copyWith({
    String home,
    String work,
  }) {
    return PrefsSet(
      home: home ?? this.home,
      work: work ?? this.work,
    );
  }

  @override
  String toString() => 'PrefsSet';

  @override
  List<Object> get props => [home, work];
}

class HomeSet extends PrefsState {
  final StationViewObject home;

  HomeSet({
    this.home,
  }) : super();

  PrefsSet copyWith({
    String home,
  }) {
    return PrefsSet(
      home: home ?? this.home,
    );
  }

  @override
  String toString() => 'HomeSet { home: $home }';

  @override
  List<Object> get props => [home];
}

class WorkSet extends PrefsState {
  final StationViewObject work;

  WorkSet({
    this.work,
  }) : super();

  PrefsSet copyWith({
    String work,
  }) {
    return PrefsSet(
      work: work ?? this.work,
    );
  }

  @override
  String toString() => 'WorkSet { work: $work }';

  @override
  List<Object> get props => [work];

}

class QueryResultsSet extends PrefsState {
  final List<StationViewObject> homeQueryResult;
  final List<StationViewObject> workQueryResult;

  QueryResultsSet({
    this.homeQueryResult,
    this.workQueryResult,
  }) : super();

  QueryResultsSet copyWith({
    String home,
    String work,
  }) {
    return QueryResultsSet(
      homeQueryResult: homeQueryResult ?? this.homeQueryResult,
      workQueryResult: workQueryResult ?? this.workQueryResult,
    );
  }

  @override
  String toString() => 'QueryResultsSet';

  @override
  List<Object> get props => [homeQueryResult, workQueryResult];
}

enum StationType { home, work }
