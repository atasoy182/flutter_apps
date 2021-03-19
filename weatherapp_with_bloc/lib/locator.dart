import 'package:get_it/get_it.dart';
import 'package:weatherapp_with_bloc/data/weather_api_client.dart';
import 'package:weatherapp_with_bloc/data/weather_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => WeatherRepository());
  locator.registerLazySingleton(() => WeatherApiClient());
}
