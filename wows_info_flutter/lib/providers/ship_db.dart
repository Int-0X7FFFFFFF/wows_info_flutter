// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wows_info_flutter/models/ship.dart';

class ShipDB extends ChangeNotifier {
  late Map<int, Ship> ships;
  late SharedPreferences pref;
  int status = -2;

  static const SHIP_DATA_KEY = 'ship_data';
  static const SHIP_EXP_KEY = 'ship_exp';

  void init() async {
    pref = await SharedPreferences.getInstance();

    String? shipsJson = pref.getString(SHIP_DATA_KEY);
    String? shipExp = pref.getString(SHIP_EXP_KEY);
    if (shipsJson == null) {
      shipsJson = await rootBundle.loadString('assets/json/ship_list.json');
      pref.setString(SHIP_DATA_KEY, shipsJson);
    }
    if (shipExp == null) {
      shipExp = await rootBundle.loadString('assets/json/ship_exp.json');
      pref.setString(SHIP_EXP_KEY, shipExp);
    }

    Map<String, dynamic> shipsMap = jsonDecode(shipsJson);
    Map<String, dynamic> shipExpMap = jsonDecode(shipExp);

    ships = {};

    shipsMap.forEach((key, value) {
      var shipExp = shipExpMap['data'][key];
      if (shipExp is! Map<String, dynamic>) {
        shipExp = {
          "average_damage_dealt": 0.0,
          "average_frags": 0.0,
          "win_rate": 0.0
        };
      }

      ships[int.parse(key)] = Ship.fromMap(value, int.parse(key), shipExp);
    });
    status = 0;
    return;
  }
}
