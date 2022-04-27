import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:get/get.dart';
import 'package:movie_app/controllers/name_movie_controller.dart';

class NameSearchScreen extends StatelessWidget {
  const NameSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    final NameMovieController nameMovieController =
        Get.put(NameMovieController());
    return AnimSearchBar(
      width: 400,
      textController: textController,
      suffixIcon: Icon(Icons.search),
      onSuffixTap: () {
        print(textController.text);
      },
    );
  }
}
