import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class MustacHttp {
  static MustacHttp instance;
  String baseUrl;
  Map<String, String> headers;

  final int noInternet = 404;

  static MustacHttp getInstance() {
    if (instance == null) {
      instance = MustacHttp();
    }
    return instance;
  }

  MustacHttp setBaseUrl(String baseUrl) {
    instance.baseUrl = baseUrl;
    return instance;
  }

  MustacHttp setHeader(Map<String, String> headers) {
    instance.headers = headers;
    return instance;
  }

  Future<ParsedResponse<Map<String, dynamic>>> get(
      String path, Map<String, String> args) async {
    String urlRequest = baseUrl + path;

    if (args != null) {
      var keys = args.keys.toList();
      if (keys.isNotEmpty) {
        urlRequest += "?" + keys[0] + "=" + args[keys[0]];
        for (int index = 1; index < keys.length; index++) {
          String value = keys[index];
          urlRequest += "&" + value + "=" + args[value];
        }
      }
    }
    http.Response response =
        await http.get(urlRequest, headers: headers).catchError((resp) {});

    if (response == null) {
      return new ParsedResponse(noInternet, null);
    }

    //If there was an error return an empty list
    if (response.statusCode < 200 || response.statusCode >= 300) {
      return new ParsedResponse(response.statusCode, null);
    }

    return new ParsedResponse(response.statusCode, jsonDecode(response.body));
  }
}
