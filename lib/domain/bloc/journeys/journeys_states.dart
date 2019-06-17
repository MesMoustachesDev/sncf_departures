import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:sncf_schedules/domain/model/journey_view_object.dart';

abstract class JourneysState extends Equatable {
  JourneysState([List props = const []]) : super(props);
}

class JourneysInitial extends JourneysState {
  @override
  String toString() => 'JourneysInitial';
}

class JourneysLoading extends JourneysState {
  final List<JourneyViewObject> workToHomeJourneys;
  final List<JourneyViewObject> homeToWorkJourneys;

  JourneysLoading({
    this.workToHomeJourneys,
    this.homeToWorkJourneys,
  }) : super([workToHomeJourneys, homeToWorkJourneys]);

  @override
  String toString() => 'JourneysLoading';
}

class JourneysLoaded extends JourneysState {
  final List<JourneyViewObject> homeToWorkJourneys;
  final List<JourneyViewObject> workToHomeJourneys;

  JourneysLoaded({
    this.homeToWorkJourneys,
    this.workToHomeJourneys,
  }) : super([homeToWorkJourneys]);

  @override
  String toString() => 'DeparturesLoaded';
}

class JourneysFailure extends JourneysState {
  final String error;

  JourneysFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'JourneysFailure { error: $error }';
}
