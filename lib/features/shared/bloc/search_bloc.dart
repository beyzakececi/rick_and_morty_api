

import 'package:flutter_bloc/flutter_bloc.dart';

class SearchEvent {
  final String query;

  SearchEvent(this.query);
}

class SearchBloc extends Bloc<SearchEvent, String> {
  SearchBloc() : super('');

  @override
  Stream<String> mapEventToState(SearchEvent event) async* {
    yield event.query;
  }
}
