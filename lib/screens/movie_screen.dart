import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/widgets/details_widget.dart';
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
              onPressed: () {}),
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
                            : DetailsWidget(movieController.advancedList[
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

class DetailsDialog extends StatelessWidget {
  const DetailsDialog({
    Key? key,
    required this.movieController,
  }) : super(key: key);

  final MovieController movieController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Film Details',
                  style: TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Stepper(
                  currentStep: movieController.stepperIndex.value,
                  onStepCancel: () {
                    if (movieController.stepperIndex.value > 0) {
                      movieController.stepperIndex.value -= 1;
                    }
                  },
                  onStepContinue: () {
                    if (movieController.stepperIndex.value >= 0 &&
                        movieController.stepperIndex.value < 2) {
                      movieController.stepperIndex.value += 1;
                    } else if (movieController.stepperIndex.value == 2) {
                      if (int.parse(movieController.maxImdbRating.value) <
                          int.parse(movieController.minImdbRating.value)) {
                        Get.snackbar("Error",
                            "min. IMDB Score Max. No Greater Than Your Score",
                            backgroundColor: Colors.black,
                            colorText: Colors.white);
                      } else if (int.parse(movieController.endYear.value) <
                          int.parse(movieController.startYear.value)) {
                        Get.snackbar("Error",
                            "The start year cannot be greater than the end year",
                            backgroundColor: Colors.black,
                            colorText: Colors.white);
                      } else {
                        movieController.fetchAdvancedMovies();
                        Get.back();
                      }
                    }
                  },
                  onStepTapped: (int index) {
                    movieController.stepperIndex.value = index;
                  },
                  steps: <Step>[
                    Step(
                      title: const Text('Start-End Year'),
                      content: Row(
                        children: [
                          DropdownButton<String>(
                            value: movieController.startYear.value,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              movieController.startYear.value = newValue!;
                            },
                            items: movieController.yearList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            value: movieController.endYear.value,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              movieController.endYear.value = newValue!;
                            },
                            items: movieController.yearList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Step(
                      title: const Text('Max-Min IMDB'),
                      content: Row(
                        children: [
                          DropdownButton<String>(
                            value: movieController.maxImdbRating.value,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              movieController.maxImdbRating.value = newValue!;
                            },
                            items: movieController.imdbList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            value: movieController.minImdbRating.value,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              movieController.minImdbRating.value = newValue!;
                            },
                            items: movieController.imdbList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Step(
                      title: Text('Language'),
                      content: DropdownButton<String>(
                        value: movieController.movieLanguage.value,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          movieController.movieLanguage.value = newValue!;
                        },
                        items: movieController.languageList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      if (int.parse(movieController.maxImdbRating.value) <
                          int.parse(movieController.minImdbRating.value)) {
                        Get.snackbar("Error",
                            "min. IMDB Score Max. No Greater Than Your Score",
                            backgroundColor: Colors.black,
                            colorText: Colors.white);
                      } else if (int.parse(movieController.endYear.value) <
                          int.parse(movieController.startYear.value)) {
                        Get.snackbar("Error",
                            "The start year cannot be greater than the end year",
                            backgroundColor: Colors.black,
                            colorText: Colors.white);
                      } else {
                        movieController.fetchAdvancedMovies();
                        Get.back();
                      }
                    },
                    child: const Text('End')),
              ],
            )),
      ),
    );
  }
}
