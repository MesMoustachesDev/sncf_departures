import 'package:intl/intl.dart';
import 'package:sncf_schedules/data/model/departures/DeparturesResponse.dart';
import 'package:sncf_schedules/presentation/utils/HexToColor.dart';

class DepartureViewObject {
  String time;
  String baseTime;
  String arrivalTime;
  String direction;
  String lineCode;
  HexColor lineColor;
  HexColor lineTextColor;

  DepartureViewObject(final Departures departure) {
    final e = DateFormat("HH:mm");
    String name;
    if (departure.displayInformations.code?.isNotEmpty == true)
      name = departure.displayInformations.code;
    else
      name = departure.displayInformations.commercialMode.substring(0, 3);

    if (departure.stopDateTime.baseDepartureDateTime !=
        departure.stopDateTime.departureDateTime) {
      baseTime = e
          .format(DateTime.parse(departure.stopDateTime.baseDepartureDateTime));
    } else {
      baseTime = "";
    }
    time = e.format(DateTime.parse(departure.stopDateTime.departureDateTime));
    arrivalTime =
        e.format(DateTime.parse(departure.stopDateTime.arrivalDateTime));
    direction = departure.route.direction.stopArea.name;
    lineCode = name;
    lineColor = HexColor(departure.displayInformations.color);
//    lineTextColor = HexColor(departure.displayInformations.textColor);
  }
}
