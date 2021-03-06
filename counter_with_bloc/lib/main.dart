import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'counter/view/counter_page.dart';
import 'counter_observer.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(CounterApp());
}

class CounterApp extends MaterialApp {
  /// {@macro counter_app}
  const CounterApp({Key? key}) : super(key: key, home: const CounterPage());
}
