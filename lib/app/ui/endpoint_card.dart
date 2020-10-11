import 'package:coronavirusrestapiflutter/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  final EndPoint endpoint;
  final int value;

  EndpointCard({this.endpoint, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cases',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                value != null ? value.toString() : '',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
