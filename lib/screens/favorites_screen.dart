import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/widgets/details_widget.dart';
import 'package:movie_app/widgets/movie_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieController movieController = Get.put(MovieController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Movies',
          style: TextStyle(
              fontFamily: 'avenir',
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (movieController.openDetails.value == true) {
              movieController.openFavorite(false);
              Get.back();
            } else {
              movieController.openFavorite(false);
              Get.back();
            }
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (movieController.isError.isTrue) {
                return const Center(
                  child: Text("Not Connection"),
                );
              } else if (movieController.isLoading.isTrue) {
                return (const Center(
                  child: CircularProgressIndicator(),
                ));
              } else
                // ignore: curly_braces_in_flow_control_structures
                return movieController.favoriteAdvancedList.length > 0
                    ? AlignedGridView.count(
                        crossAxisCount:
                            movieController.favoriteCrossCount.value,
                        itemCount: movieController.openFavoriteDetails.isFalse
                            ? movieController.favoriteAdvancedList.length
                            : 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                movieController.selectedIndex.value = index;
                                movieController.openFavorite(true);
                              },
                              child: movieController.openFavoriteDetails.isFalse
                                  ? MovieWidget(movieController
                                      .favoriteAdvancedList[index])
                                  : DetailsWidget(
                                      movie: movieController
                                              .favoriteAdvancedList[
                                          movieController.selectedIndex.value],
                                      index:
                                          movieController.selectedIndex.value));
                        },
                      )
                    : const Center(
                        child: Text("No Favorites"),
                      );
            }),
          )
        ],
      ),
    );
  }
}
