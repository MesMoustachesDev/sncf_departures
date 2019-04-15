import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/StationViewObject.dart';
import 'package:sncf_schedules/domain/usecase/GetDeparturesBloc.dart';
import 'package:sncf_schedules/domain/usecase/PreferredStationsBloc.dart';
import 'package:sncf_schedules/domain/usecase/SearchStationsBloc.dart';
import 'package:sncf_schedules/presentation/home/widget/DepartureWidget.dart';
import 'package:sncf_schedules/presentation/home/widget/SearchDepartureWidget.dart';

class DepartureParcoursWidget extends StatefulWidget {
  DepartureParcoursWidget(
      SearchDeparturesBloc searchDeparturesBloc,
      DeparturesBloc departuresBloc,
      PreferredStationModel station,
      StationType stationType)
      : this.departuresBloc = departuresBloc,
        this.searchDeparturesBloc = searchDeparturesBloc,
        this.stationType = stationType,
        this.preferredStation = station;

  final SearchDeparturesBloc searchDeparturesBloc;
  final DeparturesBloc departuresBloc;
  final PreferredStationModel preferredStation;
  final StationType stationType;

  DepartureParcoursState createState() {
    return new DepartureParcoursState();
  }
}

class DepartureParcoursState extends State<DepartureParcoursWidget> {
  Widget getMainWidget() {
    if (widget.preferredStation == null) {
      return SearchStationPage(widget.searchDeparturesBloc, widget.stationType);
    } else {
      return DeparturePage(
          widget.preferredStation.station.id, widget.departuresBloc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return getMainWidget();
  }
}
