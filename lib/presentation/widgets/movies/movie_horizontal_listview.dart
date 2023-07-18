import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/helpers/human_formats.dart';
import '../../../config/helpers/widgets_gi.dart';
import '../../../domain/entities/movie.dart';

class MovieHorizontalListView extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView({super.key, required this.movies, this.title, this.subtitle, this.loadNextPage});

  @override
  State<MovieHorizontalListView> createState() => _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {

  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;
      if(scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent){
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
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(widget.title != null || widget.subtitle != null)
          _Title(title: widget.title, subtitle: widget.subtitle),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                FadeInRight(child: _Slice(movie: widget.movies[index])),
            )
          ),


        ],
      )
    );
  }
}

class _Slice extends StatelessWidget {

  final Movie movie;

  const _Slice({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () => context.push("/movie/${movie.id}"),
                child: WidgetsGI.ImageNetworkGI(
                  movie.posterPath,
                  width: 150
                ),
              ),
            ),
          ),

          const SizedBox(height: 5),

          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(width: 3),
                Text("${movie.voteAverage}", style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800)),
                const Spacer(),
                Text("${HumanFormats.humanReadbleNumber(movie.popularity)}", style: textStyles.bodySmall),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if(title != null)
            Text(title!, style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          if(subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: null,
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}