import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_model.dart';

class MovieServices {
  Future<List<Movie>> getMovies(String movieName) async {
    final uri = Uri.parse(
            'https://ott-details.p.rapidapi.com/search?title=endgame&page=1')
        .replace(queryParameters: <String, String>{
      'title': movieName.isEmpty ? 'endgame' : '$movieName',
      'page': '1'
    });
    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "ott-details.p.rapidapi.com",
      "x-rapidapi-key": "9d66e81587msh8110b5db8a31f76p1070e1jsn5a72a0f89eed"
    });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final movies = jsonResponse['results'];
      return movies.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
