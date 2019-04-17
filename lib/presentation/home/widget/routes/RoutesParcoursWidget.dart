import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/usecase/GetDeparturesBloc.dart';
import 'package:sncf_schedules/domain/usecase/GetRoutesBloc.dart';
import 'package:sncf_schedules/domain/usecase/PreferredStationsBloc.dart';
import 'package:sncf_schedules/domain/usecase/SearchStationsBloc.dart';
import 'package:sncf_schedules/presentation/home/widget/departures/DepartureWidget.dart';
import 'package:sncf_schedules/presentation/home/widget/departures/SearchDepartureWidget.dart';
import 'package:sncf_schedules/presentation/home/widget/routes/RoutesWidget.dart';

class RoutesParcoursWidget extends StatefulWidget {
  RoutesParcoursWidget(
      SearchDeparturesBloc searchDeparturesBloc,
      RoutesBloc routesBloc,
      PreferredStationModel startStation,
      PreferredStationModel stopStation)
      : this.routesBloc = routesBloc,
        this.searchDeparturesBloc = searchDeparturesBloc,
        this.startStation = startStation,
        this.stopStation = stopStation;

  final SearchDeparturesBloc searchDeparturesBloc;
  final RoutesBloc routesBloc;
  final PreferredStationModel startStation;
  final PreferredStationModel stopStation;

  RoutesParcoursState createState() {
    return new RoutesParcoursState();
  }
}

class RoutesParcoursState extends State<RoutesParcoursWidget> {
  Widget getMainWidget() {
//    if (widget.preferredStation == null) {
//      return SearchStationPage(widget.searchDeparturesBloc, widget.stationType);
//    } else {
    return RoutesPage(widget.startStation.station.id,
        widget.stopStation.station.id, widget.routesBloc);
//    }
  }

  @override
  Widget build(BuildContext context) {
    return getMainWidget();
  }
}
