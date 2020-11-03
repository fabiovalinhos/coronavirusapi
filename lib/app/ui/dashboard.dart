import 'dart:io';

import 'package:coronavirusrestapiflutter/app/repositories/data_repository.dart';
import 'package:coronavirusrestapiflutter/app/repositories/endpoins_data.dart';
import 'package:coronavirusrestapiflutter/app/services/api.dart';
import 'package:coronavirusrestapiflutter/app/ui/endpoint_card.dart';
import 'package:coronavirusrestapiflutter/app/ui/last_updated_status_text.dart';
import 'package:coronavirusrestapiflutter/app/ui/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointsData();
      setState(() => _endpointsData = endpointsData);
    } on SocketException catch (_) {
      showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Please try again later',
        defaultActionText: 'Ok',
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        title: 'Unknown Error',
        content: 'Please contact support or try again later.',
        defaultActionText: 'Ok',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
      lastUpdated: _endpointsData != null
          ? _endpointsData.values[EndPoint.cases].date
          : null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdatedStatusText(
              text: formatter.lastUpdatedStatusText(),
            ),
            for (var endpoint in EndPoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint].value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
