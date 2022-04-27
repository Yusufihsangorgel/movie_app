import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/models/advanced_movie.dart';

class DetailsWidget extends StatelessWidget {
  final int index;
  final AdvancedMovie movie;
  const DetailsWidget({required this.movie, required this.index});

  @override
  Widget build(BuildContext context) {
    final MovieController movieController = Get.put(MovieController());
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
              Obx(() => Positioned(
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        color: Colors.grey,
                        icon: movie.isFavorite.isFalse
                            ? const Icon(Icons.favorite_rounded)
                            : const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                        onPressed: () {
                          // Timer ekleyip 2 saniyedeki tıklanma sayısını hesapla ve error verdirt.
                          if (movie.isFavorite.value == true) {
                            movieController.removeMovie(index);
                            movie.isFavorite.value = false;
                            Get.snackbar("Başarılı",
                                "Filmi Favorilerinden Çıkardınız..!",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.black,
                                colorText: Colors.white,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ));
                            Get.back();
                          } else {
                            movie.isFavorite.value = true;
                            movieController.addFavoriteMovie(index);
                            Get.snackbar(
                                "Başarılı", "Filmi Favorilere Eklediniz..!",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.black,
                                colorText: Colors.white,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ));
                            Get.back();
                          }
                        },
                      ),
                    ),
                  )),
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
