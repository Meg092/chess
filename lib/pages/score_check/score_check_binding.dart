import 'package:get/get.dart';

import 'score_check_logic.dart';

class ScoreCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScoreCheckLogic());
  }
}
