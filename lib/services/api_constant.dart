import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

String apiUrl = "fakestoreapi.com";

String unicodeConverter(String code) {
  return String.fromCharCodes(Runes(code));
}

class ApiBase {
  static url({required String extendedURL}) {
    if (kDebugMode) {
      log("https://$apiUrl$extendedURL");
    }

    return Uri.parse("https://$apiUrl$extendedURL");
  }

// get request can use for all get request
  static Future<http.Response> getRequest(
      {required String extendedURL, String? token}) async {
    var client = http.Client();
    Map<String, String> newHeaders = {};
    Map<String, String> conentType = {'Content-Type': 'application/json'};

    newHeaders.addAll(conentType);

    if (kDebugMode) {
      log(extendedURL.toString());
    }
    return client.get(url(extendedURL: extendedURL.trim()),
        headers: newHeaders);
  }
}
