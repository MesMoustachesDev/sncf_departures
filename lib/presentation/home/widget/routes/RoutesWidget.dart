import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/DepartureViewObject.dart';
import 'package:sncf_schedules/domain/model/JourneyViewObject.dart';
import 'package:sncf_schedules/domain/usecase/GetDeparturesBloc.dart';
import 'package:sncf_schedules/domain/usecase/GetRoutesBloc.dart';
import 'package:sncf_schedules/presentation/home/widget/departures/items/DepartureListIem.dart';
import 'package:sncf_schedules/presentation/home/widget/routes/items/JourneyListIem.dart';

class RoutesPage extends StatefulWidget {
  RoutesPage(String startStation, String stopStation, RoutesBloc routesBloc)
      : this.startStation = startStation,
        this.stopStation = stopStation,
        this.routesBloc = routesBloc;

  final String startStation;
  final String stopStation;
  final RoutesBloc routesBloc;

  RoutesPageState createState() {
    return new RoutesPageState();
  }
}

class RoutesPageState extends State<RoutesPage> {
  @override
  void initState() {
    super.initState();
    widget.routesBloc.events
        .add(JourneyRequest(widget.startStation, widget.stopStation));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.routesBloc.journeys,
        builder: (context, AsyncSnapshot<List<JourneyViewObject>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black26,
                    ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: JourneyListItem(journey: snapshot.data[index])));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
