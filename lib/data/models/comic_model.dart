// ignore: unused_import
import '../../domain/entities/comic.dart';


class ComicModel extends Comic {

  ComicModel({
    required int id,
    required String title,
    required String image,
    required String synopsis,
  }) : super(
          id: id,
          title: title,
          image: image,
          synopsis: synopsis,
        );

  factory ComicModel.fromJson(Map<String, dynamic> json) {

    String image = json["images"]["jpg"]["large_image_url"];

    // FIX Flutter Web CORS
    image = image.replaceAll(
      "myanimelist.net",
      "cdn.myanimelist.net",
    );

    return ComicModel(
      id: json["mal_id"],
      title: json["title"],
      image: image,
      synopsis: json["synopsis"] ?? "",
    );
  }

  toJson() {}
}