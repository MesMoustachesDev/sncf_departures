import 'package:sncf_schedules/mustachttp/MustacHttp.dart' as remote_access;
import 'package:sncf_schedules/mustachttp/MustacHttp.dart';
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class RemoteAccess {
  static MustacHttp instance;

  static remote_access.MustacHttp getAccess() {
    if (instance == null) {
      instance = remote_access.MustacHttp.getInstance()
          .setBaseUrl("https://api.sncf.com/v1/coverage/sncf/")
          .setHeader({
        "Authorization":
            "Basic NmVlZTVmMmYtMzU4YS00MjNkLTkzMTctNjVmYTA5NTFhYzEwOg=="
      });
    }
    return instance;
  }

  static Future<ParsedResponse<Map<String, dynamic>>> getStops(
      String start, String time) {
    return getAccess().get("stop_areas/$start/departures/",
        {"from_datetime": time, "count": "100"});
  }

  static Future<ParsedResponse<Map<String, dynamic>>> getStations(
      String query) {
    return getAccess().get("pt_objects/", {"q": query});
  }

  static Future<ParsedResponse<Map<String, dynamic>>> getRoutes(
      String start, String stop, String time) {
    return getAccess().get("journeys/",
        {"from": start, "to": stop, "datetime": time, "count": "100"});
  }
}
