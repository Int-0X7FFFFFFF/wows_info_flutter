import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:provider/provider.dart';
import 'package:wows_info_flutter/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wows_info_flutter/pages/splash_pages.dart';
import 'package:wows_info_flutter/providers/ship_db.dart';

import 'package:wows_info_flutter/providers/user_setting.dart';

final UserSetting userSetting = UserSetting();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  userSetting.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: userSetting),
      ChangeNotifierProvider.value(value: ShipDB()),
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
  @override
  Widget build(BuildContext context) {
    return _buildMaterial(context);
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildMaterial(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));

    final botToastBuilder = BotToastInit();

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          navigatorObservers: [BotToastNavigatorObserver()],
          title: 'Wows Flutter',
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Provider.of<UserSetting>(context).colorSeed,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Provider.of<UserSetting>(context).colorSeed,
            brightness: Brightness.dark,
          ),
          home: Builder(
            builder: (context) {
              return const SplashPage();
            },
          ),
          builder: (context, child) {
            child = botToastBuilder(context, child);
            return child;
          },
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
