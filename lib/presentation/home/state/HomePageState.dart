import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/DepartureViewObject.dart';
import 'package:sncf_schedules/domain/usecase/GetDeparturesUseCase.dart';
import 'package:sncf_schedules/presentation/home/items/DepartureListIem.dart';
import 'package:sncf_schedules/presentation/home/widget/HomePage.dart';

class MyHomePageState extends State<MyHomePage> {
  List<DepartureViewObject> stations = new List();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    GetDeparturesUseCase().execute().then((it) {
      setState(() {
        stations = it;
      });
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
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
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
      ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black26,
        ),
        itemCount: stations.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.all(8.0),
          child: DepartureListItem(
              station: stations[index]
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}