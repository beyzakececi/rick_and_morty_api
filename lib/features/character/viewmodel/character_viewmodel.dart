import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/product/localdb/operations.dart';

import '../../../features/character/services/character_service.dart';
import '../../../product/localdb/hive_manager.dart';
import '../models/character_model.dart';

class CharacterViewModel extends ChangeNotifier {
  final HiveManager _hiveManager = HiveManager();
  final HiveOperations _hiveOperations = HiveOperations();
  final CharacterService _characterService = CharacterService();

  ListCharacterModel _characters = ListCharacterModel(results: []);
  List<String> _followedCharacters = [];

  ListCharacterModel get characters => _characters;

  List<String> get followedCharacters => _followedCharacters;

  Future<void> fetchCharacters() async {
    try {
      _characters = await _characterService.fetchCharacters();
      _followedCharacters =
          await _hiveOperations.getFollowedItems(StorageKeys.CHARACTER.name);
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Failed to fetch characters: $e');
    }
  }

  Future<void> addFollowedCharacter(String name) async {
    await _hiveManager.addItemToList(
        name, StorageKeys.CHARACTER, _hiveOperations.getFollowedItems);
    _followedCharacters = await _hiveOperations.getFollowedItems(StorageKeys.CHARACTER.name);
    notifyListeners();
  }

  Future<void> removeFollowedCharacter(String name) async {
    await _hiveManager.removeItemFromList(
        name, StorageKeys.CHARACTER, _hiveOperations.getFollowedItems);
    _followedCharacters = await _hiveOperations.getFollowedItems(StorageKeys.CHARACTER.name);
    notifyListeners();
  }

  bool isFollowed(String name) {
    return _followedCharacters.contains(name);
  }
}
