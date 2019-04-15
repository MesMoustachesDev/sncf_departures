import 'dart:async';
import 'package:sncf_schedules/data/model/departures/DeparturesResponse.dart';
import 'package:sncf_schedules/data/model/search/SearchResponse.dart';
import 'package:sncf_schedules/data/repo/remote/RemoteAccess.dart';
import 'package:sncf_schedules/mustachttp/MustacHttp.dart';
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class DeparturesRepository {
  final int NO_INTERNET = 404;

  /// Fetches the books from the Google Books Api with the query parameter being input.
  /// If a book also exists in the local storage (eg. a book with notes/ stars) that version of the book will be used instead
  Future<ParsedResponse<List<Departures>>> getDepartures(
      String start, String time) async {
    ParsedResponse<Map<String, dynamic>> response =
        await RemoteAccess.getAccess().get("stop_areas/$start/departures/",
            {"from_datetime": time, "count": "20"});

    var departureResponse = DeparturesResponse.fromJson(response.body);
    return new ParsedResponse(
        response.statusCode, departureResponse.departures);
  }

  String parseNetworkJourney(jsonBook) {
    return jsonBook['departure_date_time'];
  }
}

class SearchStationRepository {
  final int NO_INTERNET = 404;

  /// Fetches the books from the Google Books Api with the query parameter being input.
  /// If a book also exists in the local storage (eg. a book with notes/ stars) that version of the book will be used instead
  Future<ParsedResponse<List<PtObjects>>> getStations(String query) async {
    ParsedResponse<Map<String, dynamic>> response =
        await RemoteAccess.getAccess().get("pt_objects/", {"q": query});

    var searchResponse = SearchResponse.fromJson(response.body);
    return new ParsedResponse(response.statusCode, searchResponse.ptObjects);
  }

  String parseNetworkJourney(jsonBook) {
    return jsonBook['departure_date_time'];
  }
}

final SearchStationRepository searchStationRepository =
    SearchStationRepository();
final DeparturesRepository departuresRepository = DeparturesRepository();
