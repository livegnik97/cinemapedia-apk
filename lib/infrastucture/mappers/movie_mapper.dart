import 'package:cinemapedia/infrastucture/models/moviedb/movie_details.dart';

import '../../domain/entities/movie.dart';
import '../models/moviedb/movie_moviedb.dart';

//https://image.tmdb.org/t/p/w500/

const imageNotFoundUrl =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj7zyVdEoVXduKIqICx5sutdyA9QYlz2lEbg&usqp=CAU";

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: moviedb.backdropPath != ""
          ? "https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}"
          : imageNotFoundUrl,
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: moviedb.posterPath != ""
          ? "https://image.tmdb.org/t/p/w500/${moviedb.posterPath}"
          : imageNotFoundUrl,
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
  );

  static Movie movieDetailsToEntity(MovieDetails movieDetails) => Movie(
      adult: movieDetails.adult,
      backdropPath: movieDetails.backdropPath != ""
          ? "https://image.tmdb.org/t/p/w500/${movieDetails.backdropPath}"
          : imageNotFoundUrl,
      genreIds: movieDetails.genres.map((e) => e.name).toList(),
      id: movieDetails.id,
      originalLanguage: movieDetails.originalLanguage,
      originalTitle: movieDetails.originalTitle,
      overview: movieDetails.overview,
      popularity: movieDetails.popularity,
      posterPath: movieDetails.posterPath != ""
          ? "https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}"
          : imageNotFoundUrl,
      releaseDate: movieDetails.releaseDate,
      title: movieDetails.title,
      video: movieDetails.video,
      voteAverage: movieDetails.voteAverage,
      voteCount: movieDetails.voteCount
  );
}
