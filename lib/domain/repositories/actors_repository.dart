import '../entities/actor.dart';

abstract class ActorsRepository {

  Future<List<Actor>> getActorsOfMovie(String movieId);
}