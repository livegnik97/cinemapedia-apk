import 'package:cinemapedia/domain/entities/actor.dart';

import '../../domain/datasources/actors_datasource.dart';
import '../mappers/actor_mapper.dart';
import '../models/moviedb/credits_response.dart';
import 'init_dio.dart';

class ActorsMovieDBDatasource extends ActorsDataSource {

  List<Actor> _jsonToMovies(Map<String,dynamic> json) {
    final credits = CreditsResponse.fromJson(json);
    return credits.cast
    .map((e) => ActorMapper.castToEntity(e))
    .toList();
  }

  @override
  Future<List<Actor>> getActorsOfMovie(String movieId) async {
    final res = await dio.get("/movie/${movieId}/credits");
    return _jsonToMovies(res.data);
  }

}