import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:wows_info_flutter/pages/home_page.dart';
import 'package:wows_info_flutter/providers/ship_db.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Future init(BuildContext context) async {
    Provider.of<ShipDB>(context).init();
    return 'ok';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: init(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ));
            });
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                  color: Theme.of(context).colorScheme.primary, size: 100),
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.newtonCradle(
                  color: Theme.of(context).colorScheme.primary, size: 100),
            );
          }
        },
      ),
    );
  }
}
