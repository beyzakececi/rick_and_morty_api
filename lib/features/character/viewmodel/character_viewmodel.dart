import 'package:flutter/foundation.dart';
import '../../../core/localdb/hive_manager.dart';
import '../../../core/services/api_service_manager.dart';
import '../models/character_model.dart';

class CharacterViewModel extends ChangeNotifier {
  final FetchManager _fetchManager = FetchManager();
  final HiveManager _hiveManager = HiveManager();

  List<CharacterModel> _characters = [];
  List<String> _followedCharacters = [];

  List<CharacterModel> get characters => _characters;
  List<String> get followedCharacters => _followedCharacters;

  Future<void> fetchCharacters() async {
    try {
      _characters = await _fetchManager.fetchCharacters();
      _followedCharacters = await _hiveManager.getFollowedItems('characters');
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Failed to fetch characters: $e');
    }
  }

  Future<void> addFollowedCharacter(String name) async {
    await _hiveManager.addFollow(name, 'characters');
    _followedCharacters = await _hiveManager.getFollowedItems('characters');
    notifyListeners();
  }

  Future<void> removeFollowedCharacter(String name) async {
    await _hiveManager.removeFollow(name, 'characters');
    _followedCharacters = await _hiveManager.getFollowedItems('characters');
    notifyListeners();
  }

  bool isFollowed(String name) {
    return _followedCharacters.contains(name);
  }
}
