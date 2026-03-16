import 'package:hive/hive.dart';
import '../models/comic_model.dart';

class ComicLocalDb {
  Future<void> saveComics(List<ComicModel> comics) async {
    final box = await Hive.openBox('comicsBox');
    for (var comic in comics) {
      box.put(comic.id, comic.toJson());
    }
  }

  Future<List<ComicModel>> getComics() async {
    final box = await Hive.openBox('comicsBox');
    return box.values.map((e) => ComicModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }
}