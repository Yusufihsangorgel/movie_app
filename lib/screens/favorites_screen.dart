import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/widgets/dialog_widget.dart';
import 'package:movie_app/widgets/movie_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieController movieController = Get.put(MovieController());
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
              exit(0);
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
                  itemCount: movieController.favoriteAdvancedList.length,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  itemBuilder: (context, index) {
                    return MovieWidget(
                        movieController.favoriteAdvancedList[index]);

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
