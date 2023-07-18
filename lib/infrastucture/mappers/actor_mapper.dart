import '../../domain/entities/actor.dart';
import '../models/moviedb/cast_details.dart';

const imageNotFoundUrl =
    "https://img.freepik.com/premium-vector/account-icon-user-icon-vector-graphics_292645-552.jpg?w=2000";

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath != ''
      ? "https://image.tmdb.org/t/p/w500/${cast.profilePath}"
      : imageNotFoundUrl,
    character: cast.character
  );
}
