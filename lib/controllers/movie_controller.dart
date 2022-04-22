import 'package:get/get.dart';
import 'package:movie_app/models/advanced_movie.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/advanced_service.dart';
import 'package:movie_app/services/movie_services.dart';

class MovieController extends GetxController {
  var movieList = <Movie>[].obs;
  var movieName = 'avengers'.obs;
  var isLoading = false.obs;

  // ----------------------------------
  var advancedList = <AdvancedMovie>[].obs;
  var startYear = '2005'.obs;
  var endYear = '2019'.obs;
  var minImdbRating = '0'.obs;
  var maxImdbRating = '10'.obs;
  var genre = 'action'.obs;
  //------------------------------------
  var movieLanguage = 'english'.obs;
  @override
  void onInit() {
    // fetchMovies();
    fetchAdvancedMovies();
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
      print(e);
    }
  }

  void fetchAdvancedMovies() async {
    isLoading(true);
    try {
      var advancedMovies = await AdvancedMovieService.getAdvancedMovies();
      if (advancedMovies != null) {
        advancedList.value = advancedMovies;
        isLoading(false);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
