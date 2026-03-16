import 'package:animate_do/animate_do.dart';
import 'package:exam1/domain/entities/comic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/ai_api.dart';
import '../bloc/summary_bloc.dart';
import '../bloc/summary_event.dart';
import '../bloc/summary_state.dart';

class DetailPage extends StatelessWidget {
  final Comic comic;

  const DetailPage({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SummaryBloc(AIAPI()),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                comic.title,
                style: const TextStyle(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              background: Hero(
                tag: comic.id,
                child: Image.network(
                  comic.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  /// 📖 Synopsis
                  FadeIn(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        comic.synopsis,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🤖 AI Button
                  Center(
                    child: FadeIn(
                      delay: const Duration(milliseconds: 300),
                      child: BlocBuilder<SummaryBloc, SummaryState>(
                        builder: (context, state) {
                          return ElevatedButton.icon(
                            onPressed: state is SummaryLoading
                                ? null
                                : () {
                                    context
                                        .read<SummaryBloc>()
                                        .add(GetSummary(comic.synopsis));
                                  },
                            icon: const Icon(Icons.auto_awesome),
                            label: const Text("AI Summary"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🤖 AI Summary Result
                  BlocBuilder<SummaryBloc, SummaryState>(
                    builder: (context, state) {
                      Widget content =
                          const SizedBox.shrink(key: ValueKey('empty'));

                      if (state is SummaryLoading) {
                        content = const Center(
                          key: ValueKey('loading'),
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SummaryLoaded) {
                        content = FadeInUp(
                          key: const ValueKey('summary'),
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C1C1C),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "🤖 AI Summary",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.summary,
                                  style:
                                      const TextStyle(fontSize: 15, height: 1.5),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state is SummaryError) {
                        content = Center(
                          key: const ValueKey('error'),
                          child: Text(state.message,
                              style: const TextStyle(color: Colors.red)),
                        );
                      }

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: content,
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}