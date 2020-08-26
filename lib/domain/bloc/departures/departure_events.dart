import 'package:equatable/equatable.dart';

abstract class DeparturesEvent extends Equatable {
  DeparturesEvent() : super();
}

class LoadHomeDeparture extends DeparturesEvent {
  @override
  String toString() => 'LoadHomeDeparture';

  @override
  List<Object> get props => ["LoadHomeDeparture"];
}

class LoadWorkDeparture extends DeparturesEvent {
  @override
  String toString() => 'LoadWorkDeparture';

  @override
  List<Object> get props => ["LoadWorkDeparture"];
}
