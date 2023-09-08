import 'dart:math';

import 'package:Cinemapedia/config/helpers/widgets_gi.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../config/router/router_path.dart';
import '../../../domain/entities/movie.dart';

class MovieMasonry extends StatefulWidget {

  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({
    super.key,
    required this.movies,
    this.loadNextPage
  });

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;
      if(scrollController.position.pixels + 100 >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollController,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (BuildContext context, int index) {
          if(index == 1) {
            return Column(
              children: [
                const SizedBox(height: 30),
                _MoviePosterLink(movie: widget.movies[index]),
              ],
            );
          }
          return _MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}

class _MoviePosterLink extends StatelessWidget {
  final Movie movie;
  const _MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return FadeInUp(
      from: random.nextInt(100) + 80,
      delay: Duration(milliseconds: random.nextInt(450) + 0 ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: () => context.push(RouterPath.MOVIE_PAGE(movie.id)),
          child: WidgetsGI.CacheImageNetworkGI(
            movie.posterPath,
            height: 180
          )
        ),
      ),
    );
  }
}