import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class FavoriteView extends ConsumerStatefulWidget {

  static const String name = "favorite-view";

  const FavoriteView({super.key});

  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends ConsumerState<FavoriteView> with AutomaticKeepAliveClientMixin {


  bool isLastPage = false;
  bool isLoading = false;
  void loadNextPage() async {
    if(isLastPage || isLoading) return;
    isLoading = true;
    isLastPage = await ref.read(favoriteMoviesProvider.notifier).loadFavoriteMovies();
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if(favoriteMovies.isEmpty){
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
            Text("Ohhh no!!", style: TextStyle(fontSize: 30, color: colors.primary)),
            const Text("No tienes películas favoritas", style: TextStyle(fontSize: 20, color: Colors.black))
          ]
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMovies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}