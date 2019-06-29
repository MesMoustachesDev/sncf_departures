import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sncf_schedules/domain/bloc/departures/departure_events.dart';
import 'package:sncf_schedules/domain/bloc/departures/departures_bloc.dart';
import 'package:sncf_schedules/domain/bloc/departures/departures_states.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_states.dart';

import 'items/DepartureListIem.dart';

class DeparturePage extends StatefulWidget {
  DeparturePage(StationType stationType) : this.stationType = stationType;

  final StationType stationType;

  DeparturePageState createState() {
    return new DeparturePageState();
  }
}

class DeparturePageState extends State<DeparturePage> {
  DeparturesBloc departuresBloc;

  @override
  void initState() {
    departuresBloc = BlocProvider.of<DeparturesBloc>(context);
    if (widget.stationType == StationType.home) {
      departuresBloc.dispatch(LoadHomeDeparture());
    } else {
      departuresBloc.dispatch(LoadWorkDeparture());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: departuresBloc,
        builder: (BuildContext context, DepartureState state) {
          if (widget.stationType == StationType.home &&
              state is DeparturesLoaded &&
              state.homeToWorkJourneys != null) {
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black26,
                    ),
                itemCount: state.homeToWorkJourneys.length,
                itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DepartureListItem(
                        station: state.homeToWorkJourneys[index])));
          } else if (widget.stationType == StationType.work &&
              state is DeparturesLoaded &&
              state.workToHomeJourneys != null) {
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black26,
                    ),
                itemCount: state.workToHomeJourneys.length,
                itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DepartureListItem(
                        station: state.workToHomeJourneys[index])));
          } else if (state is DeparturesFailure) {
            return Text(state.error.toString());
          } else if (state is DeparturesLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        });
  }
}
