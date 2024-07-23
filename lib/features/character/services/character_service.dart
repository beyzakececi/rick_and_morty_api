import '../../../product/mixins/service_operation_mixin.dart';
import '../models/character_model.dart';

class CharacterService with ServiceOperationMixin {
  Future<ListCharacterModel> fetchCharacters() async {
    return get<ListCharacterModel>('character', (json) => ListCharacterModel.fromJson(json));   
  }

}