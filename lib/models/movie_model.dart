// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Movie> movieFromJson(String str) =>
    List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
  Movie({
    required this.imdbid,
    required this.genre,
    required this.released,
    required this.title,
    required this.type,
    required this.imageurl,
    required this.synopsis,
  });

  final String imdbid;
  final List<String> genre;
  final int released;
  final String title;
  final Type? type;
  final List<String>? imageurl;
  final String synopsis;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        imdbid: json["imdbid"],
        genre: List<String>.from(json["genre"].map((x) => x)),
        released: json["released"],
        title: json["title"],
        type: typeValues.map[json["type"]],
        imageurl: json["imageurl"] == null
            ? null
            : List<String>.from(json["imageurl"].map((x) => x)),
        synopsis: json["synopsis"] == null ? null : json["synopsis"],
      );

  Map<String, dynamic> toJson() => {
        "imdbid": imdbid,
        "genre": List<dynamic>.from(genre.map((x) => x)),
        "released": released,
        "title": title,
        "type": typeValues.reverse[type],
        "imageurl": imageurl == null
            ? null
            : List<dynamic>.from(imageurl!.map((x) => x)),
        "synopsis": synopsis == null ? null : synopsis,
      };
}

enum Type { TV_SERIES, MOVIE, TV_MINI_SERIES, TV_MOVIE }

final typeValues = EnumValues({
  "movie": Type.MOVIE,
  "tvMiniSeries": Type.TV_MINI_SERIES,
  "tvMovie": Type.TV_MOVIE,
  "tvSeries": Type.TV_SERIES
});

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
