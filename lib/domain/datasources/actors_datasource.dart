import '../entities/actor.dart';

abstract class ActorsDataSource {

  Future<List<Actor>> getActorsOfMovie(String movieId);
}