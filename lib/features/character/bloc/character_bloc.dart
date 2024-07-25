import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product/localdb/hive_manager.dart';
import '../../../product/localdb/operations.dart';
import '../../character/services/character_service.dart';
import 'character_event.dart';
import 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterService _characterService;
  final HiveManager _hiveManager = HiveManager();
  final HiveOperations _hiveOperations = HiveOperations();

  CharacterBloc(this._characterService,
      {required CharacterService characterService})
      : super(CharacterInitial()) {
    on<FetchCharacters>(_onFetchCharacters);
    on<SearchCharacters>(_onSearchCharacters);
    on<FollowCharacterEvent>(_onFollowCharacter);
    on<UnfollowCharacterEvent>(_onUnFollowCharacter);
  }

  Future<void> _onFollowCharacter(
      FollowCharacterEvent event, Emitter<CharacterState> emit) async {

    final currentState = state as CharacterLoaded;

    await _hiveManager.addItemToList(event.characterName, StorageKeys.CHARACTER,
        _hiveOperations.getFollowedItems);
    var followedCharacters =
        await _hiveOperations.getFollowedItems(StorageKeys.CHARACTER.name);

    emit(CharacterLoaded(
      followedCharacters: followedCharacters,
      allCharacters: currentState.allCharacters,
      characters: currentState.characters,
    ));
  }

  Future<void> _onUnFollowCharacter(
      UnfollowCharacterEvent event, Emitter<CharacterState> emit) async {

    await _hiveManager.removeItemFromList(event.characterName,
        StorageKeys.CHARACTER, _hiveOperations.getFollowedItems);
    final currentState = state as CharacterLoaded;
    var followedCharacters =
        await _hiveOperations.getFollowedItems(StorageKeys.CHARACTER.name);

    emit(
      CharacterLoaded(
        followedCharacters: followedCharacters,
        allCharacters: currentState.allCharacters,
        characters: currentState.characters,
      ),
    );
  }

  Future<void> _onFetchCharacters(
      FetchCharacters event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    try {
      var followedCharacters =
          await _hiveOperations.getFollowedItems(StorageKeys.CHARACTER.name);

      final characters = await _characterService.fetchCharacters();
      emit(CharacterLoaded(
          followedCharacters: followedCharacters,
          characters: characters.results,
          allCharacters: characters));
    } catch (e) {
      emit(CharacterError(message: e.toString()));
    }
  }

  void _onSearchCharacters(
      SearchCharacters event, Emitter<CharacterState> emit) async {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      final query = event.query.toLowerCase();
      final filteredCharacters = currentState.allCharacters.results
          .where((character) => character.name.toLowerCase().contains(query))
          .toList();
      var followedCharacters =
          await _hiveOperations.getFollowedItems(StorageKeys.CHARACTER.name);

      emit(CharacterLoaded(
          followedCharacters: followedCharacters,
          characters: filteredCharacters,
          allCharacters: currentState.allCharacters));
    }
  }
}
