import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  static const String _charactersBoxName = 'followed_characters';
  static const String _locationsBoxName = 'followed_locations';

  Future<void> initHive() async {
    await Hive.initFlutter(); // Initialize Hive
    await Hive.openBox<List<String>>(_charactersBoxName); // Open box for characters
    await Hive.openBox<List<String>>(_locationsBoxName); // Open box for locations
  }

  Future<void> addFollow(String name, String type) async {
    final box = _getBoxByType(type);
    List<String> followedItems = await getFollowedItems(type); // Retrieve current items
    if (!followedItems.contains(name)) {
      followedItems.add(name);
      await box.put(type, followedItems);
    }
  }

  Future<List<String>> getFollowedItems(String type) async {
    final box = _getBoxByType(type);
    List<String>? followedItems = box.get(type); // Retrieve items from box
    return followedItems ?? []; // Return an empty list if null
  }

  Future<void> removeFollow(String name, String type) async {
    final box = _getBoxByType(type);
    List<String> followedItems = await getFollowedItems(type); // Retrieve current items
    followedItems.remove(name);
    await box.put(type, followedItems);
  }

  Box<List<String>> _getBoxByType(String type) {
    switch (type) {
      case 'characters':
        return Hive.box<List<String>>(_charactersBoxName);
      case 'locations':
        return Hive.box<List<String>>(_locationsBoxName);
      default:
        throw Exception('Unsupported type: $type');
    }
  }

  Future<void> closeHive() async {
    await Hive.close(); // Close Hive when no longer needed
  }
}