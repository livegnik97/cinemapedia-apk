import 'package:Cinemapedia/database/isar_implements/isar_movie_db.dart';
import 'package:Cinemapedia/database/structs/movie_db_struct.dart';
import 'package:isar/isar.dart';

import 'package:Cinemapedia/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

import 'structs/database_struct.dart';

class IsarDb extends DatabaseStruct {

  late Future<Isar> db;
  late MovieDbStruct movieDb;

  IsarDb() {
    db = openDB();
    movieDb = IsarMovieDb(db);
  }

  // init() async {
  //   db = openDB();
  //   isar = await db;
  //   movieDb = IsarMovieDb(isar);
  // }

  Future<Isar> openDB() async {
    if(Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([
        MovieSchema
      ], inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  @override
  MovieDbStruct movie() => movieDb;

}
