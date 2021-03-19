import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp_with_bloc/models/weather.dart';

class WeatherApiClient {
  static const baseUrl = "https://www.metaweather.com";
  final http.Client httpClient = http.Client();

  Future<int> getLocationId(String sehirAdi) async {
    final sehirUrl = baseUrl + "/api/location/search/?query=$sehirAdi";
    final gelenCevap = await httpClient.get(sehirUrl);

    if (gelenCevap.statusCode != 200) {
      throw Exception("Veri Getirilemedi!");
    }

    final cevapJson = (jsonDecode(gelenCevap.body)) as List;
    return cevapJson[0]["woeid"];
  }

  Future<Weather> getWeather(int sehirID) async {
    final havaDurumuUrl = baseUrl + "/api/location/$sehirID/";
    final havaDurumuGelenCevap = await httpClient.get(havaDurumuUrl);

    if (havaDurumuGelenCevap.statusCode != 200) {
      throw Exception("Hava Durumu Getirilemedi!");
    }
    //final havaDurumuJson = (jsonDecode(havaDurumuGelenCevap.body));
    return Weather.fromJson(havaDurumuGelenCevap.body);
  }
}
