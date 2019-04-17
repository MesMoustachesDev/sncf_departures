import 'package:intl/intl.dart';
import 'package:sncf_schedules/data/model/departures/DeparturesResponse.dart';
import 'package:sncf_schedules/data/model/journey/JourneyResponse.dart';
import 'package:sncf_schedules/presentation/utils/HexToColor.dart';

class JourneyViewObject {
  String time;
  String duration;
  String baseTime;
  String arrivalTime;
  String lineCode;
  HexColor lineColor;
  HexColor lineTextColor;

  JourneyViewObject(final Journeys journey) {
    final e = DateFormat("HH:mm");

    time = e.format(DateTime.parse(journey.departureDateTime));
    arrivalTime = e.format(DateTime.parse(journey.arrivalDateTime));
    duration = "${journey.duration / 60}";

//    lineColor = HexColor(journey.displayInformations.color);
//    lineTextColor = HexColor(departure.displayInformations.textColor);
  }
}
