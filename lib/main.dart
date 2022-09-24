import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'dart:io' show Platform;
import 'nav.dart';
import 'package:provider/provider.dart';
import 'common.dart';

void main() {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider.value(value: ColorSeed())],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final routes = {
    '/': (context, {arguments}) => HomePage(),
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
              colorSchemeSeed: const Color(0xff6750a4), // M3 Baseline
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
