import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ScoreSettingLogic extends GetxController {
  var play1Color = const Color(0xffff2700).obs;
  var play2Color = const Color(0xff72ff0a).obs;
  var versionStr = 'v1.0.0'.obs;
  var minutesStr = '5'.obs;

  void showTimeDia() {
    DatePicker.showDatePicker(Get.context!,
        dateFormat: 'mm',
        minDateTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, 1),
        onConfirm: (date, list) async {
      minutesStr.value = date.minute.toString();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('timeDown', date.minute);
    });
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final play1ColorStr = prefs.getString('play1') ?? '';
    final play2ColorStr = prefs.getString('play2') ?? '';
    play1Color.value = play1ColorStr.toColor() ?? const Color(0xffff2700);
    play2Color.value = play2ColorStr.toColor() ?? const Color(0xff72ff0a);
    var info = await PackageInfo.fromPlatform();
    versionStr.value = 'v${info.version}';
    minutesStr.value = prefs.getInt('timeDown')?.toString() ?? '5';
    super.onInit();
  }
}
