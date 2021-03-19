part of 'tema_bloc.dart';

abstract class TemaEvent extends Equatable {
  const TemaEvent();
}

class TemaDegistirEvent extends TemaEvent {
  final String havaDurumuKisaltmasi;
  TemaDegistirEvent({@required this.havaDurumuKisaltmasi});

  @override
  List<Object> get props => [havaDurumuKisaltmasi];
}
