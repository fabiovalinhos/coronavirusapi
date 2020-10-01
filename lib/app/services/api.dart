import 'package:flutter/material.dart';

import 'api_keys.dart';

enum EndPoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  final String apiKey;

  API({@required this.apiKey});

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);
  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );

  Uri endpointUri(EndPoint endpoint) {
    Uri(
      scheme: 'https',
      host: host,
      path: _paths[endpoint],
    );
  }

  static Map<EndPoint, String> _paths = {
    EndPoint.cases: "cases",
    EndPoint.casesConfirmed: "casesConfirmed",
    EndPoint.casesSuspected: "casesSuspected",
    EndPoint.deaths: "deaths",
    EndPoint.recovered: "recovered",
  };
}
