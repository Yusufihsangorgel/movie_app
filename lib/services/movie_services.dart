import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/controllers/name_movie_controller.dart';
import 'package:movie_app/models/movie_model.dart';

import '../controllers/movie_controller.dart';

class MovieServices {
  static var client = http.Client();

  static Future<List<Movie>?> getMovies() async {
    final _nameMovieController =
        Get.put<NameMovieController>(NameMovieController());
    var response = await client.get(
        Uri.parse('https://ott-details.p.rapidapi.com/advancedsearch').replace(
            queryParameters: <String, String>{
              'title': _nameMovieController.movieName.value,
              'page': '1'
            }),
        headers: {
          "x-rapidapi-host": "ott-details.p.rapidapi.com",
          "x-rapidapi-key": "8ad5d90d72msh7bf606d6993cb80p1f5a9fjsn1242d0cc7448"
        });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final movies = jsonResponse['results'] as List;
      return movies.map((e) => Movie.fromJson(e)).toList();
    } else {
      debugPrint('error');
      return null;
    }
  }
}




// class MovieServices {
//   Future<List<Movie>?> getMovies() async {
//     final _movieController = Get.put<MovieController>(MovieController());
//     final uri = Uri.parse(
//             'https://ott-details.p.rapidapi.com/search?title=endgame&page=1')
//         .replace(queryParameters: <String, String>{
//       'title': _movieController.movieName.value,
//       'page': '1'
//     });
//     final response = await http.get(uri, headers: {
//       "x-rapidapi-host": "ott-details.p.rapidapi.com",
//       "x-rapidapi-key": "9d66e81587msh8110b5db8a31f76p1070e1jsn5a72a0f89eed"
//     });
//     if (response.statusCode == 200) {
//       final jsonResponse = json.decode(response.body);
//       final movies = jsonResponse['results'];
//       return movies.map((e) => Movie.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load movies');
//     }
//   }
// }
