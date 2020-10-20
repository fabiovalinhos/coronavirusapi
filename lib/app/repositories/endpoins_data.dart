import 'package:coronavirusrestapiflutter/app/services/api.dart';
import 'package:coronavirusrestapiflutter/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class EndpointsData {
  final Map<EndPoint, EndpointData> values;

  EndpointsData({@required this.values});

  EndpointData get cases => values[EndPoint.cases];
  EndpointData get casesSuspected => values[EndPoint.casesSuspected];
  EndpointData get casesConfirmed => values[EndPoint.casesConfirmed];
  EndpointData get deaths => values[EndPoint.deaths];
  EndpointData get recovered => values[EndPoint.recovered];

  @override
  String toString() =>
      'cases: $cases , suspected: $casesSuspected, Confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
