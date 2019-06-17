import 'package:equatable/equatable.dart';
import 'package:sncf_schedules/domain/model/station_view_object.dart';

abstract class PrefsState extends Equatable {
  PrefsState([List props = const []]) : super(props);
}

class PrefsUninitialized extends PrefsState {
  @override
  String toString() => 'PrefsUninitialized';
}

class PrefsError extends PrefsState {
  final String error;

  PrefsError({
    this.error,
  }) : super([
          error,
        ]);

  @override
  String toString() => 'PostError';
}

class PrefsSet extends PrefsState {
  final StationViewObject home;
  final StationViewObject work;

  PrefsSet({
    this.home,
    this.work,
  }) : super([home, work]);

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
}

class HomeSet extends PrefsState {
  final StationViewObject home;

  HomeSet({
    this.home,
  }) : super([home]);

  PrefsSet copyWith({
    String home,
  }) {
    return PrefsSet(
      home: home ?? this.home,
    );
  }

  @override
  String toString() => 'HomeSet { home: $home }';
}

class WorkSet extends PrefsState {
  final StationViewObject work;

  WorkSet({
    this.work,
  }) : super([work]);

  PrefsSet copyWith({
    String work,
  }) {
    return PrefsSet(
      work: work ?? this.work,
    );
  }

  @override
  String toString() => 'WorkSet { work: $work }';
}

class QueryResultsSet extends PrefsState {
  final List<StationViewObject> homeQueryResult;
  final List<StationViewObject> workQueryResult;

  QueryResultsSet({
    this.homeQueryResult,
    this.workQueryResult,
  }) : super([homeQueryResult, workQueryResult]);

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
}

enum StationType { home, work }
