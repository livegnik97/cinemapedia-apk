import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';

final Dio dio = _initDio();

_initDio() {
  return Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-MX'
      }
  ));
}