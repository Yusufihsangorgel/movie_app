import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/models/advanced_movie.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieWidget extends StatelessWidget {
  final AdvancedMovie movie;

  // ignore: use_key_in_widget_constructors
  const MovieWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return movie.openDetails.value == false
        ? Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image.network(
                          movie.imageurl[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                movie.openDetails.value == true;
                              },
                              icon: Icon(Icons.info)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    maxLines: 2,
                    style: const TextStyle(
                        fontFamily: 'avenir', fontWeight: FontWeight.w800),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (movie.imdbid != null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            movie.imdbrating.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(movie.genre[0],
                      style: TextStyle(fontSize: 32, fontFamily: 'avenir')),
                ],
              ),
            ),
          )
        : Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image.network(
                          movie.imageurl[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                movie.openDetails.value == false;
                              },
                              icon: Icon(Icons.exit_to_app)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    maxLines: 2,
                    style: const TextStyle(
                        fontFamily: 'avenir', fontWeight: FontWeight.w800),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (movie.imdbid != null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "IMDB : ${movie.imdbrating.toString()}",
                            style: TextStyle(color: Colors.white),
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text("Genre : ${movie.genre[0]}",
                      style: TextStyle(fontSize: 32, fontFamily: 'avenir')),
                  Text(
                    movie.synopsis,
                    maxLines: null,
                  ),
                ],
              ),
            ),
          );
  }
}
