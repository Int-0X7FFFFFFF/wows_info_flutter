import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:wows_info_flutter/init.dart';
import 'package:wows_info_flutter/model/ship.dart';
import 'package:wows_info_flutter/user/userShipData.dart';
import 'package:wows_info_flutter/user/userShips.dart';
import 'package:wows_info_flutter/user/userdata.dart';
import 'dart:io' show Platform;
import 'nav.dart';
import 'package:provider/provider.dart';
import 'common.dart';

void main() async {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    final overlayStye = _makeSystemOverlayStyle();
    SystemChrome.setSystemUIOverlayStyle(overlayStye);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: ColorSeed()),
      ChangeNotifierProvider.value(value: ShipList()),
      ChangeNotifierProvider.value(value: ShipExp()),
      ChangeNotifierProvider.value(value: AccountSetting()),
      ChangeNotifierProvider.value(value: Setting()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = {
    '/': (context, {arguments}) => const HomePage(),
    'init': (context, {arguments}) => const InitPage(),
    '/userdata': (context, {arguments}) => const UserData(),
    '/userdata/userships': (context, {arguments}) => const UserShips(),
    '/userdata/userships/ship': (context, {arguments}) => const ShipDataPage(),
  };

  Future<dynamic> highRefreshRate() async {
    // 高刷新率兼容
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } on Exception catch (e) {
      /// e.code =>
      /// noAPI - No API support. Only Marshmallow and above.
      /// noActivity - Activity is not available. Probably app is in background
      // ignore: avoid_print
      print(e.toString());
    }
    return 'OK';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: highRefreshRate(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            title: 'wows flutter',
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed:
                  Provider.of<ColorSeed>(context).getColor, // M3 Baseline
            ),
            darkTheme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: Provider.of<ColorSeed>(context).getColor,
                brightness: Brightness.dark // M3 Baseline
                ),
            routes: routes,
            initialRoute: '/',
          );
        } else {
          return const MaterialApp();
        }
      },
    );
  }
}

SystemUiOverlayStyle _makeSystemOverlayStyle() {
  return const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  );
}
