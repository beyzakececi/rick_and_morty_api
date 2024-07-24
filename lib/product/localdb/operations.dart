import 'package:hive/hive.dart';

import 'constants.dart';

class HiveOperations {
  Box<List<String>> getBoxByType(String type) {
    switch (type) {
      case 'CHARACTER':
        return Hive.box<List<String>>(HiveBoxNames.charactersBox);
      case 'LOCATION':
        return Hive.box<List<String>>(HiveBoxNames.locationsBox);
      default:
        throw Exception('Unsupported type: $type');
    }
  }

  Future<List<String>> getFollowedItems(String type) async {
    final box = getBoxByType(type);
    List<String>? followedItems = box.get(type);
    return followedItems ?? [];
  }
}
