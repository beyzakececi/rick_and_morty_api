// location_event.dart

import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class LoadLocations extends LocationEvent {}

class FetchLocations extends LocationEvent {}

class SearchLocations extends LocationEvent {
  final String query;

  SearchLocations({required this.query});
}

class RemoveFavoriteLocation extends LocationEvent {
  final String locationName;

  const RemoveFavoriteLocation(this.locationName);

  @override
  List<Object?> get props => [locationName];
}

class AddFavoriteLocation extends LocationEvent {
  final String locationName;

  const AddFavoriteLocation(this.locationName);

  @override
  List<Object?> get props => [locationName];
}
