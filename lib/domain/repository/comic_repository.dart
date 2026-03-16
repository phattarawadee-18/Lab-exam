import '../entities/comic.dart';

abstract class ComicRepository {

  Future<List<Comic>> getComics();
}