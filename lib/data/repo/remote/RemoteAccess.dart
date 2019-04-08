import 'package:sncf_schedules/mustachttp/MustacHttp.dart';

class RemoteAccess {
  static MustacHttp getAccess() {
    return MustacHttp.getInstance()
        .setBaseUrl("https://api.sncf.com/v1/coverage/sncf/")
        .setHeader({
      "Authorization":
          "Basic NmVlZTVmMmYtMzU4YS00MjNkLTkzMTctNjVmYTA5NTFhYzEwOg=="
    });
  }
}
