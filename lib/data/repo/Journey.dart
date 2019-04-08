import 'dart:async';
import 'package:sncf_schedules/data/repo/remote/RemoteAccess.dart';
import 'package:sncf_schedules/mustachttp/MustacHttp.dart';
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class JourneyRepository {
  final int NO_INTERNET = 404;

  /// Fetches the books from the Google Books Api with the query parameter being input.
  /// If a book also exists in the local storage (eg. a book with notes/ stars) that version of the book will be used instead
  Future<ParsedResponse<List<String>>> getJourneys() async {
    ParsedResponse<Map<String, dynamic>> response = await RemoteAccess.getAccess().get("/journeys", {
      "from": "admin:fr:75056",
      "to": "admin:fr:69123",
      "datetime": "20190401T192805"
    });

//    //http request, catching error like no internet connection.
//    //If no internet is available for example response is
//    //TODO restricted language to english, feel free to remove that
//    http.Response response = await http.get(
//        "https://api.sncf.com/v1/coverage/sncf/journeys?from=admin:fr:75056&to=admin:fr:69123&datetime=20190401T192805",
//        headers: {
//          "Authorization":
//              "Basic NmVlZTVmMmYtMzU4YS00MjNkLTkzMTctNjVmYTA5NTFhYzEwOg=="
//        }).catchError((resp) {});
//
//    if (response == null) {
//      return new ParsedResponse(NO_INTERNET, []);
//    }
//
//    //If there was an error return an empty list
//    if (response.statusCode < 200 || response.statusCode >= 300) {
//      return new ParsedResponse(response.statusCode, []);
//    }
    // Decode and go to the items part where the necessary book information is
    List<dynamic> list = response.body['journeys'];

    List<String> networkBooks = new List<String>();

    for (dynamic jsonBook in list) {
      String book = parseNetworkJourney(jsonBook);
      networkBooks.add(book);
    }

    return new ParsedResponse(response.statusCode, []..addAll(networkBooks));
  }

  String parseNetworkJourney(jsonBook) {
    return jsonBook['departure_date_time'];
  }
}
