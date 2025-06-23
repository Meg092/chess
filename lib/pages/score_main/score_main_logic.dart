import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ScoreMainLogic extends GetxController {
  var play1Color = const Color(0xffff2700).obs;
  var play2Color = const Color(0xff72ff0a).obs;
  var downtime = 300.obs;
  var initialTimeValue = 300.obs;
  var downtimeStr = '05:00'.obs;
  var play1Score = 0.obs;
  var play2Score = 0.obs;
  var isStart = false.obs;

  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    _timer = null;
    isStart.value = true;
    downtimeStr.value =
        '${downtime ~/ 60 < 10 ? '0${downtime ~/ 60}' : '${downtime ~/ 60}'}:${downtime % 60 < 10 ? '0${downtime % 60}' : '${downtime % 60}'}';
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (downtime.value > 0) {
        downtime.value--;
        downtimeStr.value =
            '${downtime ~/ 60 < 10 ? '0${downtime ~/ 60}' : '${downtime ~/ 60}'}:${downtime % 60 < 10 ? '0${downtime % 60}' : '${downtime % 60}'}';
      } else {
        _timer?.cancel();
        _timer = null;
        isStart.value = false;
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    isStart.value = false;
  }

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final play1ColorStr = prefs.getString('play1') ?? '';
    final play2ColorStr = prefs.getString('play2') ?? '';
    initialTimeValue.value = (prefs.getInt('timeDown') ?? 5) * 60;
    downtime.value = (prefs.getInt('timeDown') ?? 5) * 60;
    play1Color.value = play1ColorStr.toColor() ?? const Color(0xffff2700);
    play2Color.value = play2ColorStr.toColor() ?? const Color(0xff72ff0a);
    downtimeStr.value =
        '${downtime ~/ 60 < 10 ? '0${downtime ~/ 60}' : '${downtime ~/ 60}'}:${downtime % 60 < 10 ? '0${downtime % 60}' : '${downtime % 60}'}';
    stopTimer();
  }

  void resetData() {
    play1Score.value = 0;
    play2Score.value = 0;
    downtime.value = initialTimeValue.value;
    downtimeStr.value =
        '${downtime ~/ 60 < 10 ? '0${downtime ~/ 60}' : '${downtime ~/ 60}'}:${downtime % 60 < 10 ? '0${downtime % 60}' : '${downtime % 60}'}';
    stopTimer();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
