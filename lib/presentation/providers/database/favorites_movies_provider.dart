import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/database_export.dart';
import '../../../domain/entities/movie.dart';
import '../providers.dart';

final favoriteMoviesProvider =
  StateNotifierProvider<FavoriteMoviesNotifier,Map<int, Movie>>(
    (ref) {
      final db = ref.watch(databaseProvider);
      return FavoriteMoviesNotifier(db);
    }
  );


class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {

  int _page = 0;
  final DatabaseStruct _db;

  FavoriteMoviesNotifier(this._db): super({});

  Future<bool> loadFavoriteMovies() async {
    final movies = await _db.movie().loadMovies(limit: 15, offset: _page * 10);
    _page++;

    final tempMovieMap = <int, Movie>{};
    for(final movie in movies)
      tempMovieMap[movie.id] = movie;

    state = {
      ...state,
      ...tempMovieMap
    };
    return movies.isEmpty;
  }

  Future<void> toggleFavorite(Movie movie) async {
    final isFav = await _db.movie().toggleFavorite(movie);
    if(isFav) {
      state = {
        ...state,
        movie.id: movie
      };
    }
    else {
      state = {
        ...state..remove(movie.id)
      };
    }
  }
}