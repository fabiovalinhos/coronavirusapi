import 'package:coronavirusrestapiflutter/app/repositories/endpoins_data.dart';
import 'package:coronavirusrestapiflutter/app/services/api.dart';
import 'package:coronavirusrestapiflutter/app/services/api_service.dart';
import 'package:coronavirusrestapiflutter/app/services/data_cache_service.dart';
import 'package:coronavirusrestapiflutter/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIService apiService;
  final DataCacheService dataCacheService;
  DataRepository({@required this.apiService, @required this.dataCacheService});

  String _accessToken;

  Future<EndpointData> getEndpointData(EndPoint endpoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await apiService.getEndPointData(
          accessToken: _accessToken, endpoint: endpoint);
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndPointData(
            accessToken: _accessToken, endpoint: endpoint);
      }
      rethrow;
    }
  }

  EndpointsData getAllEndpointsCachedData() => dataCacheService.getData();

  Future<EndpointsData> getAllEndpointsData() async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      final endpointsData = await _getAllEndpointsData();
      await dataCacheService.setData(endpointsData);
      return endpointsData;
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();

        final endpointsData = await _getAllEndpointsData();
        await dataCacheService.setData(endpointsData);
        return endpointsData;
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointsData() async {
    final values = await Future.wait([
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: EndPoint.cases),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: EndPoint.casesSuspected),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: EndPoint.casesConfirmed),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: EndPoint.deaths),
      apiService.getEndPointData(
          accessToken: _accessToken, endpoint: EndPoint.recovered),
    ]);
    return EndpointsData(
      values: {
        EndPoint.cases: values[0],
        EndPoint.casesSuspected: values[1],
        EndPoint.casesConfirmed: values[2],
        EndPoint.deaths: values[3],
        EndPoint.recovered: values[4],
      },
    );
  }
}
