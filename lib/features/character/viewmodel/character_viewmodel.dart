import 'package:flutter/foundation.dart';
import '../../../core/helpers/local_storage_helper.dart';
import '../../../core/services/api_service.dart';
import '../models/character_model.dart';

class CharacterViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final LocalStorageHelper _localStorageHelper = LocalStorageHelper();

  List<CharacterModel> _characters = [];
  List<String> _followedCharacters = [];

  List<CharacterModel> get characters => _characters;
  List<String> get followedCharacters => _followedCharacters;

  Future<void> fetchCharacters() async {
    try {
      _characters = await _apiService.fetchCharacters();
      _followedCharacters = await _localStorageHelper.getFollowedCharacters();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> addFollowedCharacter(String name) async {
    await _localStorageHelper.addFollowedCharacter(name);
    _followedCharacters = await _localStorageHelper.getFollowedCharacters();
    notifyListeners();
  }

  Future<void> removeFollowedCharacter(String name) async {
    await _localStorageHelper.removeFollowedCharacter(name);
    _followedCharacters = await _localStorageHelper.getFollowedCharacters();
    notifyListeners();
  }

  bool isFollowed(String name) {
    return _followedCharacters.contains(name);
  }
}
