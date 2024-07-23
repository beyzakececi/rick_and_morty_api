import '../../../product/mixins/service_operation_mixin.dart';
import '../models/location_model.dart';

class LocationService with ServiceOperationMixin {
  Future<ListLocationModel> fetchLocations() async {
    return get<ListLocationModel>('location', (json) => ListLocationModel.fromJson(json));
  }
}
