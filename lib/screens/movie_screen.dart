import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/screens/favorites_screen.dart';
import 'package:movie_app/widgets/details_widget.dart';
import 'package:movie_app/widgets/dialog_widget.dart';
import 'package:movie_app/widgets/movie_widget.dart';

class MovieScreen extends StatelessWidget {
  MovieScreen({Key? key}) : super(key: key);
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yusuf Movies',
          style: TextStyle(
              fontFamily: 'avenir',
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              color: Colors.black,
              icon: const Icon(Icons.view_list_rounded),
              onPressed: () {
                Get.dialog(DetailsDialog(movieController: movieController));
              }),
          IconButton(
              color: Colors.black,
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Get.to(const FavoritesScreen());
              }),
        ],
        leading: IconButton(
          onPressed: () {
            if (movieController.openDetails.value == true) {
              movieController.openMovie(false);
            } else {
              //exit(0);
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
                return AlignedGridView.count(
                  crossAxisCount: movieController.crossCount.value,
                  itemCount: movieController.openDetails.isFalse
                      ? movieController.advancedList.length
                      : 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          movieController.selectedIndex.value = index;
                          movieController.openMovie(true);
                        },
                        child: movieController.openDetails.isFalse
                            ? MovieWidget(movieController.advancedList[index])
                            : DetailsWidget(
                                movie: movieController.advancedList[
                                    movieController.selectedIndex.value],
                                index: movieController.selectedIndex.value));
                    // movieController.advancedList[
                    //movieController.selectedIndex.value]
                  },
                );
            }),
          )
        ],
      ),
    );
  }
}
