import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class SearchWidget extends StatelessWidget {
  final Movie movie;

  // ignore: use_key_in_widget_constructors
  const SearchWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: movie.imageurl == null
                      ? Image.network(
                          "https://yt3.ggpht.com/TEAdMZfKzX66swz8s-tDk1slRImh9GLdsJltTYmwc-25cYV-c_8eYN5K1jpywF2q9Dy_HKGR=s900-c-k-c0x00ffffff-no-rj",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          movie.imageurl![0],
                          fit: BoxFit.cover,
                        ),
                ),
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
                    movie.released.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  // Text(
                  //   movie.type.toString(),
                  //   style: const TextStyle(color: Colors.white),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(movie.genre[0],
                style: const TextStyle(fontSize: 20, fontFamily: 'avenir')),
          ],
        ),
      ),
    );
  }
}
