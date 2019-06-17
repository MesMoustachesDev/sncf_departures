import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_bloc.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_events.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_states.dart';
import 'package:sncf_schedules/domain/model/station_view_object.dart';
import 'package:sncf_schedules/presentation/home/widget/items/station_list_item.dart';
import 'package:sncf_schedules/presentation/navigation/navigation.dart';
import 'package:sncf_schedules/presentation/utils/arch_sample_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

typedef OnSaveCallback = Function(String task, String note);

class SetPrefsScreen extends StatefulWidget {
//  final OnSaveCallback onSave;
  final void Function() onInit;

  SetPrefsScreen({
    @required this.onInit,
    Key key,
//    @required this.onSave,
  }) : super(key: key ?? SncfSchedulesKeys.setPrefsScreen);

  @override
  SetPrefsScreenState createState() {
    return new SetPrefsScreenState();
  }
}

//class SetPrefsScreen extends StatefulWidget {
//  SetPrefsScreen(
//      SearchDeparturesBloc searchStartBloc, SearchDeparturesBloc searchStopBloc)
//      : this.searchStartBloc = searchStartBloc,
//        this.searchStopBloc = searchStopBloc;
//
//  final SearchDeparturesBloc searchStartBloc;
//  final SearchDeparturesBloc searchStopBloc;
//
//  SetPrefsScreenState createState() {
//    return new SetPrefsScreenState();
//  }
//}

class SetPrefsScreenState extends State<SetPrefsScreen> {
  StationViewObject _home;
  StationViewObject _work;

  List<StationViewObject> stations = new List();
  final startController = TextEditingController();
  final stopController = TextEditingController();

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

//  void _refreshStart(String query) {
//    widget.searchStartBloc.fetchDepartures(query);
//  }

//  void _refreshStop(String query) {
//    widget.searchStopBloc.fetchDepartures(query);
//  }

//  void _saveNewPref(StationViewObject station, StationType type) {
//    if (type == StationType.home) {
//      preferredStationsBloc.homeEvents.add(station);
//    } else if (type == StationType.work) {
//      preferredStationsBloc.workEvents.add(station);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    final prefsBloc = BlocProvider.of<PrefsBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Enon"),
        ),
        body: new Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: TextField(
                  decoration:
                      new InputDecoration(hintText: 'Chercher une station'),
                  controller: startController,
                  onChanged: (text) {
                    prefsBloc.dispatch(SearchHomePrefs(query: text));
//                      _refreshStart(text);
                  })),
          Container(
              height: 200,
              width: 300,
//          fit: FlexFit.tight,
              child: BlocBuilder(
                  bloc: prefsBloc,
                  builder: (BuildContext context, PrefsState state) {
                    {
                      if (state is QueryResultsSet &&
                          state.homeQueryResult != null) {
                        return Card(
                            child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                      color: Colors.black26,
                                    ),
                                itemCount: state.homeQueryResult.length,
                                itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                        child: StationListItem(
                                            station:
                                                state.homeQueryResult[index]),
                                        onTap: () => prefsBloc.dispatch(
                                            SetHomePrefs(
                                                homeId: state
                                                    .homeQueryResult[index].id,
                                                homeName: state
                                                    .homeQueryResult[index]
                                                    .name))))));
                      } else if (state is PrefsSet) {
                        print("pushing home");
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushReplacementNamed(
                              context, Navigation.home);
                        });
                        return Container();
                      } else if (state is PrefsError) {
                        return Text(state.error);
                      } else {
                        return Container();
                      }
                    }
                  })),
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: TextField(
                  decoration:
                      new InputDecoration(hintText: 'Chercher une station'),
                  controller: stopController,
                  onChanged: (text) {
                    prefsBloc.dispatch(SearchWorkPrefs(query: text));
                  })),
          Container(
              height: 200,
              width: 300,
//          fit: FlexFit.tight,
              child: BlocBuilder(
                  bloc: prefsBloc,
                  builder: (BuildContext context, PrefsState state) {
                    if (state is QueryResultsSet &&
                        state.workQueryResult != null) {
                      return Card(
                          child: ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                    color: Colors.black26,
                                  ),
                              itemCount: state.workQueryResult.length,
                              itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                      child: StationListItem(
                                          station:
                                              state.workQueryResult[index]),
                                      onTap: () => prefsBloc.dispatch(
                                          SetWorkPrefs(
                                              workId: state
                                                  .workQueryResult[index].id,
                                              workName: state
                                                  .workQueryResult[index]
                                                  .name))))));
                    } else if (state is PrefsError) {
                      return Text(state.error);
                    } else {
                      return Container();
                    }
                  }))
        ]));
  }
}
