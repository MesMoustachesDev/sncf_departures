import 'package:equatable/equatable.dart';

abstract class DeparturesEvent extends Equatable {
  DeparturesEvent() : super();
}

class LoadHomeDeparture extends DeparturesEvent {
  @override
  String toString() => 'LoadHomeDeparture';
}

class LoadWorkDeparture extends DeparturesEvent {
  @override
  String toString() => 'LoadWorkDeparture';
}
