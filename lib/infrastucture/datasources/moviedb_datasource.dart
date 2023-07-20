import 'package:Cinemapedia/domain/entities/movie.dart';
import 'package:Cinemapedia/infrastucture/models/moviedb/movie_details.dart';

import '../../domain/datasources/movies_datasource.dart';
import '../mappers/movie_mapper.dart';
import '../models/moviedb/moviedb_response.dart';
import 'init_dio.dart';

class MovieDbDatasource extends MoviesDataSource {

  List<Movie> _jsonToMovies(Map<String,dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);
    return movieDbResponse.results
      .map((e) => MovieMapper.movieDBToEntity(e))
      // .where((element) => element.posterPath != 'no-poster')
      .toList();
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final res = await dio.get("/movie/now_playing",
    queryParameters: {
      'page': page
    });
    return _jsonToMovies(res.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final res = await dio.get("/movie/popular",
    queryParameters: {
      'page': page
    });
    return _jsonToMovies(res.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final res = await dio.get("/movie/upcoming",
    queryParameters: {
      'page': page
    });
    return _jsonToMovies(res.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final res = await dio.get("/movie/top_rated",
    queryParameters: {
      'page': page
    });
    return _jsonToMovies(res.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final res = await dio.get("/movie/$id");
    if(res.statusCode != 200) throw Exception("Movie id not found");

    final movieDB = MovieDetails.fromJson(res.data);
    return MovieMapper.movieDetailsToEntity(movieDB);
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if(query.isEmpty) return [];

    final res = await dio.get("/search/movie",
    queryParameters: {
      'query': query
    });
    return _jsonToMovies(res.data);
  }
}