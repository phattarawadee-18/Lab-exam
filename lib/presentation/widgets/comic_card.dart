import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/comic.dart';
import '../pages/detail_page.dart';

class ComicCard extends StatelessWidget {

  final Comic comic;

  const ComicCard({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {

    final box = Hive.box("favorites");

    return GestureDetector(

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(comic: comic),
          ),
        );

      },

      child: Container(

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 10,
              offset: const Offset(0,4),
            )
          ],

        ),

        child: ClipRRect(

          borderRadius: BorderRadius.circular(16),

          child: Stack(

            children: [

              /// 📷 Manga Cover
              Positioned.fill(

                child: Hero(

                  tag: comic.id,

                  child: Image.network(

                    comic.image,

                    fit: BoxFit.cover,

                    loadingBuilder: (context, child, progress) {

                      if (progress == null) return child;

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },

                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.image_not_supported),
                      );
                    },

                  ),

                ),

              ),

              /// ⭐ Favorite Button
              Positioned(

                top: 5,
                right: 5,

                child: IconButton(

                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),

                  onPressed: () {

                    box.put(comic.id, {
                      "title": comic.title,
                      "image": comic.image,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(

                      const SnackBar(
                        content: Text("Added to Favorite ⭐"),
                        duration: Duration(seconds: 1),
                      ),

                    );

                  },

                ),

              ),

              /// 📖 Title Overlay
              Positioned(

                bottom: 0,
                left: 0,
                right: 0,

                child: Container(

                  padding: const EdgeInsets.all(8),

                  decoration: const BoxDecoration(

                    gradient: LinearGradient(

                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,

                      colors: [
                        Colors.black87,
                        Colors.transparent
                      ],

                    ),

                  ),

                  child: Text(

                    comic.title,

                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),

                ),

              ),

            ],
          ),
        ),
      ),
    );
  }
}