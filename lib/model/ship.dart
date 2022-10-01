// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:intl/intl.dart';

class Ship {
  late int id;
  late int tier;
  late String type;
  late bool is_special;
  late bool is_premium;
  late String nation;
  late String name;
  late String imgLink;
  String getRomanTier() {
    var romanList = [
      "0",
      "I",
      "II",
      "III",
      "IV",
      "V",
      "VI",
      "VII",
      "VIII",
      "IX",
      "X",
      "★"
    ];
    try {
      return romanList[tier];
    } catch (e) {
      return "Unknow";
    }
  }

  ShipData getShipData() {
    return ShipData(
        id, tier, type, name, nation, imgLink, is_special, is_premium);
  }

  Ship(this.id, this.tier, this.type, this.name, this.nation, this.imgLink,
      this.is_special, this.is_premium);
}

class ShipData extends Ship {
  // 非战斗数据
  late int lastBattleTime;
  late int distance;

  // 战斗数据
  late int battles;
  late int wins;
  late int losses;
  late int damageDealt;
  late int xp;
  late int frags;
  late int survivedBattles;
  // 主炮数据
  late int shots;
  late int hits;

  //最佳纪录
  late int maxDamageDealt;
  late int maxDamageScouting;
  late int maxFrags;
  late int maxPlanesKilled;
  late int maxTotalAgro;
  late int maxXp;

  //PR
  late int prNum;
  late Color prColor;
  late String prString;

  // 显示数据
  late String battlesString;
  late String winRate;
  late String damageAvg;
  late String xpAvg;
  late String KD;
  late String accuRate;

  void genPrColor() {
    if (prNum >= 2450) {
      prColor = const Color.fromARGB(255, 138, 43, 226);
      prString = '神佬平均';
      return;
    }
    if (prNum >= 2100) {
      prColor = const Color.fromARGB(255, 255, 0, 255);
      prString = '大佬平均';
      return;
    }
    if (prNum >= 1750) {
      prColor = const Color.fromARGB(255, 0, 100, 0);
      prString = '很好';
      return;
    }
    if (prNum >= 1350) {
      prColor = const Color.fromARGB(255, 0, 255, 0);
      prString = '好';
      return;
    }
    if (prNum >= 1100) {
      prColor = const Color.fromARGB(255, 255, 236, 139);
      prString = '平均水平';
      return;
    }
    if (prNum >= 750) {
      prColor = const Color.fromARGB(255, 238, 173, 14);
      prString = '低于平均';
      return;
    } else {
      prColor = const Color.fromARGB(255, 255, 0, 0);
      prString = '还需努力';
      return;
    }
  }

  void initPR(dynamic exps) {
    var expData = exps;
    var shipExpData = expData['data'][id.toString()];
    var avgDmg = shipExpData['average_damage_dealt'];
    var avgFrags = shipExpData['average_frags'];
    var avgWinRate = shipExpData['win_rate'];

    var rDmg = (damageDealt / battles) / avgDmg;
    var rFrags = (frags / battles) / avgFrags;
    var rWins = (wins / battles) * 100 / avgWinRate;

    var nDmg = max(0, (rDmg - 0.4)) / (1 - 0.4);
    var nFrags = max(0, (rFrags - 0.1)) / (1 - 0.1);
    var nWins = max(0, (rWins - 0.7)) / (1 - 0.7);

    var wr = (100 * (wins / battles));
    var wrW = (100 * asin(wr / 100)) / 158;
    var pr = (350 + (350 * wrW)) * nDmg +
        300 * nFrags +
        (150 + (350 * (1 - wrW))) * nWins;
    prNum = pr.toInt();
    genPrColor();
  }

  bool initShipData(Map shipJson, dynamic exps) {
    var pvp = shipJson['pvp'];
    lastBattleTime = shipJson['last_battle_time'];
    distance = shipJson['distance'];
    battles = pvp['battles'];
    wins = pvp['wins'];
    losses = pvp['losses'];
    damageDealt = pvp['damage_dealt'];
    survivedBattles = pvp['survived_battles'];
    xp = pvp['xp'];
    frags = pvp['frags'];
    shots = pvp['main_battery']['shots'];
    hits = pvp['main_battery']['hits'];
    maxDamageDealt = pvp['max_damage_dealt'];
    maxDamageScouting = pvp['max_damage_scouting'];
    maxFrags = pvp['max_frags_battle'];
    maxPlanesKilled = pvp['max_planes_killed'];
    maxTotalAgro = pvp['max_total_agro'];
    maxXp = pvp['max_xp'];

    battlesString = battles.toString();
    var format = NumberFormat.percentPattern();
    winRate = format.format(double.parse((wins / battles).toStringAsFixed(2)));
    xpAvg = (xp / battles).toStringAsFixed(0);
    KD = (frags / (battles - survivedBattles)).toStringAsFixed(1);
    if (shots != 0) {
      accuRate = format.format(double.parse((hits / shots).toStringAsFixed(2)));
    } else {
      accuRate = "N/A";
    }
    if (battles == 0) {
      prNum = 0;
      genPrColor();
    } else {
      try {
        initPR(exps);
      } catch (e) {
        prNum = 0;
        prColor = const Color.fromARGB(255, 105, 105, 105);
        prString = '不可用';
      }
    }
    return true;
  }

  ShipData(super.id, super.tier, super.type, super.name, super.nation,
      super.imgLink, super.is_special, super.is_premium);
}
