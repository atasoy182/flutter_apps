import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_with_bloc/blocs/weather/tema_bloc.dart';
import 'package:weatherapp_with_bloc/blocs/weather/weather_bloc.dart';
import 'package:weatherapp_with_bloc/widget/gecisli_arka_plan_rengi.dart';

import 'lastupdated.dart';
import 'location.dart';
import 'maxmintemp.dart';
import 'sehir_sec.dart';
import 'weatherpicture.dart';

class WeatherAppWidget extends StatelessWidget {
  String kullanicininSectigiSehir = "Ankara";
  Completer<void> _refreshCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Weather App"),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  kullanicininSectigiSehir = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SehirSecWidget()));

                  if (kullanicininSectigiSehir != null) {
                    _weatherBloc.add(
                        FetchWeatherEvent(sehirAdi: kullanicininSectigiSehir));
                  }
                })
          ],
        ),
        body: Center(
            child: BlocBuilder(
                bloc: _weatherBloc,
                builder: (context, WeatherState state) {
                  if (state is WeatherInitialState) {
                    return Center(
                      child: Text("Şehir seçiniz"),
                    );
                  }

                  if (state is WeatherLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is WeatherLoadedState) {
                    final getirilenWeather = state.weather;
                    kullanicininSectigiSehir = getirilenWeather.title;
                    // tema değiştir bloc için event gönderiyoruz.
                    BlocProvider.of<TemaBloc>(context).add(TemaDegistirEvent(
                        havaDurumuKisaltmasi: getirilenWeather
                            .consolidatedWeather[0].weatherStateAbbr));

                    _refreshCompleter.complete();
                    _refreshCompleter = Completer();

                    return BlocBuilder(
                      bloc: BlocProvider.of<TemaBloc>(context),
                      builder: (context, TemaState temaState) =>
                          GecisliRenkContainer(
                        renk: (temaState as UygulamaTemasi).renk,
                        child: RefreshIndicator(
                          onRefresh: () {
                            _weatherBloc.add(RefreshWeatherEvent(
                                sehirAdi: kullanicininSectigiSehir));
                            return _refreshCompleter.future;
                          },
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: LocationWidget(
                                  secilenSehir: getirilenWeather.title,
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: LastUpdatedWidget()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: WeatherPictureWidget()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(child: MaxMinTempWidget()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is WeatherErrorState) {
                    return Center(
                      child: Text("Hata Oluştu!"),
                    );
                  }
                })));
  }
}
