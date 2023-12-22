// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wows_info_flutter/api.dart';

class UserSetting extends ChangeNotifier {
  final baseURLs = [
    'https://api.worldofwarships.eu',
    'https://api.worldofwarships.com',
    'https://api.worldofwarships.asia',
    'https://api.worldofwarships.ru',
  ];
  late SharedPreferences prefs;
  static const String COLOR_SEED_KEY = 'color_seed';
  static const String API_SERVER = 'api_server';

  Color colorSeed = const Color(0xff6750a4);

  int apiServer = 0;

  void setApiServer(int target) async {
    await prefs.setInt(COLOR_SEED_KEY, target);

    WowsApi().setBaseUrl(baseURLs[target]);

    apiServer = target;

    notifyListeners();

    return;
  }

  void setColorSeed(Color color) async {
    await prefs.setInt(COLOR_SEED_KEY, color.value);

    colorSeed = color;

    notifyListeners();

    return;
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();

    int color = prefs.getInt(COLOR_SEED_KEY) ?? 0xff6750a4;
    colorSeed = Color(color);

    apiServer = prefs.getInt(API_SERVER) ?? 0;
    WowsApi().setBaseUrl(baseURLs[apiServer]);

    notifyListeners();

    return;
  }
}
