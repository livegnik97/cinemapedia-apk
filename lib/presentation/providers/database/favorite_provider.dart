import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database_provider.dart';

final isFavoriteProvider = FutureProvider.family.autoDispose<bool,int>(
  (ref, int movieId) {
    final db = ref.watch(databaseProvider);
    return db.movie().isMovieFavorite(movieId);
  }
);