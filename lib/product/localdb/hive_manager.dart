// hive_manager.dart
import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';
import 'operations.dart';

enum StorageKeys { CHARACTER, LOCATION }

class HiveManager {
  final HiveOperations _operations = HiveOperations();

  Future<void> initHive() async {
    await Hive.initFlutter(); // Initialize Hive
    await Hive.openBox<List<String>>(
        HiveBoxNames.charactersBox); // Open box for characters
    await Hive.openBox<List<String>>(
        HiveBoxNames.locationsBox); // Open box for locations
  }

  Future<String> getItem(StorageKeys key, String value) async {
    final box = _operations.getBoxByType(key.name);

    return "";
  }

  Future<String> putItem(StorageKeys key,String value) async {
    final box = _operations.getBoxByType(key.name);
    return "";
  }



  Future<void> addItemToList(
      String name, StorageKeys key, Function func) async {
    final box = _operations.getBoxByType(key.name);
    List<String> followedItems = await func(key.name);
    if (!followedItems.contains(name)) {
      followedItems.add(name);
      await box.put(key.name, followedItems);
    }
  }

  Future<void> removeItemFromList(
      String name, StorageKeys key, Function func) async {
    final box = _operations.getBoxByType(key.name);
    List<String> followedItems = await func(key.name);
    followedItems.remove(name);
    await box.put(key.name, followedItems);
  }

  Future<void> closeHive() async {
    await Hive.close(); // Close Hive when no longer needed
  }
}
