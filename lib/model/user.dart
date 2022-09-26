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

  int get getId => id;

  String get getName => name;

  String get getServer => server;
}
