import 'package:flutter/material.dart';
import 'package:wows_info_flutter/generated/l10n.dart';
import 'package:wows_info_flutter/providers/user_setting.dart';
import 'package:wows_info_flutter/widgets/horizontal_selector.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> settings = [
      const SetApiServer(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_title),
      ),
      body: ListView(
        children: settings,
      ),
    );
  }
}

class SetApiServer extends StatefulWidget {
  const SetApiServer({super.key});

  @override
  State<SetApiServer> createState() => _SetApiServerState();
}

class _SetApiServerState extends State<SetApiServer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(S.of(context).api_server),
            ),
            HorizontalSelector(
                selectedIndex:
                    Provider.of<UserSetting>(context, listen: false).apiServer,
                items: [
                  S.of(context).api_server_eu,
                  S.of(context).api_server_na,
                  S.of(context).api_server_asia,
                  S.of(context).api_server_ru
                ],
                onSelect: Provider.of<UserSetting>(context, listen: false)
                    .setApiServer)
          ],
        ),
      ),
    );
  }
}

class PinedUser extends StatefulWidget {
  const PinedUser({super.key});

  @override
  State<PinedUser> createState() => _PinedUserState();
}

class _PinedUserState extends State<PinedUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: ListTile(),
      ),
    );
  }
}
