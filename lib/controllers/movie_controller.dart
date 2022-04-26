import 'package:get/get.dart';
import 'package:movie_app/models/advanced_movie.dart';
import 'package:movie_app/services/advanced_service.dart';

class MovieController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var openDetails = false.obs;
  var selectedIndex = 0.obs; // index of selected movie
  var drowdownStartYear = '2005'.obs;
  var dropdownEndYear = '2019'.obs;
  var isFavorite = false.obs;
  var stepperIndex = 0.obs;
  var yearList = <String>[].obs;
  var genreList = <String>[
    "Action",
    "Adult",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "Game-Show",
    "History",
    "Horror",
    "Music",
    "Musical",
    "Mystery",
    "News",
    "Reality-TV",
    "Romance",
    "Sci-Fi",
    "Short",
    "Sport",
    "Talk-Show",
    "Thriller",
    "War",
    "Western",
  ].obs;
  var imdbList = <String>[].obs;
  var languageList = <String>[
    "American Sign Language",
    "English",
    "French",
    "Turkish",
    "Japanese",
    "Indian Sign Language",
  ].obs;

  void addImdb() {
    for (var i = 0; i <= 10; i++) {
      imdbList.add(i.toString());
    }
  }

  void addYear() {
    for (var i = 1970; i < 2023; i++) {
      yearList.add(i.toString());
    }
  }

  // ----------------------------------
  var advancedList = <AdvancedMovie>[].obs;
  var startYear = '2005'.obs;
  var endYear = '2019'.obs;
  var minImdbRating = '0'.obs;
  var maxImdbRating = '10'.obs;
  var genre = 'Action'.obs;
  var movieLanguage = 'English'.obs;
  var crossCount = 2.obs;
  //------------------------------------

  @override
  void onInit() {
    addYear();
    addImdb();
    // fetchAdvancedMovies();
    super.onInit();
  }

  void openMovie(bool value) {
    print("girdi kanka : " + value.toString());

    openDetails.value = value;

    if (openDetails.value == false) {
      crossCount.value = 2;
    } else {
      crossCount.value = 1;
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
