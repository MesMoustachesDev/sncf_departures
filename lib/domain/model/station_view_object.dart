import 'package:sncf_schedules/data/model/search/search_response.dart';

class StationViewObject {
  String name;
  String id;

  StationViewObject(final PtObjects fromNetwork) {
    name = fromNetwork.name.split("(")[0];
    id = fromNetwork.id;
  }

  StationViewObject.withStrings(String name, String id) {
    this.name = name.split("(")[0];
    this.id = id;
  }
}
