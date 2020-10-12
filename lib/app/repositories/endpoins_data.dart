import 'package:coronavirusrestapiflutter/app/services/api.dart';
import 'package:flutter/foundation.dart';

class EndpointsData {
  final Map<EndPoint, int> values;

  EndpointsData({@required this.values});

  int get cases => values[EndPoint.cases];
  int get casesSuspected => values[EndPoint.casesSuspected];
  int get casesConfirmed => values[EndPoint.casesConfirmed];
  int get deaths => values[EndPoint.deaths];
  int get recovered => values[EndPoint.recovered];

  @override
  String toString() =>
      'cases: $cases , suspected: $casesSuspected, Confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
