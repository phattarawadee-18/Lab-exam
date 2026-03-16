import '../entities/comic.dart';
import '../repository/comic_repository.dart';

class GetComics {

  final ComicRepository repository;

  GetComics(this.repository);

  Future<List<Comic>> call() async {
    return repository.getComics();
  }

}