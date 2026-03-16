import 'package:exam1/domain/entities/comic.dart';
import 'package:flutter/material.dart';
import '../../data/api/manga_api.dart';
import '../widgets/comic_card.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final MangaAPI api = MangaAPI();

  List<Comic> comics = [];

  bool loading = true;

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadManga();
  }

  Future<void> loadManga([String query = ""]) async {

    setState(() {
      loading = true;
    });

    comics = (await api.getManga(query)).cast<Comic>();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "📚 Manga Reader",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        actions: [

          IconButton(

            icon: const Icon(Icons.favorite, color: Colors.red),

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritePage(),
                ),
              );

            },

          ),

        ],
      ),

      body: Stack(

        children: [

          /// 🎌 Manga Background
          Positioned.fill(

            child: Opacity(

              opacity: 0.07,

              child: Image.asset(
                "assets/images/manga_bg.png",
                fit: BoxFit.cover,
              ),

            ),

          ),

          /// 📚 Main Content
          Column(

            children: [

              /// 🔎 Search Box
              Padding(

                padding: const EdgeInsets.all(12),

                child: TextField(

                  controller: searchController,

                  onSubmitted: (value) {
                    loadManga(value);
                  },

                  decoration: InputDecoration(

                    hintText: "Search Manga...",

                    prefixIcon: const Icon(Icons.search),

                    suffixIcon: IconButton(

                      icon: const Icon(Icons.clear),

                      onPressed: () {
                        searchController.clear();
                        loadManga();
                      },

                    ),

                    filled: true,
                    fillColor: const Color(0xFF1C1C1C),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),

                  ),

                ),
              ),

              /// 📚 Manga Grid
              Expanded(

                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )

                    : GridView.builder(

                        padding: const EdgeInsets.symmetric(horizontal: 10),

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(

                          crossAxisCount: 2,

                          childAspectRatio: 0.65,

                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,

                        ),

                        itemCount: comics.length,

                        itemBuilder: (context, index) {

                          return ComicCard(comic: comics[index]);

                        },

                      ),

              )

            ],
          )

        ],
      ),
    );
  }
}