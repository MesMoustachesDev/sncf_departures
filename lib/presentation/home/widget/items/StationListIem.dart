import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/DepartureViewObject.dart';
import 'package:sncf_schedules/domain/model/StationViewObject.dart';

class StationListItem extends StatelessWidget {
  StationListItem({StationViewObject station})
      : station = station,
        super(key: ObjectKey(station));

  final StationViewObject station;

  TextStyle _getTextStyle(BuildContext context, StationViewObject station) {
    Color color;
    color = Colors.black54;
    return TextStyle(color: color);
  }

  @override
  Widget build(BuildContext context) {
    return Text(station.name, style: _getTextStyle(context, station));
  }
}
