import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/advanced_movie.dart';

class DetailsWidget extends StatelessWidget {
  final AdvancedMovie movie;
  const DetailsWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: Get.height * 0.5,
                width: Get.width * 0.7,
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
                      color: Colors.grey,
                      icon: const Icon(Icons.favorite_rounded),
                      onPressed: () {
                        Get.snackbar("Başarılı", "Film Favorilere Eklendi!",
                            backgroundColor: Colors.black,
                            colorText: Colors.white);
                      },
                    )),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            maxLines: null,
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "IMDB : ${movie.imdbrating.toString()}",
                    style: const TextStyle(color: Colors.white),
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
              style: const TextStyle(fontSize: 32, fontFamily: 'avenir')),
          Text(
            movie.synopsis,
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
