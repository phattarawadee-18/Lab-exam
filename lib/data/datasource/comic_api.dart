import 'package:dio/dio.dart';
import '../models/comic_model.dart';

class ComicApi {
  final Dio dio;

  ComicApi(this.dio);

  Future<List<ComicModel>> fetchComics() async {

    final response =
        await dio.get("https://api.jikan.moe/v4/manga");

    List data = response.data["data"];

    return data.map((e) => ComicModel.fromJson(e)).toList();
  }
}