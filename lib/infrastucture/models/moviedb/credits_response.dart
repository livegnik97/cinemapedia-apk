
import 'cast_details.dart';

class CreditsResponse {
    final int id;
    final List<Cast> cast;
    final List<Cast> crew;

    CreditsResponse({
        required this.id,
        required this.cast,
        required this.crew,
    });

    factory CreditsResponse.fromJson(Map<String, dynamic> json) => CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
    };
}

