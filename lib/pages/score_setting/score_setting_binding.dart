import 'package:get/get.dart';

import 'score_setting_logic.dart';

class ScoreSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScoreSettingLogic());
  }
}
