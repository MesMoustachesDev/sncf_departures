import 'package:intl/intl.dart';
import 'package:sncf_schedules/data/model/departures/DeparturesResponse.dart';
import 'package:sncf_schedules/data/model/journey/JourneyResponse.dart';
import 'package:sncf_schedules/presentation/utils/HexToColor.dart';

class JourneyViewObject {
  String departureTime;
  String duration;
  String arrivalTime;

  List<SectionViewObject> sections;

  JourneyViewObject(final Journeys journey) {
    final e = DateFormat("HH:mm");

    departureTime = e.format(DateTime.parse(journey.departureDateTime));
    arrivalTime = e.format(DateTime.parse(journey.arrivalDateTime));
    duration = "${journey.duration ~/ 60} min";

    sections = journey.sections
        .where((section) => section.duration > 0)
        .map((section) => new SectionViewObject(section));

//    lineColor = HexColor(journey.displayInformations.color);
//    lineTextColor = HexColor(departure.displayInformations.textColor);
  }
}

class SectionViewObject {
  String from;
  String to;
  String departureTime;
  String arrivalTime;

  int lineColor;
  int lineTextColor;

  SectionViewObject(Sections section) {
    from = section.from.name;
    to = section.to.name;

    arrivalTime = section.arrivalDateTime;
    departureTime = section.departureDateTime;

    lineColor = HexColor(section..color);
    lineTextColor = HexColor(departure.displayInformations.textColor);
  }
}
