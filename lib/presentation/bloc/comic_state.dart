import '../../domain/entities/comic.dart';

abstract class ComicState {}

class ComicLoading extends ComicState {}

class ComicLoaded extends ComicState {

  final List<Comic> comics;

  ComicLoaded(this.comics);

}

// state for errors during loading
class ComicError extends ComicState {
  final String message;
  ComicError(this.message);
}