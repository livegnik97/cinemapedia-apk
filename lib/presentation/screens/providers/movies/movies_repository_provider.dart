import 'package:cinemapedia/infrastucture/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastucture/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio es inmutale, solo de lectura
final movieRepositoryProvider = Provider<MovieRepositoryImpl>(
  (ref) => MovieRepositoryImpl(MovieDbDatasource())
);