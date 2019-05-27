import 'package:flutter/material.dart';
import 'package:sncf_schedules/domain/model/DepartureViewObject.dart';
import 'package:sncf_schedules/domain/usecase/GetDeparturesBloc.dart';
import 'package:sncf_schedules/presentation/home/widget/departures/items/DepartureListIem.dart';

class DeparturePage extends StatefulWidget {
  DeparturePage(String station, DeparturesBloc departuresBloc)
      : this.station = station,
        this.departuresBloc = departuresBloc;

  final String station;
  final DeparturesBloc departuresBloc;

  DeparturePageState createState() {
    return new DeparturePageState();
  }
}

class DeparturePageState extends State<DeparturePage> {
  @override
  void initState() {
    super.initState();
    widget.departuresBloc.events.add(widget.station);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.departuresBloc.allDepartures,
        builder: (context, AsyncSnapshot<List<DepartureViewObject>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black26,
                    ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DepartureListItem(station: snapshot.data[index])));
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
