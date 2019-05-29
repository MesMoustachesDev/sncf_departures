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
    int durationMin = journey.duration ~/ 60;
    int durationHour = durationMin ~/ 60;
    // ignore: unnecessary_brace_in_string_interps
    final formatter = new NumberFormat("00");
    duration = "${durationHour}h${formatter.format(durationMin % 60)}min";

    sections = journey.sections
        .where((section) => section.duration != null)
        .where((section) => section.duration > 0)
        .where((section) => section.from != null)
        .where((section) => section.to != null)
        .where((section) => section.displayInformation != null)
        .map((section) => new SectionViewObject(section))
        .toList();

//    lineColor = HexColor(journey.displayInformations.color);
//    lineTextColor = HexColor(departure.displayInformations.textColor);
  }
}

class SectionViewObject {
  String from;
  String to;
  String departureTime;
  String arrivalTime;

  HexColor lineColor;
  HexColor lineTextColor;

  SectionViewObject(Sections section) {
    final e = DateFormat("HH:mm");
    departureTime = e.format(DateTime.parse(section.departureDateTime));
    arrivalTime = e.format(DateTime.parse(section.arrivalDateTime));

    from = section.from.name.split("(")[0];
    to = section.to.name.split("(")[0];

    lineColor = HexColor(section.displayInformation.color);
    lineTextColor = HexColor(section.displayInformation.color);
  }
}
