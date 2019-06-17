import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sncf_schedules/domain/bloc/journeys/journeys_bloc.dart';
import 'package:sncf_schedules/domain/bloc/journeys/journeys_events.dart';
import 'package:sncf_schedules/domain/bloc/journeys/journeys_states.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_states.dart';
import 'package:sncf_schedules/presentation/home/widget/routes/items/JourneyListIem.dart';

class RoutesPage extends StatefulWidget {
  RoutesPage(StationType stationType) : this.stationType = stationType;

  final StationType stationType;

  RoutesPageState createState() {
    return new RoutesPageState();
  }
}

class RoutesPageState extends State<RoutesPage> {
  JourneysBloc _journeysBloc;

  @override
  void initState() {
    _journeysBloc = BlocProvider.of<JourneysBloc>(context);
    if (widget.stationType == StationType.home) {
      _journeysBloc.dispatch(LoadHomeJourneys());
    } else {
      _journeysBloc.dispatch(LoadWorkJourneys());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _journeysBloc,
        builder: (BuildContext context, JourneysState state) {
          if (widget.stationType == StationType.home &&
              state is JourneysLoaded &&
              state.homeToWorkJourneys != null) {
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black26,
                    ),
                itemCount: state.homeToWorkJourneys.length,
                itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: JourneyListItem(
                        journey: state.homeToWorkJourneys[index])));
          } else if (widget.stationType == StationType.work &&
              state is JourneysLoaded &&
              state.workToHomeJourneys != null) {
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black26,
                    ),
                itemCount: state.workToHomeJourneys.length,
                itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: JourneyListItem(
                        journey: state.workToHomeJourneys[index])));
          } else if (state is JourneysFailure) {
            return Text(state.error.toString());
          } else if (state is JourneysLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        });
  }
}
