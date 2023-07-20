import 'package:Cinemapedia/domain/entities/actor.dart';

import '../../domain/datasources/actors_datasource.dart';
import '../../domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {

  final ActorsDataSource dataSource;

  ActorsRepositoryImpl(this.dataSource);

  @override
  Future<List<Actor>> getActorsOfMovie(String movieId) {
    return dataSource.getActorsOfMovie(movieId);
  }

}