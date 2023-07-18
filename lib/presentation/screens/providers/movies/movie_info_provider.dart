import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/movie.dart';
import '../providers.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier,Map<String,Movie>>(
  (ref) {
    final fetchGetMovie = ref.watch(movieRepositoryProvider).getMovieById;
    return MovieMapNotifier(getMovie: fetchGetMovie);
  }
);

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String,Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie
  }): super({});

  Future<void> loadMovie(String id) async {
    if(state[id] != null) return;
    final movie = await getMovie(id);

    state = {...state, id: movie};
  }
}