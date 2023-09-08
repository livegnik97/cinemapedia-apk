
import 'package:Cinemapedia/database/structs/movie_db_struct.dart';
import 'package:Cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';

class IsarMovieDb extends MovieDbStruct {

  late Future<Isar> db;

  IsarMovieDb(this.db){}

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? isFavoriteMovie = await isar.movies
      .filter()
      .idEqualTo(movieId)
      .findFirst();

    return isFavoriteMovie != null;
  }


  @override
  Future<bool> toggleFavorite(Movie movie) async {
    final isar = await db;
    final Movie? isFav = await isar.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();

    if(isFav != null) {
      // borrar
      await isar.writeTxn(
          () async => await isar.movies.delete(isFav.isarId!)
      );
    }
    else {
      //insertar
      await isar.writeTxn(
        () async => await isar.movies.put(movie)
      );
    }
    return isFav == null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.movies
      .where()
      .offset(offset)
      .limit(limit)
      .findAll();
  }
}