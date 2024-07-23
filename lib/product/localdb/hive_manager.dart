// hive_manager.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'constants.dart';
import 'operations.dart';

class HiveManager {
  final HiveOperations _operations = HiveOperations();

  Future<void> initHive() async {
    await Hive.initFlutter(); // Initialize Hive
    await Hive.openBox<List<String>>(
        HiveBoxNames.charactersBox); // Open box for characters
    await Hive.openBox<List<String>>(
        HiveBoxNames.locationsBox); // Open box for locations
  }

  Future<void> addFollow(String name, String type) async {
    final box = _operations.getBoxByType(type);
    List<String> followedItems = await _operations.getFollowedItems(type);
    if (!followedItems.contains(name)) {
      followedItems.add(name);
      await box.put(type, followedItems);
    }
  }

  Future<void> removeFollow(String name, String type) async {
    final box = _operations.getBoxByType(type);
    List<String> followedItems = await _operations.getFollowedItems(type);
    followedItems.remove(name);
    await box.put(type, followedItems);
  }

  Future<void> closeHive() async {
    await Hive.close(); // Close Hive when no longer needed
  }

}
