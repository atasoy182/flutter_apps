import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_with_bloc/blocs/weather/weather_bloc.dart';

class MaxMinTempWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder(
      bloc: _weatherBloc,
      builder: (_, WeatherState state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Max : " +
                (state as WeatherLoadedState)
                    .weather
                    .consolidatedWeather[0]
                    .maxTemp
                    .floor()
                    .toString() +
                "°C",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Min : " +
                (state as WeatherLoadedState)
                    .weather
                    .consolidatedWeather[0]
                    .minTemp
                    .floor()
                    .toString() +
                "°C",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
