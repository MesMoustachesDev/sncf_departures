import 'package:sncf_schedules/mustachttp/MustacHttp.dart' as remote_access;

class RemoteAccess {
  static remote_access.MustacHttp getAccess() {
    return remote_access.MustacHttp.getInstance()
        .setBaseUrl("https://api.sncf.com/v1/coverage/sncf/")
        .setHeader({
      "Authorization":
          "Basic NmVlZTVmMmYtMzU4YS00MjNkLTkzMTctNjVmYTA5NTFhYzEwOg=="
    });
  }
}
