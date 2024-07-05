// lib/core/helpers/local_storage_helper.dart
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  static const String _followedKey = 'followed_characters';

  Future<void> addFollowedCharacter(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final followedCharacters = prefs.getStringList(_followedKey) ?? [];
    if (!followedCharacters.contains(name)) {
      followedCharacters.add(name);
      await prefs.setStringList(_followedKey, followedCharacters);
    }
  }

  Future<List<String>> getFollowedCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_followedKey) ?? [];
  }

  Future<void> removeFollowedCharacter(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final followedCharacters = prefs.getStringList(_followedKey) ?? [];
    followedCharacters.remove(name);
    await prefs.setStringList(_followedKey, followedCharacters);
  }
}
