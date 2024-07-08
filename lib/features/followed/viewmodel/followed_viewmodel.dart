import 'package:flutter/material.dart';
import '../../../core/helpers/local_storage_helper.dart';
import '../../../core/services/api_service.dart';
import '../../character/models/character_model.dart';

class FollowedViewModel extends ChangeNotifier {
  final LocalStorageHelper _localStorageHelper = LocalStorageHelper();
  final ApiService _apiService = ApiService();
  List<CharacterModel> _followedCharacters = [];

  List<CharacterModel> get followedCharacters => _followedCharacters;

  FollowedViewModel() {
    loadFollowedCharacters();
  }

  Future<void> loadFollowedCharacters() async {
    final followedNames = await _localStorageHelper.getFollowedCharacters();
    final allCharacters = await _apiService.fetchCharacters();
    _followedCharacters = allCharacters.where((character) => followedNames.contains(character.name)).toList();
    notifyListeners();
  }

  Future<void> removeFollowedCharacter(String name) async {
    await _localStorageHelper.removeFollowedCharacter(name);
    _followedCharacters.removeWhere((character) => character.name == name);
    notifyListeners();
  }
}
