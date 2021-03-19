import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_with_bloc/blocs/weather/tema_bloc.dart';
import 'package:weatherapp_with_bloc/blocs/weather/weather_bloc.dart';

import 'locator.dart';
import 'widget/weather_app.dart';

void main() {
  setupLocator();
  runApp(
      BlocProvider<TemaBloc>(create: (context) => TemaBloc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TemaBloc>(context),
      builder: (context, TemaState state) => MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: (state as UygulamaTemasi).tema,
        home: BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(), child: WeatherAppWidget()),
      ),
    );
  }
}
