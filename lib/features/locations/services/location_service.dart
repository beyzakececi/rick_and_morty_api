import '../../../core/mixins/service_operation_mixin.dart';
import '../models/location_model.dart';

class LocationService with ServiceOperationMixin {
  Future<List<LocationModel>> fetchLocations() async {
    return fetch<LocationModel>('location', (json) => LocationModel.fromJson(json));
  }
}
