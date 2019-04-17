import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/JourneyViewObject.dart';

class JourneyListItem extends StatelessWidget {
  JourneyListItem({JourneyViewObject journey})
      : journey = journey,
        super(key: ObjectKey(journey));

  final JourneyViewObject journey;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different parts of the tree
    // can have different themes.  The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return Colors.black54;
  }

  TextStyle _getTextStyle(BuildContext context, JourneyViewObject journey) {
    Color color;
    color = Colors.black54;

    return TextStyle(color: color);
  }

  Color _getAvatarColor(JourneyViewObject journey) {
    Color color;

    color = Colors.white;

    return color;
  }

  Widget getTime(JourneyViewObject station) {
    if (station.arrivalTime.isNotEmpty) {
      return new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                margin: const EdgeInsetsDirectional.only(end: 10.0),
                child: Text(station.arrivalTime,
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
          backgroundColor: _getAvatarColor(journey),
          child: Text(journey.duration, style: _getTextStyle(context, journey)),
        ),
        title: Text(journey.time, style: TextStyle(color: Colors.black54)),
        subtitle: getTime(journey));
  }
}
