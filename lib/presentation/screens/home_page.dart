import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_bloc.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_events.dart';
import 'package:sncf_schedules/domain/bloc/prefs/prefs_states.dart';
import 'package:sncf_schedules/presentation/home/widget/departures/departure_page.dart';
import 'package:sncf_schedules/presentation/home/widget/routes/routes_page.dart';
import 'package:sncf_schedules/presentation/utils/arch_sample_keys.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;

  HomeScreen({@required this.onInit})
      : super(key: SncfSchedulesKeys.homeScreen);

  final String departuresTitle = "Départs";
  final String journeysTitle = "Trajets";

  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

//  DeparturesBloc homeDeparturesBloc;
//  DeparturesBloc workDeparturesBloc;
//
//  SearchDeparturesBloc homeSearchDeparturesBloc;
//  SearchDeparturesBloc workSearchDeparturesBloc;
//
//  RoutesBloc homeToWorkRoutesBloc;
//  RoutesBloc workToHomeRoutesBloc;
//
//  PreferredStationModel home;
//  PreferredStationModel work;

  ScrollController _scrollViewController;

  @override
  void initState() {
    super.initState();
//    homeDeparturesBloc = DeparturesBloc();
//    workDeparturesBloc = DeparturesBloc();
//
//    homeToWorkRoutesBloc = RoutesBloc();
//    workToHomeRoutesBloc = RoutesBloc();
//
//    homeSearchDeparturesBloc = SearchDeparturesBloc();
//    workSearchDeparturesBloc = SearchDeparturesBloc();
//
//    preferredStationsBloc.homeStation.listen((data) => updateHome(data));
//    preferredStationsBloc.workStation.listen((data) => updateWork(data));

    _scrollViewController = new ScrollController();
  }

  void updateHome(String station) {
//    setState(() {
//      home = station;
//    });
  }

  void updateWork(String station) {
//    setState(() {
//      work = station;
//    });
  }

  Widget getHomeTab() {
    var title = "Home";
//    if (_selectedIndex == 1) {
//      if (home != null && home.station != null) {
//        title = home.station.name;
//      }
//    } else {
//      if (work != null &&
//          work.station != null &&
//          home != null &&
//          home.station != null) {
//        title = "De ${home.station.name}\nvers ${work.station.name}";
//      }
//    }
    return Tab(icon: Icon(Icons.home), text: title);
  }

  Widget getWorkTab() {
    var title = "Work";
//    if (_selectedIndex == 1) {
//      if (work != null && work.station != null) {
//        title = work.station.name;
//      }
//    } else {
//      if (work != null &&
//          work.station != null &&
//          home != null &&
//          home.station != null) {
//        title = "De ${work.station.name}\nvers ${home.station.name}";
//      }
//    }
    return Tab(icon: Icon(Icons.work), text: title);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> getTabsWidget() {
    if (_selectedIndex == 0) {
      return <Widget>[
        DeparturePage(StationType.home),
        DeparturePage(StationType.work)
      ];
    } else {
      return <Widget>[
        RoutesPage(StationType.home),
        RoutesPage(StationType.work)
//        RoutesParcoursWidget(homeSearchDeparturesBloc, workSearchDeparturesBloc,
//            homeToWorkRoutesBloc, home, work),
//        RoutesParcoursWidget(homeSearchDeparturesBloc, workSearchDeparturesBloc,
//            workToHomeRoutesBloc, work, home)
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

  @override
  Widget build(BuildContext context) {
    final prefsBloc = BlocProvider.of<PrefsBloc>(context);

    return BlocBuilder(
        bloc: prefsBloc,
        builder: (BuildContext context, PrefsState state) {
          if (state is PrefsSet) {
            return DefaultTabController(
                length: 2,
                child: Scaffold(
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
                          icon: Icon(Icons.directions_railway),
                          title: Text('Départs')),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.black54,
                    unselectedItemColor: Colors.black12,
                    onTap: _onItemTapped,
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => prefsBloc.dispatch(ClearPrefs()),
                    tooltip: 'Reset all',
                    child: Icon(Icons.delete),
                  ), // This trailing comma makes auto-formatting nicer for build methods.
                ));
          } else if (state is PrefsUninitialized) {
            return Container();

//            Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (context) {
//                  return SetPrefsScreen(
//                    key: SncfSchedulesKeys.setPrefsScreen,
////                    onSave: (task, note) {
////                      todosBloc.dispatch(
////                        UpdateTodo(
////                          todo.copyWith(task: task, note: note),
////                        ),
////                      );
////                    },
//                  );
//                },
//              ),
//            );
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }
}
