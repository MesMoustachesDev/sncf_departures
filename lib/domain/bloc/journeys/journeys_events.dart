import 'package:equatable/equatable.dart';

abstract class JourneysEvent extends Equatable {
  JourneysEvent() : super();
}

class LoadHomeJourneys extends JourneysEvent {
  @override
  String toString() => 'LoadHomeJourneys';
}

class LoadWorkJourneys extends JourneysEvent {
  @override
  String toString() => 'LoadWorkJourneys';
}
