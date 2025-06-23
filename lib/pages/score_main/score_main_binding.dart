import 'package:get/get.dart';

import 'score_main_logic.dart';

class ScoreMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScoreMainLogic());
  }
}
