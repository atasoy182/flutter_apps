import 'package:bloc/bloc.dart';

class CounterObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }
}
