import 'package:flutter/material.dart';
import 'package:movie_app/models/advanced_movie.dart';

class MovieDetailsWidget extends StatelessWidget {
  final AdvancedMovie movie;
  // ignore: use_key_in_widget_constructors
  const MovieDetailsWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Column(
        children: [
          Image.network(movie.imageurl[0]),
        ],
      ),
    );
  }
}
