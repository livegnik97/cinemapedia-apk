import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/database_export.dart';

final databaseProvider = Provider<DatabaseStruct>(
  (ref) => IsarDb()
);