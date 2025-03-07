import 'package:flutter_breaking/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository({required this.charactersWebServices});

  Future<List<dynamic>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => character.fromJson(character))
        .toList();
  }
}
