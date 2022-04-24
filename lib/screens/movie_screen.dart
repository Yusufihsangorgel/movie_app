import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/models/advanced_movie.dart';
import 'package:movie_app/widgets/movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Yusuf Movies',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 32,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.view_list_rounded),
                    onPressed: () {}),
                IconButton(icon: Icon(Icons.grid_view), onPressed: () {}),
              ],
            ),
          ),
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
                  itemCount: movieController.openDetails == false
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
                        child: movieController.openDetails == false
                            ? MovieWidget(movieController.advancedList[index])
                            : MovieWidget(movieController.advancedList[
                                movieController.selectedIndex.value]));
                  },
                );
            }),
          )
        ],
      ),
    );
  }
}
