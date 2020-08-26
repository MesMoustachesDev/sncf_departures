import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:sncf_schedules/domain/model/journey_view_object.dart';

abstract class JourneysState extends Equatable {
  JourneysState() : super();
}

class JourneysInitial extends JourneysState {
  @override
  String toString() => 'JourneysInitial';

  @override
  List<Object> get props => ['JourneysInitial'];
}

class JourneysPrefsReady extends JourneysState {
  @override
  String toString() => 'JourneysPrefsReady';

  @override
  List<Object> get props => ['JourneysPrefsReady'];
}

class JourneysLoading extends JourneysState {
  final List<JourneyViewObject> workToHomeJourneys;
  final List<JourneyViewObject> homeToWorkJourneys;

  JourneysLoading({
    this.workToHomeJourneys,
    this.homeToWorkJourneys,
  }) : super();

  @override
  String toString() => 'JourneysLoading';

  @override
  List<Object> get props => [workToHomeJourneys, homeToWorkJourneys];
}

class JourneysLoaded extends JourneysState {
  final List<JourneyViewObject> homeToWorkJourneys;
  final List<JourneyViewObject> workToHomeJourneys;

  JourneysLoaded({
    this.homeToWorkJourneys,
    this.workToHomeJourneys,
  }) : super();

  @override
  String toString() => 'DeparturesLoaded';

  @override
  List<Object> get props => [workToHomeJourneys, homeToWorkJourneys];
}

class JourneysFailure extends JourneysState {
  final String error;

  JourneysFailure({@required this.error}) : super();

  @override
  String toString() => 'JourneysFailure { error: $error }';

  @override
  List<Object> get props => [error];
}
