import 'package:get/get.dart';
import 'package:movie_app/models/movie_model.dart';

import 'package:movie_app/services/movie_services.dart';

class NameMovieController extends GetxController {
  var movieList = <Movie>[].obs;
  var movieName = 'avengers'.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var page = 1.obs;

  @override
  void onInit() {
    //fetchMovies();
    super.onInit();
  }

  void fetchMovies() async {
    isLoading(true);
    try {
      var movies = await MovieServices.getMovies();
      if (movies != null) {
        movieList.value = movies;
        isLoading(false);
      }
    } on Exception catch (e) {
      isError.value = true;
      print(e);
    }
  }
}
