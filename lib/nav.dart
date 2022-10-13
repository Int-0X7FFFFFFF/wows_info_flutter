import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wows_flutter/home/index.dart';
import 'package:wows_flutter/setting/setting.dart';
import 'package:wows_flutter/user/userPage.dart';
import 'common.dart';

var _controller = PageController(
  initialPage: 0,
);

int _selectedIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      bool first = prefs.getBool("first") ?? true;
      if (!first) {
        String wowsShipList = prefs.getString('wowsShipList') ?? '{}';
        String wowsExp = prefs.getString('wowsExp') ?? '{}';
        String trackedAccount = prefs.getString('trackedAccount') ?? '{}';
        String mainAccount = prefs.getString('mainAccount') ?? '';
        String mainAccountServer =
            prefs.getString('mainAccountServer') ?? 'asia';
        int jsonVersion = prefs.getInt('jsonVersion') ?? 0;
        Provider.of<ShipList>(context, listen: false)
            .setShipList(jsonDecode(wowsShipList), jsonVersion);
        Provider.of<ShipExp>(context, listen: false)
            .setShipExp(jsonDecode(wowsExp));
        Provider.of<AccountSetting>(context, listen: false)
            .setTrackedAccount(jsonDecode(trackedAccount));
        Provider.of<AccountSetting>(context, listen: false)
            .setMainAccount(mainAccount, mainAccountServer);
      } else {
        rootBundle.loadString('lib/json/wows_ship_list.json').then((readJson) {
          Map<String, dynamic> wowsShipList = jsonDecode(readJson);
          prefs.setString('wowsShipList', jsonEncode(wowsShipList));
        });
        rootBundle.loadString('lib/json/wows_exp.json').then((readJson) {
          Map<String, dynamic> wowsExp = jsonDecode(readJson);
          prefs.setString('wowsExp', jsonEncode(wowsExp));
        });
        rootBundle.loadString('lib/json/josn_version.json').then((readJson) {
          Map<String, dynamic> jsonVersion = jsonDecode(readJson);
          int version = jsonVersion['wows_ship_list'];
          prefs.setInt('jsonVersion', version);
        });
        prefs.setString('mainAccount', '');
        prefs.setString('mainAccountServer', 'asia');
        Provider.of<Setting>(context, listen: false).setGithub(true);
        Provider.of<Setting>(context, listen: false).setApiServer('asia');
        Provider.of<Setting>(context, listen: false).setTranslate(true);
        Navigator.of(context).pushNamedAndRemoveUntil('init', (route) => false);
      }
    });
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          Index(),
          UserPage(),
          SettingPage(),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _onItemTapped(int index) {
    setState(() {
      _controller.jumpToPage(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home),
          label: '主页',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: '主账号',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: '设置',
        ),
      ],
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onItemTapped,
    );
  }
}
