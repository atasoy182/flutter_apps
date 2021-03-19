part of 'tema_bloc.dart';

abstract class TemaState extends Equatable {
  const TemaState();
}

class UygulamaTemasi extends TemaState {
  final ThemeData tema;
  final MaterialColor renk;

  UygulamaTemasi({@required this.tema, @required this.renk});

  @override
  // TODO: implement props
  List<Object> get props => [tema, renk];
}
