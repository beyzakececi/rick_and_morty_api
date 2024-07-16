import 'package:flutter/foundation.dart';
import '../../../core/localdb/hive_manager.dart';
import '../../../features/character/services/character_service.dart';
import '../models/character_model.dart';

class CharacterViewModel extends ChangeNotifier {
  final HiveManager _hiveManager = HiveManager();
  final CharacterService _characterService = CharacterService();

  List<CharacterModel> _characters = [];
  List<String> _followedCharacters = [];

  List<CharacterModel> get characters => _characters;
  List<String> get followedCharacters => _followedCharacters;

  Future<void> fetchCharacters() async {
    try {
      _characters = await _characterService.fetchCharacters();
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
