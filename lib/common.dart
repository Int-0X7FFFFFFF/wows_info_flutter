import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorSeed extends ChangeNotifier {
  var colorSeed = const Color(0xff6750a4);

  void setColor(targetColor) {
    colorSeed = targetColor;
    notifyListeners();
  }

  Color get getColor => colorSeed;
}

class ShipList extends ChangeNotifier {
  Map shipList = {};
  int version = 0;

  void setShipList(Map targetShipList, int targetVersion) {
    shipList = targetShipList;
    version = version;
    notifyListeners();
  }

  Map get getShipList => shipList;
  int get getVersion => version;
}

class ShipExp extends ChangeNotifier {
  Map shipExp = {};

  void setShipExp(Map targetShipExp) {
    shipExp = targetShipExp;
    notifyListeners();
  }

  Map get getShipExp => shipExp;
}

class AccountSetting extends ChangeNotifier {
  Map trackedAccount = {};
  String mainAccount = '';
  String mainAccountServer = 'asia';

  void setTrackedAccount(Map targetTrackedAccount) {
    trackedAccount = trackedAccount;
    notifyListeners();
  }

  void setMainAccount(
      String targetMainAccount, String targetMainnAccountServer) {
    mainAccount = targetMainAccount;
    mainAccountServer = targetMainnAccountServer;
    notifyListeners();
  }

  Map get getTrackedAccount => trackedAccount;

  String get getMianAccount => mainAccount;

  String get getMianAccountServer => mainAccountServer;
}

class Setting extends ChangeNotifier {
  String apiServer = 'asia';
  bool translate = true;
  bool github = true;
  int shipListUpdate = 0;
  int shipExpUpdate = 0;

  void setApiServer(String targetApiServer) {
    apiServer = targetApiServer;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('apiServer', targetApiServer);
    });
    notifyListeners();
  }

  void setTranslate(bool targetTranslate) {
    translate = targetTranslate;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('translate', targetTranslate);
    });
    notifyListeners();
  }

  void setGithub(bool targetGithub) {
    github = targetGithub;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('github', targetGithub);
    });
    notifyListeners();
  }

  void setShipListUpdate(int targetShipListUpdate) {
    shipListUpdate = targetShipListUpdate;
    notifyListeners();
  }

  void setShipExpUpdate(int targetShipExpUpdate) {
    shipExpUpdate = targetShipExpUpdate;
    notifyListeners();
  }

  String get getApiServer => apiServer;
  bool get getTranslate => translate;
  bool get getGithub => github;
  int get getShipListUpdate => shipListUpdate;
  int get getShipExpupdate => shipExpUpdate;
}
