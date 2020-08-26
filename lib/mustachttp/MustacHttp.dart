import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:sncf_schedules/mustachttp/ParsedResponse.dart';

class MustacHttp {
  static MustacHttp instance;
  static IOClient myClient;
  String baseUrl;
  Map<String, String> headers;

  final int noInternet = 404;

  static MustacHttp getInstance() {
    if (instance == null) {
      instance = MustacHttp();
    }
    // Make sure to replace <YOUR_LOCAL_IP> with
// the external IP of your computer if you're using Android.
// Note that we're using port 8888 which is Charles' default.
    String proxy = Platform.isAndroid ? '10.1.1.191:8888' : 'localhost:8888';
    // Create a new HttpClient instance.
    HttpClient httpClient = new HttpClient();
    // Hook into the findProxy callback to set
// the client's proxy.
    httpClient.findProxy = (uri) {
      return "PROXY $proxy;";
    };

// This is a workaround to allow Charles to receive
// SSL payloads when your app is running on Android.
    httpClient.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => Platform.isAndroid);

// Pass your newly instantiated HttpClient to http.IOClient.
    myClient = IOClient(httpClient);
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
        await myClient.get(urlRequest, headers: headers).catchError((resp) {});

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
