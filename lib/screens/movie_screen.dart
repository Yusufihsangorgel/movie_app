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
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              //  Get.to(SettingsScreen());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
              onPressed: () {
                //   Get.to(PushNotifications());
              },
              icon: Icon(
                Icons.notification_add,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Yusuf Movies',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 32,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.view_list_rounded), onPressed: () {}),
                IconButton(icon: Icon(Icons.grid_view), onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (movieController.isLoading.isTrue) {
                return (Center(
                  child: CircularProgressIndicator(),
                ));
              } else
                // ignore: curly_braces_in_flow_control_structures
                return AlignedGridView.count(
                  crossAxisCount: 2,
                  itemCount: movieController.advancedList.length,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  itemBuilder: (context, index) {
                    return MovieWidget(movieController.advancedList[index]);
                    //     Card(
                    //   elevation: 2,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Stack(
                    //           children: [
                    //             Container(
                    //               height: 180,
                    //               width: double.infinity,
                    //               clipBehavior: Clip.antiAlias,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(4),
                    //               ),
                    //               child: Image.network(
                    //                 movieController
                    //                     .advancedList[index].imageurl[0],
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //             Positioned(
                    //               right: 0,
                    //               child: const CircleAvatar(
                    //                 backgroundColor: Colors.white,
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //         SizedBox(height: 8),
                    //         Text(
                    //           movieController.advancedList[index].title,
                    //           maxLines: 2,
                    //           style: TextStyle(
                    //               fontFamily: 'avenir',
                    //               fontWeight: FontWeight.w800),
                    //           overflow: TextOverflow.ellipsis,
                    //         ),
                    //         SizedBox(height: 8),
                    //         if (movieController.advancedList[index].imdbid !=
                    //             null)
                    //           Container(
                    //             decoration: BoxDecoration(
                    //               color: Colors.green,
                    //               borderRadius: BorderRadius.circular(12),
                    //             ),
                    //             padding: const EdgeInsets.symmetric(
                    //                 horizontal: 4, vertical: 2),
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 Text(
                    //                   movieController
                    //                       .advancedList[index].imdbid,
                    //                   style: TextStyle(color: Colors.white),
                    //                 ),
                    //                 Icon(
                    //                   Icons.star,
                    //                   size: 16,
                    //                   color: Colors.white,
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         SizedBox(height: 8),
                    //         Text(movieController.advancedList[index].genre[0],
                    //             style: TextStyle(
                    //                 fontSize: 32, fontFamily: 'avenir')),
                    //       ],
                    //     ),
                    //   ),
                    // );
                  },
                  //  Tile(index) => StaggeredTile.fit(1),
                );
            }),
          )
        ],
      ),
    );
  }
}
