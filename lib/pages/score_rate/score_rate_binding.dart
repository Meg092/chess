import 'package:get/get.dart';

import 'score_rate_logic.dart';

class ScoreRateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ScoreRateLogic(),
      permanent: true,
    );
  }
}
