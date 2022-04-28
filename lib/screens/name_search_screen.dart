import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/name_movie_controller.dart';
import 'package:movie_app/widgets/search_widget.dart';

class NameSearchScreen extends StatelessWidget {
  const NameSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    final NameMovieController nameMovieController =
        Get.put(NameMovieController());
    return RefreshIndicator(
      onRefresh: () async {
        nameMovieController.fetchMovies();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Name Search Screen"),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: [
            AnimSearchBar(
                color: Colors.black,
                helpText: "Search for a movie",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                rtl: true,
                closeSearchOnSuffixTap: false,
                width: 400,
                textController: textController,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onSuffixTap: () {
                  if (textController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please enter a movie name",
                      icon: const Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.red,
                    );
                  } else {
                    nameMovieController.movieName.value = textController.text;
                    nameMovieController.fetchMovies();
                  }
                }),
            Expanded(
              child: Obx(() {
                if (nameMovieController.isError.isTrue) {
                  return const Center(
                    child: Text("Not Connection"),
                  );
                } else if (nameMovieController.isLoading.isTrue) {
                  return (const Center(
                    child: CircularProgressIndicator(),
                  ));
                } else
                  // ignore: curly_braces_in_flow_control_structures
                  return AlignedGridView.count(
                    crossAxisCount: 2,
                    itemCount: nameMovieController.movieList.length,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return SearchWidget(nameMovieController.movieList[index]);
                    },
                  );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120, bottom: 30),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (textController.text.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter a movie name",
                          icon: const Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                        );
                      } else if (nameMovieController.page.value < 3) {
                        nameMovieController.page.value += 1;
                        nameMovieController.fetchMovies();
                      } else {
                        Get.snackbar(
                          "Error",
                          "Max Page Reached",
                          icon: const Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: const Text("Next Page"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      if (textController.text.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please enter a movie name",
                          icon: const Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                        );
                      } else if (nameMovieController.page.value > 1) {
                        nameMovieController.page.value -= 1;
                        nameMovieController.fetchMovies();
                      } else {
                        Get.snackbar(
                          "Error",
                          "Min Page Reached",
                          icon: const Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: const Text("Last Page"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
