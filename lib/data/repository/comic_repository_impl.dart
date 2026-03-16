import '../../domain/entities/comic.dart';
import '../../domain/repository/comic_repository.dart';
import '../datasource/comic_api.dart';

class ComicRepositoryImpl implements ComicRepository {

  final ComicApi api;

  ComicRepositoryImpl(this.api);

  @override
  Future<List<Comic>> getComics() async {

    final models = await api.fetchComics();

    return models.map((m) =>
        Comic(
          id: m.id,
          title: m.title,
          image: m.image,
          synopsis: m.synopsis
        )
    ).toList();
  }
}