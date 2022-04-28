import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/models/advanced_movie.dart';

class DetailsWidget extends StatefulWidget {
  final int index;
  final AdvancedMovie movie;
  const DetailsWidget({required this.movie, required this.index});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
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
                  widget.movie.imageurl[0],
                  fit: BoxFit.cover,
                ),
              ),
              Obx(() => Positioned(
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        color: Colors.grey,
                        icon: widget.movie.isFavorite.isFalse
                            ? const Icon(Icons.favorite_rounded)
                            : const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                        onPressed: () {
                          // Timer ekleyip 2 saniyedeki tıklanma sayısını hesapla ve error verdirt.
                          if (widget.movie.isFavorite.value == true) {
                            Get.snackbar("Successful",
                                "You removed the movie from your Favorites..!",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.black,
                                colorText: Colors.white,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                icon: const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.red,
                                ));
                            setState(() {
                              widget.movie.isFavorite.value = false;
                              movieController.removeMovie(widget.index);
                            });
                          } else if (widget.movie.isFavorite.value == false) {
                            setState(() {
                              widget.movie.isFavorite.value = true;
                              movieController.addFavoriteMovie(widget.index);
                            });

                            Get.snackbar("Successful",
                                "You have added the movie to Favorites..!",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.black,
                                colorText: Colors.white,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ));
                          }
                        },
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.movie.title,
            maxLines: null,
            style: const TextStyle(
                fontFamily: 'avenir', fontWeight: FontWeight.w800),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          if (widget.movie.imdbid != null)
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
                    "IMDB : ${widget.movie.imdbrating.toString()}",
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
          Text("Genre : ${widget.movie.genre[0]}",
              style: const TextStyle(fontSize: 32, fontFamily: 'avenir')),
          Text(
            widget.movie.synopsis,
            maxLines: null,
          ),
        ],
      ),
    );
  }
}
