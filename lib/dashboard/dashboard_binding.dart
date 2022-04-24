import 'package:get/instance_manager.dart';

import 'package:get/get.dart';

import 'package:movie_app/dashboard/dashboard_controller.dart';

class DashBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
  }
}
