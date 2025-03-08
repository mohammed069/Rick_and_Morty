import 'package:bloc/bloc.dart';
import 'package:flutter_breaking/data/repository/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<dynamic> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<dynamic> getAllCharacters() {
    emit(CharactersLoading());
    charactersRepository
        .getAllCharacters()
        .then((characters) {
          emit(CharactersLoaded(characters: characters));
          this.characters = characters;
        })
        .catchError((error) {
          emit(CharactersError(message: error.toString()));
        });
    return characters;
  }
}
