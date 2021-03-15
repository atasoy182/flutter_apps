import 'package:flutter/material.dart';

import 'last_updated.dart';
import 'location.dart';
import 'maxmin_temp.dart';
import 'weather_pic.dart';

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: LocationWidget()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: LastUpdatedWidget()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: WeatherPicWidget()),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: MaxMinTempWidget()),
            ),
          ],
        ),
      ),
    );
  }
}
