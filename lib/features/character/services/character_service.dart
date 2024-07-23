import '../../../product/mixins/service_operation_mixin.dart';
import '../models/character_model.dart';

class CharacterService with ServiceOperationMixin {
  Future<ListCharacterModel> fetchCharacters() async {
    return fetch<ListCharacterModel>('character',
        (json) => ListCharacterModel.fromJson(json), NetworkConstant.GET);
  }
}
