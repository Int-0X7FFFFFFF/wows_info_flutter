import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wows_info_flutter/APIs.dart';
import 'package:wows_info_flutter/common.dart';
import 'package:wows_info_flutter/model/ship.dart';

class User {
  late int id;
  late String name;
  late String server;

  void setUser(int targetId, String targetName, String targetServer) {
    id = targetId;
    name = targetName;
    server = targetServer;
    return;
  }

  Future<bool> initUser(int targetId, String targetServer) async {
    id = targetId;
    server = targetServer;
    try {
      var personalData = await apiPersonData(id, server);
      if (personalData['status'] == 'ok') {
        name = personalData['data'][targetId.toString()]['nickname'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  User();

  int get getId => id;

  String get getName => name;

  String get getServer => server;
}

class UserProfile extends User {
  late Map orgJson; // 原始json

  // 非战斗数据
  late int lastBattleTime; // 上次战斗
  late int levelingTier; // 等级
  late int createdAt; // 账号创建时间
  late bool hiddenProfile; // 隐藏战绩
  late int logoutAt; // 上次退出游戏
  late int distance; // 航行长度

  // 战斗数据
  // 基本战斗数据
  late int battles; // 战斗场数
  late int wins; //胜场
  late int losses; //败场
  late int damageDealt; // 总伤害
  late int xp; // 总经验
  late int frags; // 总k头
  late int survivedBattles;
  // 主炮参数
  late int fragsBattery; // 主炮k头
  late int hits; // 主炮命中
  late int shots; // 发射
  // 详细数据
  late int draws; // 平局
  late int shipsSpotted; // 点亮数

  // 最佳数据
  late List maxDamageDealt; //最大伤害
  late List maxFrags; //最大k头
  late List maxPlanesKilled; //
  late List maxXp; // 最高xp
  late List maxShipsSpotted; // 最佳点亮
  late List maxDamageScouting; // 最大点亮伤害
  late List maxTotalAgro; // 最大潜在

  // 船表
  late List shipList; // 玩家船只列表

  // PR
  late int prNum; // pr 数值
  late Color prColor; // pr 颜色
  late String prString; // pr

  // 显示数据
  late String battlesString;
  late String winRate;
  late String damageAvg;
  late String xpAvg;
  late String KD;
  late String accuRate;

  UserProfile();

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

  Future<bool> initShips(dynamic context) async {
    try {
      var ships = Provider.of<ShipList>(context).getShips;
      var userShipJson = await apiUserShipList(id.toString(), server);
      if (userShipJson['status'] == 'ok') {
        for (var shipJson in userShipJson['data'][id.toString()]) {
          var shipId = shipJson['ship_id'];
          Ship shipTmp = ships[shipId];
          var shipDataTmp = shipTmp.getShipData();
          shipDataTmp.initShipData(shipJson, context);
          shipDataTmp.initPR(context);
          shipList.add(shipDataTmp);
        }
        int prTotal = 0;
        for (ShipData shipData in shipList) {
          prTotal += shipData.prNum.toInt();
          prNum = prTotal ~/ battles;
        }
        genPrColor();
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> initUser(int targetId, String targetServer) async {
    id = targetId;
    server = targetServer;
    try {
      var personalData = await apiPersonData(id, server);
      if (personalData['status'] == 'ok') {
        hiddenProfile =
            personalData['data'][targetId.toString()]['hidden_profile'];
        name = personalData['data'][targetId.toString()]['nickname'];
        if (!hiddenProfile) {
          var data = personalData['data'][targetId.toString()];
          var pvp = data['statistics']['pvp'];
          // 非战斗数据
          lastBattleTime = data['last_battle_time'];
          levelingTier = data['leveling_tier'];
          createdAt = data['created_at'];
          logoutAt = data['logout_at'];
          distance = data['statistics']['distance'];

          // 战斗数据
          // 基本战斗数据
          battles = pvp['battles'];
          wins = pvp['wins'];
          losses = pvp['losses'];
          damageDealt = pvp['damage_dealt'];
          xp = pvp['xp'];
          frags = pvp['frags'];
          survivedBattles = pvp['survived_battles'];
          // 主炮参数
          fragsBattery = pvp['main_battery']['frags'];
          hits = pvp['main_battery']['hits'];
          shots = pvp['main_battery']['shots'];
          // 详细数据
          draws = pvp['draws'];
          shipsSpotted = pvp['ships_spotted'];

          // 最佳数据
          maxDamageDealt = [
            pvp['max_damage_dealt'],
            pvp['max_damage_dealt_ship_id']
          ];
          maxFrags = [pvp['max_frags_battle'], pvp['max_frags_ship_id']];
          maxXp = [pvp['max_xp'], pvp['max_xp_ship_id']];
          maxPlanesKilled = [
            pvp['max_planes_killed'],
            pvp['max_planes_killed_ship_id']
          ];
          maxShipsSpotted = [
            pvp['max_ships_spotted'],
            pvp['max_ships_spotted_ship_id']
          ];
          maxDamageScouting = [
            pvp['max_damage_scouting'],
            pvp['max_scouting_damage_ship_id']
          ];
          maxTotalAgro = [pvp['max_total_agro'], pvp['max_total_agro_ship_id']];

          battlesString = battles.toString();
          var format = NumberFormat.percentPattern();
          winRate =
              format.format(int.parse((wins / battles).toStringAsFixed(2)));
          xpAvg = (xp / battles).toStringAsFixed(0);
          KD = (frags / (battles - survivedBattles)).toStringAsFixed(1);
          if (shots != 0) {
            accuRate =
                format.format(int.parse((hits / shots).toStringAsFixed(2)));
          } else {
            accuRate = "N/A";
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
