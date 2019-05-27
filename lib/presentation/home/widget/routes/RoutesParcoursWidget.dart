import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/usecase/GetDeparturesBloc.dart';
import 'package:sncf_schedules/domain/usecase/GetRoutesBloc.dart';
import 'package:sncf_schedules/domain/usecase/PreferredStationsBloc.dart';
import 'package:sncf_schedules/domain/usecase/SearchStationsBloc.dart';
import 'package:sncf_schedules/presentation/home/widget/departures/DepartureWidget.dart';
import 'package:sncf_schedules/presentation/home/widget/departures/SearchDepartureWidget.dart';
import 'package:sncf_schedules/presentation/home/widget/routes/RoutesWidget.dart';
import 'package:sncf_schedules/presentation/home/widget/routes/SearchRouteWidget.dart';

class RoutesParcoursWidget extends StatefulWidget {
  RoutesParcoursWidget(
      SearchDeparturesBloc searchStartStationBloc,
      SearchDeparturesBloc searchStopStationBloc,
      RoutesBloc routesBloc,
      PreferredStationModel startStation,
      PreferredStationModel stopStation)
      : this.routesBloc = routesBloc,
        this.searchStartStationBloc = searchStartStationBloc,
        this.searchStopStationBloc = searchStopStationBloc,
        this.stopStation = stopStation,
        this.startStation = startStation;

  final SearchDeparturesBloc searchStartStationBloc;
  final SearchDeparturesBloc searchStopStationBloc;
  final PreferredStationModel stopStation;
  final PreferredStationModel startStation;
  final RoutesBloc routesBloc;

  RoutesParcoursState createState() {
    return new RoutesParcoursState();
  }
}

class RoutesParcoursState extends State<RoutesParcoursWidget> {
  Widget getMainWidget() {
    if (widget.startStation == null || widget.stopStation == null) {
      return SearchRouteWidget(
          widget.searchStartStationBloc, widget.searchStopStationBloc);
    } else {
      return RoutesPage(widget.startStation.station.id,
          widget.stopStation.station.id, widget.routesBloc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return getMainWidget();
  }
}
