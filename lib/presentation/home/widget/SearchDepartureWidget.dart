import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/StationViewObject.dart';
import 'package:sncf_schedules/domain/usecase/PreferredStationsBloc.dart';
import 'package:sncf_schedules/domain/usecase/SearchStationsBloc.dart';
import 'package:sncf_schedules/presentation/home/items/StationListIem.dart';

class SearchStationPage extends StatefulWidget {
  SearchStationPage(SearchDeparturesBloc searchDeparturesBloc, StationType type)
      : this.searchDeparturesBloc = searchDeparturesBloc,
        this.type = type;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final SearchDeparturesBloc searchDeparturesBloc;
  final StationType type;

  SearchStationPageState createState() {
    return new SearchStationPageState();
  }
}

class SearchStationPageState extends State<SearchStationPage> {
  List<StationViewObject> stations = new List();
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _refresh(String query) {
    widget.searchDeparturesBloc.fetchDepartures(query);
  }

  void _saveNewPref(StationViewObject station) {
    if (widget.type == StationType.home) {
      preferredStationsBloc.homeEvents.add(station);
    } else if (widget.type == StationType.work) {
      preferredStationsBloc.workEvents.add(station);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      TextField(
          controller: myController,
          onChanged: (text) {
            _refresh(text);
          }),
      Flexible(
          fit: FlexFit.tight,
          child: StreamBuilder(
              stream: widget.searchDeparturesBloc.allResults,
              builder:
                  (context, AsyncSnapshot<List<StationViewObject>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            color: Colors.black26,
                          ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: GestureDetector(
                              child: StationListItem(
                                  station: snapshot.data[index]),
                              onTap: () =>
                                  _saveNewPref(snapshot.data[index]))));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Container();
                }
              }))
    ]);
  }
}
