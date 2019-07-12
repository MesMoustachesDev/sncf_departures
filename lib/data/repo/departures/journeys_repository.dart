import 'dart:async';
import 'package:sncf_schedules/data/model/departures/departures_response.dart';
import 'package:sncf_schedules/data/model/journey/journey_response.dart';
import 'package:sncf_schedules/data/model/search/search_response.dart';
import 'package:sncf_schedules/data/repo/remote/remote_data_source.dart';
import 'package:sncf_schedules/mustachttp/MustacHttp.dart';
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class RoutesRepository {
  /// Fetches the books from the Google Books Api with the query parameter being input.
  /// If a book also exists in the local storage (eg. a book with notes/ stars) that version of the book will be used instead
  Future<ParsedResponse<List<Journeys>>> getRoutes(
      String start, String stop, String time) async {
    ParsedResponse<Map<String, dynamic>> response =
        await RemoteAccess.getRoutes(start, stop, time);

    var departureResponse = JourneyResponse.fromJson(response.body);
    return new ParsedResponse(response.statusCode, departureResponse.journeys);
  }
}

final RoutesRepository routesRepository = RoutesRepository();
