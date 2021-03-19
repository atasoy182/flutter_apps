part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitialState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoadingState extends WeatherState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class WeatherLoadedState extends WeatherState {
  final Weather weather;
  WeatherLoadedState({@required this.weather});

  @override
  // TODO: implement props
  List<Object> get props => [weather];
}

class WeatherErrorState extends WeatherState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
