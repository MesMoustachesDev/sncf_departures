import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/departure_view_object.dart';

class DepartureListItem extends StatelessWidget {
  DepartureListItem({DepartureViewObject station})
      : station = station,
        super(key: ObjectKey(station));

  final DepartureViewObject station;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different parts of the tree
    // can have different themes.  The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return Colors.black54;
  }

  TextStyle _getTextStyle(BuildContext context, DepartureViewObject station) {
    Color color;

    if (station.lineTextColor != null) {
      color = station.lineTextColor;
    } else if (station.lineColor.isBlack()) {
      color = Colors.black54;
    } else {
      color = Colors.white;
    }
    return TextStyle(color: color);
  }

  Color _getAvatarColor(DepartureViewObject station) {
    Color color;

    color = Colors.white;
    if (station.lineColor.isBlack()) {
    } else {
      color = station.lineColor;
    }
    return color;
  }

  Widget getTime(DepartureViewObject station) {
    if (station.baseTime.isNotEmpty) {
      return new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                margin: const EdgeInsetsDirectional.only(end: 10.0),
                child: Text(station.baseTime,
                    style: TextStyle(
                        color: Colors.black12,
                        decoration: TextDecoration.lineThrough))),
            Text(station.time,
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold)),
          ]);
    } else {
      return Text(station.time, style: TextStyle(color: Colors.black54));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundColor: _getAvatarColor(station),
          child: Text(station.lineCode, style: _getTextStyle(context, station)),
        ),
        title: Text(station.direction, style: TextStyle(color: Colors.black54)),
        subtitle: getTime(station));
  }
}
