import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/StationViewObject.dart';
import 'package:sncf_schedules/domain/usecase/GetDeparturesBloc.dart';
import 'package:sncf_schedules/domain/usecase/PreferredStationsBloc.dart';
import 'package:sncf_schedules/domain/usecase/SearchStationsBloc.dart';
import 'package:sncf_schedules/presentation/home/widget/DepartureParcoursWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  DeparturesBloc homeDeparturesBloc;
  DeparturesBloc workDeparturesBloc;
  SearchDeparturesBloc homeSearchDeparturesBloc;
  SearchDeparturesBloc workSearchDeparturesBloc;

  PreferredStationModel home;
  PreferredStationModel work;

  @override
  void initState() {
    super.initState();
    homeDeparturesBloc = DeparturesBloc();
    workDeparturesBloc = DeparturesBloc();
    homeSearchDeparturesBloc = SearchDeparturesBloc();
    workSearchDeparturesBloc = SearchDeparturesBloc();

    preferredStationsBloc.homeStation.listen((data) => updateHome(data));
    preferredStationsBloc.workStation.listen((data) => updateWork(data));
  }

  void updateHome(PreferredStationModel station) {
    setState(() {
      home = station;
    });
  }

  void updateWork(PreferredStationModel station) {
    setState(() {
      work = station;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
//    _incrementTest();
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            bottom: TabBar(
              tabs: [Tab(icon: Icon(Icons.home)), Tab(icon: Icon(Icons.work))],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              DepartureParcoursWidget(homeSearchDeparturesBloc,
                  homeDeparturesBloc, home, StationType.home),
              DepartureParcoursWidget(workSearchDeparturesBloc,
                  workDeparturesBloc, work, StationType.work)
            ],
          ),
          floatingActionButton: FloatingActionButton(
//        onPressed: _refresh,
            tooltip: 'Increment',
            child: Icon(Icons.refresh),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  @override
  void dispose() {
    super.dispose();
    homeDeparturesBloc.dispose();
    workDeparturesBloc.dispose();
    homeSearchDeparturesBloc.dispose();
    workSearchDeparturesBloc.dispose();
  }
}
