import 'package:dio/dio.dart';
import '../models/comic_model.dart';

class MangaAPI {

  final Dio dio = Dio();

  Future<List<ComicModel>> getManga([String query = ""]) async {

    String url;

    if(query.isEmpty){
      url = "https://api.jikan.moe/v4/top/manga";
    }else{
      url = "https://api.jikan.moe/v4/manga?q=$query";
    }

    final response = await dio.get(url);

    List data = response.data["data"];

    return data.map((e) => ComicModel.fromJson(e)).toList();
  }
}