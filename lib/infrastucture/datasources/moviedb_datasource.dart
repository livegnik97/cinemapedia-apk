import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:dio/dio.dart';

import '../../domain/datasources/movies_datasource.dart';
import '../mappers/movie_mapper.dart';
import '../models/moviedb/moviedb_response.dart';

class MovieDbDatasource extends MoviesDataSource {

  final dio = Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3",
    queryParameters: {
      'api_key': Environment.movieDbKey,
      'language': 'es-MX'
    }
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final res = await dio.get("/movie/now_playing");
    final movieDbResponse = MovieDbResponse.fromJson(res.data);
    final List<Movie> movies = movieDbResponse.results
    .map((e) => MovieMapper.movieDBToEntity(e))
    .where((element) => element.posterPath != 'no-poster')
    .toList();

    return movies;
  }

}