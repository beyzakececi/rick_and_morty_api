import 'package:equatable/equatable.dart';

abstract class NavEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePageEvent extends NavEvent {
  final String page;

  ChangePageEvent(this.page);
}

