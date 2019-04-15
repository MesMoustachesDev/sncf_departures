import 'package:sncf_schedules/data/model/search/SearchResponse.dart';

class StationViewObject {
  String name;
  String id;

  StationViewObject(final PtObjects fromNetwork) {
    name = fromNetwork.name;
    id = fromNetwork.id;
  }

  StationViewObject.withStrings(String name, String id) {
    this.name = name;
    this.id = id;
  }
}
