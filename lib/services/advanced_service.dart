import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/controllers/movie_controller.dart';

import 'package:movie_app/models/advanced_movie.dart';

class AdvancedMovieService {
  static var client = http.Client();

  static Future<List<AdvancedMovie>?> getAdvancedMovies() async {
    final _movieController = Get.put<MovieController>(MovieController());
    var response = await client.get(
        Uri.parse('https://ott-details.p.rapidapi.com/advancedsearch')
            .replace(queryParameters: <String, String>{
          "start_year": _movieController.startYear.value,
          "end_year": _movieController.endYear.value,
          "min_imdb": _movieController.minImdbRating.value,
          "max_imdb": _movieController.maxImdbRating.value,
          "genre": _movieController.genre.value,
          "language": 'english',
          "type": 'movie',
          "page": '1'
        }),
        headers: {
          "x-rapidapi-host": "ott-details.p.rapidapi.com",
          "x-rapidapi-key": "9d66e81587msh8110b5db8a31f76p1070e1jsn5a72a0f89eed"
        });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final movies = jsonResponse['results'] as List;
      return movies.map((e) => AdvancedMovie.fromJson(e)).toList();
    } else {
      debugPrint('error');
      return null;
    }
  }
}
