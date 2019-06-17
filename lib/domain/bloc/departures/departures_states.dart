import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:sncf_schedules/domain/model/departure_view_object.dart';

abstract class DepartureState extends Equatable {
  DepartureState([List props = const []]) : super(props);
}

class DeparturesInitial extends DepartureState {
  @override
  String toString() => 'DeparturesInitial';
}

class DeparturesLoaded extends DepartureState {
  final List<DepartureViewObject> homeToWorkJourneys;
  final List<DepartureViewObject> workToHomeJourneys;

  DeparturesLoaded({
    this.homeToWorkJourneys,
    this.workToHomeJourneys,
  }) : super([homeToWorkJourneys]);

  @override
  String toString() => 'DeparturesLoaded';
}

class DeparturesLoading extends DepartureState {
  @override
  String toString() => 'DeparturesLoading';
}

class DeparturesFailure extends DepartureState {
  final String error;

  DeparturesFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'DeparturesFailure { error: $error }';
}
