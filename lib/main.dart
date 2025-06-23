
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:score_reversed/pages/score_check/score_check_binding.dart';
import 'package:score_reversed/pages/score_check/score_check_view.dart';
import 'package:score_reversed/pages/score_main/score_main_binding.dart';
import 'package:score_reversed/pages/score_main/score_main_view.dart';
import 'package:score_reversed/pages/score_setting/score_setting_binding.dart';
import 'package:score_reversed/pages/score_setting/score_setting_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Colors.black;
Color bgColor = Colors.black;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final timeDown = prefs.getInt('timeDown');
  if (timeDown == null) {
    prefs.setInt('timeDown', 5);
    prefs.setString('play1', const Color(0xffff2700).toHexString());
    prefs.setString('play2', const Color(0xff72ff0a).toHexString());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Scores,
      initialRoute: '/score_main',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Scores = [
  GetPage(name: '/score_check', page: () => const ScoreCheckView(), binding: ScoreCheckBinding()),
  GetPage(name: '/score_main', page: () => const ScoreMainPage(), binding: ScoreMainBinding()),
  GetPage(name: '/score_setting', page: () => ScoreSettingPage(), binding: ScoreSettingBinding()),
];