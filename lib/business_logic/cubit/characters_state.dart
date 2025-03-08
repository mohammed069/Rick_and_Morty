part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

final class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<dynamic> characters;

  CharactersLoaded({required this.characters});
}

class CharactersError extends CharactersState {
  final String message;

  CharactersError({required this.message});
}
