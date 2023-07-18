import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/shared/full_screen loader_percent.dart';
import '../../widgets/widgets.dart';
import '../providers/providers.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screnn';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initLoadingProvider);
    if(initialLoading) return const FullScreenLoaderPercent();
    // if(initialLoading) return const FullScreenLoader();

    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topMovies = ref.watch(topMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          centerTitle: false,
          leading: Icon(
            Icons.movie_outlined,
            color: Theme.of(context).colorScheme.primary
          ),
          title: Text(
            "Cinemapedia",
            style: Theme.of(context).textTheme.titleMedium
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){},
            )
          ],
        ),
        // const SliverAppBar(
        //   floating: true,
        //   flexibleSpace: FlexibleSpaceBar(
        //     title: CustomAppBar(),
        //   ),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  MoviesSledeshow(movies: moviesSlideshow),

                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: "En cines",
                    subtitle: "Lunes 20",
                    loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListView(
                    movies: upcomingMovies,
                    title: "Próximamente",
                    subtitle: "En este mes",
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListView(
                    movies: popularMovies,
                    title: "Populares",
                    loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
                  ),

                  MovieHorizontalListView(
                    movies: topMovies,
                    title: "Mejor calificadas",
                    subtitle: "Siempre",
                    loadNextPage: () => ref.read(topMoviesProvider.notifier).loadNextPage(),
                  ),

                  const SizedBox(height: 10),
                ],
              );
            },
            childCount: 1
          )
        ),
      ]
    );
  }
}