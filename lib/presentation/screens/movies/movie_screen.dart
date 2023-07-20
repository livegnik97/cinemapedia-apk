import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/helpers/widgets_gi.dart';
import '../../../domain/entities/actor.dart';
import '../../../domain/entities/movie.dart';
import '../../widgets/shared/custom_popup.dart';
import '../providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({
    super.key,
    required this.movieId
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if(movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.black45,
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              _CustomSliverAppBar(movie: movie),
              SliverList(
                delegate:SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1,
                ),
              )
            ],
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          List<PopupItemGI> items = [
              PopupItemGI(
                icon: Icons.add_rounded,
                label: "Adicional",
                onTap: (){},
              ),
              PopupItemGI(
                icon: Icons.camera_alt_rounded,
                label: "Cámara",
                onTap: (){},
              ),
              PopupItemGI(
                icon: Icons.add_rounded,
                label: "Adicional",
                onTap: (){},
              ),
              PopupItemGI(
                icon: Icons.camera_alt_rounded,
                label: "Cámara",
                onTap: (){},
              ),
              PopupItemGI(
                icon: Icons.add_rounded,
                label: "Adicional",
                onTap: (){},
              ),
              PopupItemGI(
                icon: Icons.camera_alt_rounded,
                label: "Cámara",
                onTap: (){},
              ),
              PopupItemGI(
                icon: Icons.add_rounded,
                label: "Adicional",
                onTap: (){},
              ),
              PopupItemGI(
                icon: Icons.camera_alt_rounded,
                label: "Cámara",
                onTap: (){},
              ),
            ];

          onDismiss(bool byUser) {
          }

          ShowPopupGI(context,
            onDismiss: onDismiss,
            items: items
          );
          // ref.read(isShowPopupProvider.notifier).state = true;
        },
        child: const Icon(Icons.menu),
      ),
    );
  }
}


class _CustomSliverAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      shadowColor: Colors.red,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: false,
        // titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        //   maxLines: 2,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: FadeIn(
                child: WidgetsGI.CacheImageNetworkGI(movie.posterPath),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black87
                    ]
                  )
                ),
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.25],
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ]
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {

  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: WidgetsGI.CacheImageNetworkGI(
                    width: size.width * 0.3,
                    movie.posterPath
                  ),
                ),

                const SizedBox(width: 10),

                SizedBox(
                  width: (size.width - 40) * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title, style: textStyles.titleLarge),
                      Text(movie.overview),
                    ]
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              children: [
                ...movie.genreIds.map(
                  (gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: WidgetsGI.ChipGI(gender),
                  )
                ),
              ],
            ),
          ),

          _ActorsByMovie(movieId: movie.id.toString()),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {

  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Actor>? actors = ref.watch(actorsByMovieProvider)[movieId];

    if(actors == null) {
      return const Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return FadeInRight(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: WidgetsGI.CacheImageNetworkGI(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(actor.name, maxLines: 2),
                  Text(actor.character ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                ]
              )
            ),
          );
        },
      ),
    );
  }
}