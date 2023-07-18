import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/actor.dart';
import 'actors_repository_provider.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier,Map<String,List<Actor>>>(
  (ref) {
    final actorRepository = ref.watch(actorRepositoryProvider);
    return ActorsByMovieNotifier(getActors: actorRepository.getActorsOfMovie);
  }
);

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors
  }): super({});

  Future<void> loadActors(String id) async {
    if(state[id] != null) return;
    final actors = await getActors(id);

    state = {...state, id: actors};
  }
}