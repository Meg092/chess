import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:score_reversed/pages/score_main/volume_control.dart';
import 'package:styled_widget/styled_widget.dart';
import 'dart:math' as math;
import 'score_main_logic.dart';

class ScoreMainPage extends StatefulWidget {
  const ScoreMainPage({Key? key}) : super(key: key);

  @override
  State<ScoreMainPage> createState() => _ScoreMainPageState();
}

class _ScoreMainPageState extends State<ScoreMainPage> {
  ScoreMainLogic controller = Get.find();

  void cijabkbsd() async {
    final hadNetwork = await InternetConnectionChecker.instance.hasConnection;
    if (!hadNetwork) {
      Get.toNamed('/score_check');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    cijabkbsd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: <Widget>[
          Expanded(child: LayoutBuilder(builder: (_, max) {
            return Transform(
              transform: Matrix4.identity()..rotateZ(math.pi),
              alignment: Alignment.center,
              child: Obx(() {
                return VolumeControl(
                  width: double.infinity,
                  height: max.maxHeight,
                  minValue: 0,
                  maxValue: controller.initialTimeValue.value.toDouble(),
                  initialValue: controller.downtime.value.toDouble(),
                  bgColor: controller.play1Color.value,
                  child: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '${controller.play1Score}:${controller.play2Score}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                            color: Colors.white),
                      ),
                    ).decorated(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: 2)),
                    Obx(() {
                      return Text(
                        controller.downtimeStr.value,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 100,
                            fontWeight: FontWeight.bold),
                      );
                    }),
                    Container(
                      width: 145,
                      height: 44,
                      alignment: Alignment.center,
                      child: const Text(
                        'Score +1',
                        style: TextStyle(
                            color:Color(0xffff2700), fontWeight: FontWeight.bold),
                      ),
                    )
                        .decorated(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22))
                        .gestures(onTap: () {
                      controller.play1Score++;
                    }),
                  ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
                );
              }),
            );
          })),
          <Widget>[
            const Icon(
              Icons.settings,
              size: 50,
              color: Colors.white,
            ).gestures(onTap: () {
              Get.toNamed('/score_setting')?.then((_) {
                controller.getData();
              });
            }),
            const SizedBox(
              width: 50,
            ),
            const Icon(
              Icons.refresh,
              size: 50,
              color: Colors.white,
            ).gestures(onTap: () {
              controller.resetData();
            }),
            const SizedBox(
              width: 50,
            ),
            Obx(() {
              return Icon(
                controller.isStart.value
                    ? Icons.pause
                    : Icons.play_arrow_rounded,
                size: 60,
                color: Colors.white,
              );
            }).gestures(onTap: () {
              if (controller.isStart.value) {
                controller.stopTimer();
              } else {
                controller.startTimer();
              }
            }),
          ]
              .toRow(mainAxisAlignment: MainAxisAlignment.center)
              .marginSymmetric(vertical: 30),
          Expanded(child: LayoutBuilder(builder: (_, max) {
            return Obx(() {
              return VolumeControl(
                width: double.infinity,
                height: max.maxHeight,
                minValue: 0,
                maxValue: controller.initialTimeValue.value.toDouble(),
                initialValue: controller.downtime.value.toDouble(),
                bgColor: controller.play2Color.value,
                child: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '${controller.play1Score}:${controller.play2Score}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          color: Colors.black),
                    ),
                  ).decorated(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 2)),
                  Obx(() {
                    return Text(
                      controller.downtimeStr.value,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 100,
                          fontWeight: FontWeight.bold),
                    );
                  }),
                  Container(
                    width: 145,
                    height: 44,
                    alignment: Alignment.center,
                    child: const Text(
                      'Score +1',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                      .decorated(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(22))
                      .gestures(onTap: () {
                    controller.play2Score++;
                  }),
                ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
              );
            });
          }))
        ].toColumn().marginAll(15),
      ),
    );
  }
}
