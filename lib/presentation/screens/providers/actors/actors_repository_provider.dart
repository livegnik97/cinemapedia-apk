import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastucture/repositories/actors_repository_impl.dart';
import '../../../../infrastucture/datasources/actors_moviedb_datasource.dart';

//Este repositorio es inmutale, solo de lectura
final actorRepositoryProvider = Provider<ActorsRepositoryImpl>(
  (ref) => ActorsRepositoryImpl(ActorsMovieDBDatasource())
);