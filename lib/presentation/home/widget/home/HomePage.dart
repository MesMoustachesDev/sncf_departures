import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/StationViewObject.dart';
import 'package:sncf_schedules/domain/usecase/GetDeparturesBloc.dart';
import 'package:sncf_schedules/domain/usecase/GetRoutesBloc.dart';
import 'package:sncf_schedules/domain/usecase/PreferredStationsBloc.dart';
import 'package:sncf_schedules/domain/usecase/SearchStationsBloc.dart';
import 'package:sncf_schedules/presentation/home/widget/departures/DepartureParcoursWidget.dart';
import 'package:sncf_schedules/presentation/home/widget/routes/RoutesParcoursWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  final String departuresTitle = "Départs";
  final String journeysTitle = "Trajets";

  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  DeparturesBloc homeDeparturesBloc;
  DeparturesBloc workDeparturesBloc;

  SearchDeparturesBloc homeSearchDeparturesBloc;
  SearchDeparturesBloc workSearchDeparturesBloc;

  RoutesBloc homeToWorkRoutesBloc;
  RoutesBloc workToHomeRoutesBloc;

  PreferredStationModel home;
  PreferredStationModel work;

  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
    homeDeparturesBloc = DeparturesBloc();
    workDeparturesBloc = DeparturesBloc();

    homeToWorkRoutesBloc = RoutesBloc();
    workToHomeRoutesBloc = RoutesBloc();

    homeSearchDeparturesBloc = SearchDeparturesBloc();
    workSearchDeparturesBloc = SearchDeparturesBloc();

    preferredStationsBloc.homeStation.listen((data) => updateHome(data));
    preferredStationsBloc.workStation.listen((data) => updateWork(data));

    _scrollViewController = new ScrollController();
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

  Widget getHomeTab() {
    var title = "Home";
    if (_selectedIndex == 1) {
      if (home != null && home.station != null) {
        title = home.station.name;
      }
    } else {
      if (work != null &&
          work.station != null &&
          home != null &&
          home.station != null) {
        title = "De ${home.station.name}\nvers ${work.station.name}";
      }
    }
    return Tab(icon: Icon(Icons.home), text: title);
  }

  Widget getWorkTab() {
    var title = "Work";
    if (_selectedIndex == 1) {
      if (work != null && work.station != null) {
        title = work.station.name;
      }
    } else {
      if (work != null &&
          work.station != null &&
          home != null &&
          home.station != null) {
        title = "De ${work.station.name}\nvers ${home.station.name}";
      }
    }
    return Tab(icon: Icon(Icons.work), text: title);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> getTabsWidget() {
    if (_selectedIndex == 1) {
      return <Widget>[
        DepartureParcoursWidget(homeSearchDeparturesBloc, homeDeparturesBloc,
            home, StationType.home),
        DepartureParcoursWidget(workSearchDeparturesBloc, workDeparturesBloc,
            work, StationType.work)
      ];
    } else {
      return <Widget>[
        RoutesParcoursWidget(homeSearchDeparturesBloc, workSearchDeparturesBloc,
            homeToWorkRoutesBloc, home, work),
        RoutesParcoursWidget(homeSearchDeparturesBloc, workSearchDeparturesBloc,
            workToHomeRoutesBloc, work, home)
      ];
    }
  }

  Text getTitle() {
    if (_selectedIndex == 0) {
      return Text("Trajets");
    } else {
      return Text("Départs en gare");
    }
  }

  void deletePrefs() {
    preferredStationsBloc.clearPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
//          appBar: AppBar(
//            title: getTitle(),
//            bottom: TabBar(
//              tabs: [getHomeTab(), getWorkTab()],
//            ),
//          ),
          body: new NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  title: getTitle(),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: new TabBar(
                    tabs: <Tab>[getHomeTab(), getWorkTab()],
                  ),
                ),
              ];
            },
            body: new TabBarView(
              children: getTabsWidget(),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.transfer_within_a_station),
                  title: Text('Trajets')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.directions_railway), title: Text('Départs')),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black54,
            unselectedItemColor: Colors.black12,
            onTap: _onItemTapped,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => deletePrefs(),
            tooltip: 'Reset all',
            child: Icon(Icons.delete),
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
    _scrollViewController.dispose();
  }
}
