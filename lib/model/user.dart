import 'package:wows_info_flutter/APIs.dart';

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
  late int lastBattleTime; // 上次战斗
  late int levelingTier; // 等级
  late int createdAt; // 账号创建时间
  late int levelingPoints; // ？
  late int updatedAt; // 上次更新？
  late bool hiddenProfile; // 隐藏战绩
  late int logoutAt; // 上次退出游戏
  late int distance; // 航行长度
  late int maxXp; // 最高xp
  late List maxShipsSpotted; // 最佳点亮
  late List maxDamageScouting; // 最大点亮伤害

  @override
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
}
