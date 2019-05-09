import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/StationViewObject.dart';
import 'package:sncf_schedules/domain/usecase/PreferredStationsBloc.dart';
import 'package:sncf_schedules/domain/usecase/SearchStationsBloc.dart';
import 'package:sncf_schedules/presentation/home/items/StationListIem.dart';

class SearchRouteWidget extends StatefulWidget {
  SearchRouteWidget(
      SearchDeparturesBloc searchStartBloc, SearchDeparturesBloc searchStopBloc)
      : this.searchStartBloc = searchStartBloc,
        this.searchStopBloc = searchStopBloc;

  final SearchDeparturesBloc searchStartBloc;
  final SearchDeparturesBloc searchStopBloc;

  SearchRouteWidgetState createState() {
    return new SearchRouteWidgetState();
  }
}

class SearchRouteWidgetState extends State<SearchRouteWidget> {
  List<StationViewObject> stations = new List();
  final startController = TextEditingController();
  final stopController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _refreshStart(String query) {
    widget.searchStartBloc.fetchDepartures(query);
  }

  void _refreshStop(String query) {
    widget.searchStopBloc.fetchDepartures(query);
  }

  void _saveNewPref(StationViewObject station, StationType type) {
    if (type == StationType.home) {
      preferredStationsBloc.homeEvents.add(station);
    } else if (type == StationType.work) {
      preferredStationsBloc.workEvents.add(station);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: TextField(
              decoration: new InputDecoration(hintText: 'Chercher une station'),
              controller: startController,
              onChanged: (text) {
                _refreshStart(text);
              })),
      Container(
          height: 200,
          width: 300,
//          fit: FlexFit.tight,
          child: StreamBuilder(
              stream: widget.searchStartBloc.allResults,
              builder:
                  (context, AsyncSnapshot<List<StationViewObject>> snapshot) {
                if (snapshot.hasData) {
                  return Card(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.black26,
                              ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  child: StationListItem(
                                      station: snapshot.data[index]),
                                  onTap: () => _saveNewPref(
                                      snapshot.data[index],
                                      StationType.home)))));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Container();
                }
              })),
      Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: TextField(
              decoration: new InputDecoration(hintText: 'Chercher une station'),
              controller: stopController,
              onChanged: (text) {
                _refreshStop(text);
              })),
      Container(
          height: 200,
          width: 300,
//          fit: FlexFit.tight,
          child: StreamBuilder(
              stream: widget.searchStopBloc.allResults,
              builder:
                  (context, AsyncSnapshot<List<StationViewObject>> snapshot) {
                if (snapshot.hasData) {
                  return Card(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.black26,
                              ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  child: StationListItem(
                                      station: snapshot.data[index]),
                                  onTap: () => _saveNewPref(
                                      snapshot.data[index],
                                      StationType.work)))));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Container();
                }
              }))
    ]);
  }
}
