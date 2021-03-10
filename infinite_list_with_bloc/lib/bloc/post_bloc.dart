import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient}) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostInitial) {
      yield null;
    }
  }
}
