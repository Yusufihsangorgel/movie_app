import 'package:get/get.dart';

class AdvancedMovie {
  AdvancedMovie({
    required this.imageurl,
    required this.genre,
    required this.imdbid,
    required this.title,
    required this.imdbrating,
    required this.released,
    required this.type,
    required this.synopsis,
  });

  final List<String> imageurl;
  final List<String> genre;
  final String imdbid;
  final String title;
  final double imdbrating;
  final int released;
  final Type? type;
  final String synopsis;

  factory AdvancedMovie.fromJson(Map<String, dynamic> json) => AdvancedMovie(
        imageurl: List<String>.from(json["imageurl"].map((x) => x)),
        genre: List<String>.from(json["genre"].map((x) => x)),
        imdbid: json["imdbid"],
        title: json["title"],
        imdbrating:
            json["imdbrating"] == null ? null : json["imdbrating"].toDouble(),
        released: json["released"],
        type: typeValues.map[json["type"]],
        synopsis: json["synopsis"],
      );
}

enum Type { MOVIE, TV_MOVIE }

final typeValues = EnumValues({"movie": Type.MOVIE, "tvMovie": Type.TV_MOVIE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
