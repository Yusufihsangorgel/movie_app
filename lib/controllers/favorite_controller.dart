import 'package:get/get.dart';
import 'package:movie_app/models/advanced_movie.dart';

class FavoriteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var favoriteList = <AdvancedMovie>[].obs;

  void addFavorite() {}
}
