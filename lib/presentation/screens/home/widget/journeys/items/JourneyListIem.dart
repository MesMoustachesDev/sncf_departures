import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/journey_view_object.dart';

class JourneyListItem extends StatelessWidget {
  JourneyListItem({JourneyViewObject journey})
      : journey = journey,
        super(key: ObjectKey(journey));

  final JourneyViewObject journey;

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

  Widget getSections(JourneyViewObject station) {
    return Container(
        height: 80,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: station.sections.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.fromLTRB(0.0, 8.0, 16.0, 8.0),
                child: SectionListItem(section: station.sections[index]))));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundColor: _getAvatarColor(journey),
          child: Text(journey.departureTime,
              style: _getTextStyle(context, journey)),
        ),
        title: Text(journey.duration,
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
        subtitle: getSections(journey));
  }
}

class SectionListItem extends StatelessWidget {
  SectionListItem({SectionViewObject section})
      : section = section,
        super(key: ObjectKey(section));

  final SectionViewObject section;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${section.departureTime} -> ${section.arrivalTime}"),
          Text(section.from),
          Text("|"),
          Text(section.to),
        ]);
  }
}
