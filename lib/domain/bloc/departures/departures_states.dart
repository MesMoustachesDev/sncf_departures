import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:sncf_schedules/domain/model/departure_view_object.dart';

abstract class DepartureState extends Equatable {
  DepartureState() : super();
}

class DeparturesInitial extends DepartureState {
  @override
  String toString() => 'DeparturesInitial';

  @override
  List<Object> get props => ["DeparturesInitial"];
}

class DeparturesLoaded extends DepartureState {
  final List<DepartureViewObject> homeToWorkJourneys;
  final List<DepartureViewObject> workToHomeJourneys;

  DeparturesLoaded({
    this.homeToWorkJourneys,
    this.workToHomeJourneys,
  }) : super();

  @override
  String toString() => 'DeparturesLoaded';

  @override
  List<Object> get props => [homeToWorkJourneys, workToHomeJourneys];
}

class DeparturesLoading extends DepartureState {
  @override
  String toString() => 'DeparturesLoading';

  @override
  List<Object> get props => ['DeparturesLoading'];
}

class DeparturesFailure extends DepartureState {
  final String error;

  DeparturesFailure({@required this.error}) : super();

  @override
  String toString() => 'DeparturesFailure { error: $error }';

  @override
  List<Object> get props => [error];
}
