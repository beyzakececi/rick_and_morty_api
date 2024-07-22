import '../../../product/mixins/service_operation_mixin.dart';
import '../models/character_model.dart';

class CharacterService with ServiceOperationMixin {
  Future<List<CharacterModel>> fetchCharacters() async {
    return fetch<CharacterModel>('character', (json) => CharacterModel.fromJson(json));
  }
}