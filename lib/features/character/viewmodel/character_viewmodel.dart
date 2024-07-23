import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/product/localdb/operations.dart';
import '../../../product/localdb/hive_manager.dart';
import '../../../features/character/services/character_service.dart';
import '../models/character_model.dart';

class CharacterViewModel extends ChangeNotifier {
  final HiveManager _hiveManager = HiveManager();
  final HiveOperations _hiveOperations = HiveOperations();
  final CharacterService _characterService = CharacterService();

  ListCharacterModel _characters = ListCharacterModel(results:[]);
  List<String> _followedCharacters = [];

  ListCharacterModel get characters => _characters;
  List<String> get followedCharacters => _followedCharacters;

  Future<void> fetchCharacters() async {
    try {
      _characters = await _characterService.fetchCharacters();
      _followedCharacters =
          await _hiveOperations.getFollowedItems('characters');
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Failed to fetch characters: $e');
    }
  }

  Future<void> addFollowedCharacter(String name) async {
    await _hiveManager.addFollow(name, 'characters');
    _followedCharacters = await _hiveOperations.getFollowedItems('characters');
    notifyListeners();
  }

  Future<void> removeFollowedCharacter(String name) async {
    await _hiveManager.removeFollow(name, 'characters');
    _followedCharacters = await _hiveOperations.getFollowedItems('characters');
    notifyListeners();
  }

  bool isFollowed(String name) {
    return _followedCharacters.contains(name);
  }
}
