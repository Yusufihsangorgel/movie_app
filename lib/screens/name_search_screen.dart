import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class NameSearchScreen extends StatelessWidget {
  const NameSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(top: 58.0, right: 10, left: 10),

      /// In AnimSearchBar widget, the width, textController, onSuffixTap are required properties.
      /// You have also control over the suffixIcon, prefixIcon, helpText and animationDurationInMilli
      child: AnimSearchBar(
        width: 400,
        textController: textController,
        onSuffixTap: () {},
      ),
    );
  }
}
