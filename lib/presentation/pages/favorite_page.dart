import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritePage extends StatelessWidget {

  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {

    final box = Hive.box("favorites");

    final favorites = box.toMap();

    return Scaffold(

      appBar: AppBar(
        title: const Text("⭐ Favorite Manga"),
      ),

      body: GridView.builder(

        padding: const EdgeInsets.all(10),

        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,

        ),

        itemCount: favorites.length,

        itemBuilder: (context, index) {

          final item = favorites.values.elementAt(index) as Map;

          final title = item["title"];
          final image = item["image"];

          return Card(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            child: Column(

              children: [

                Expanded(

                  child: ClipRRect(

                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),

                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),

                  ),

                ),

                Padding(

                  padding: const EdgeInsets.all(8),

                  child: Text(

                    title,

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),

                  ),

                )

              ],

            ),

          );

        },

      ),

    );
  }
}