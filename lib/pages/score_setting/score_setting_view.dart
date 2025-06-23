import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import 'score_setting_logic.dart';

class ScoreSettingPage extends GetView<ScoreSettingLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        foregroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: <Widget>[
                <Widget>[
                  Obx(() {
                    return Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          color: controller.play1Color.value,
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(color: Colors.white, width: 2)),
                    );
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'PLAYER 01 Color',
                    style: TextStyle(color: Colors.white),
                  )
                ].toRow(),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return ColorPicker(
                      pickerColor: controller.play1Color.value,
                      colorPickerWidth: 300,
                      onColorChanged: (v) async {
                        controller.play1Color.value = v;
                        final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.setString('play1', v.toHexString());
                      });
                }),
                const SizedBox(
                  height: 10,
                ),
                <Widget>[
                  Obx(() {
                    return Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                          color: controller.play2Color.value,
                          borderRadius: BorderRadius.circular(11)),
                    );
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'PLAYER 02 Color',
                    style: TextStyle(color: Colors.white),
                  )
                ].toRow(),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return ColorPicker(
                      pickerColor: controller.play2Color.value,
                      colorPickerWidth: 300,
                      onColorChanged: (v) async {
                        controller.play2Color.value = v;
                        final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.setString('play2', v.toHexString());
                      });
                }),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 53,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: <Widget>[
                    const Text(
                      'Set minutes',
                      style: TextStyle(color: Colors.white),
                    ),
                    <Widget>[
                      Obx(() {
                        return Text(
                          '${controller.minutesStr.value} minutes',
                          style: const TextStyle(color: Colors.white),
                        );
                      }),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 25,
                        color: Colors.white,
                      )
                    ].toRow(mainAxisAlignment: MainAxisAlignment.end)
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ).decorated(
                    color: const Color(0xff414141),
                    borderRadius: BorderRadius.circular(12)).gestures(onTap: (){
                      controller.showTimeDia();
                }),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 53,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: <Widget>[
                    const Text(
                      'Version info',
                      style: TextStyle(color: Colors.white),
                    ),
                    Obx(() {
                      return Text(
                        controller.versionStr.value,
                        style: const TextStyle(color: Colors.white),
                      );
                    })
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ).decorated(
                    color: const Color(0xff414141),
                    borderRadius: BorderRadius.circular(12))
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            ).marginAll(15)),
      ),
    );
  }
}
