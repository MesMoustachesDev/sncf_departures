import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_bloc.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_events.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_states.dart';
import 'package:sncf_schedules/domain/model/station_view_object.dart';
import 'package:sncf_schedules/presentation/navigation/navigation.dart';
import 'package:sncf_schedules/presentation/utils/arch_sample_keys.dart';

import 'items/station_list_item.dart';

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

class SetPrefsScreenState extends State<SetPrefsScreen> {
  List<StationViewObject> stations = new List();
  final startController = TextEditingController();
  final stopController = TextEditingController();

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prefsBloc = BlocProvider.of<PrefsBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Choisissez vos gares"),
        ),
        body: new Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: BlocBuilder(
                  bloc: prefsBloc,
                  builder: (BuildContext context, PrefsState state) {
                    if (state is HomeSet) {
                      startController.text = state.home.id;
                    }
                    return TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            hintText: 'Chercher une station'),
                        controller: startController,
                        onChanged: (text) {
                          prefsBloc.dispatch(SearchHomePrefs(query: text));
//                      _refreshStart(text);
                        });
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
              child: BlocBuilder(
                  bloc: prefsBloc,
                  builder: (BuildContext context, PrefsState state) {
                    if (state is WorkSet) {
                      stopController.text = state.work.id;
                    }
                    return TextField(
                        decoration: new InputDecoration(
                            hintText: 'Chercher une station'),
                        controller: stopController,
                        onChanged: (text) {
                          prefsBloc.dispatch(SearchWorkPrefs(query: text));
//                      _refreshStart(text);
                        });
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
