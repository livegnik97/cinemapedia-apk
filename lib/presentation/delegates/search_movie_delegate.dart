import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../config/helpers/human_formats.dart';
import '../../config/helpers/widgets_gi.dart';
import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  Movie? result;

  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate(
      {this.initialMovies = const [], required this.searchMovies})
      : super(
          searchFieldLabel: 'Buscar película',
        );

  void clearStreams() {
    debouncedMovies.close();
    isLoadingStream.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
      initialMovies = movies;
      isLoadingStream.add(false);
    });
  }

  // @override
  // String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: isLoadingStream.stream,
        initialData: false,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;
          return isLoading
              ? SpinPerfect(
                  duration: const Duration(seconds: 20),
                  spins: 10,
                  child: const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.refresh_rounded)),
                )
              : FadeIn(
                  animate: query.isNotEmpty,
                  duration: const Duration(milliseconds: 200),
                  child: IconButton(
                      onPressed: () => query = "",
                      icon: const Icon(Icons.clear)),
                );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_rounded));

  @override
  Widget buildResults(BuildContext context) {
    return getResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return getResults();
  }

  Widget getResults() {
    return StreamBuilder(
      stream: debouncedMovies.stream,
      initialData: initialMovies,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return ListTile(
              title: _MovieItem(
                  movie: movie,
                  onMovieSelected: (BuildContext context, Movie movie) {
                    clearStreams();
                    close(context, movie);
                  }),
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        child: InkWell(
          onTap: () {
            onMovieSelected(context, movie);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                SizedBox(
                    width: size.width * 0.2,
                    height: size.width * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: WidgetsGI.CacheImageNetworkGI(movie.posterPath),
                    )),
                const SizedBox(width: 10),
                SizedBox(
                  width: (size.width - 30) * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title, style: textStyles.titleMedium),
                      movie.overview.length > 100
                          ? Text("${movie.overview.substring(0, 100)}...")
                          : Text(movie.overview),
                      Row(
                        children: [
                          Icon(Icons.star_half_outlined,
                              color: Colors.yellow.shade800),
                          const SizedBox(width: 5),
                          Text(
                              "${HumanFormats.humanReadbleNumber(movie.voteAverage, 1)}",
                              style: textStyles.bodyMedium
                                  ?.copyWith(color: Colors.yellow.shade900)),
                          const Spacer(),
                          Text(
                              "${HumanFormats.humanReadbleNumber(movie.popularity)}",
                              style: textStyles.bodySmall),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
