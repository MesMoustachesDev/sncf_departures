import 'package:equatable/equatable.dart';

abstract class JourneysEvent extends Equatable {
  JourneysEvent() : super();
}

class JourneysPrefsReady extends JourneysEvent {
  @override
  String toString() => 'JourneysPrefsReady';

  @override
  List<Object> get props => ['JourneysPrefsReady'];
}

class LoadHomeJourneys extends JourneysEvent {
  @override
  String toString() => 'LoadHomeJourneys';

  @override
  List<Object> get props => ["LoadHomeJourneys"];
}

class LoadWorkJourneys extends JourneysEvent {
  @override
  String toString() => 'LoadWorkJourneys';

  @override
  List<Object> get props => ["LoadWorkJourneys"];
}
