import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/movie_controller.dart';
import 'package:movie_app/screens/movie_screen.dart';

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
                            backgroundColor: Colors.red);
                      } else if (int.parse(movieController.endYear.value) <
                          int.parse(movieController.startYear.value)) {
                        Get.snackbar("Error",
                            "The start year cannot be greater than the end year",
                            backgroundColor: Colors.red);
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
                      title: const Text('Language'),
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
                      if (movieController.stepperIndex.value < 2) {
                        Get.snackbar(
                            "Error", "You have not selected the required steps",
                            backgroundColor: Colors.red);
                      } else {
                        Get.snackbar("Succesfull!", "Well Done..!",
                            backgroundColor: Colors.black,
                            colorText: Colors.white);
                        movieController.fetchAdvancedMovies();
                        Get.to(MovieScreen());
                      }
                    },
                    child: const Text('Exit')),
              ],
            )),
      ),
    );
  }
}
