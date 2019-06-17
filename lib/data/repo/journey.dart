import 'dart:async';
import 'package:sncf_schedules/data/repo/remote/remote_access.dart';
import 'package:sncf_schedules/mustachttp/MustacHttp.dart';
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class JourneyRepository {
  final int NO_INTERNET = 404;

  /// Fetches the books from the Google Books Api with the query parameter being input.
  /// If a book also exists in the local storage (eg. a book with notes/ stars) that version of the book will be used instead
  Future<ParsedResponse<List<String>>> getJourneys() async {
    ParsedResponse<Map<String, dynamic>> response =
        await RemoteAccess.getAccess().get("/journeys", {
      "from": "admin:fr:75056",
      "to": "admin:fr:69123",
      "datetime": "20190401T192805"
    });

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
