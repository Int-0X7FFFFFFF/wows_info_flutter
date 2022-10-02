import 'package:flutter/material.dart';
import 'package:wows_info_flutter/model/ship.dart';
import 'package:wows_info_flutter/model/user.dart';

class UserShips extends StatefulWidget {
  const UserShips({super.key});

  @override
  State<UserShips> createState() => _UserShipsState();
}

class _UserShipsState extends State<UserShips> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    UserProfile userProfile = arguments['user'];
    var ships = userProfile.shipList;
    ships.sort((a, b) => DateTime.fromMicrosecondsSinceEpoch(b.lastBattleTime)
        .compareTo(DateTime.fromMicrosecondsSinceEpoch(a.lastBattleTime)));
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
          ),
          itemBuilder: ((context, index) {
            ShipData ship = ships[index];
            return GestureDetector(
              onTap: () {},
              child: Card(
                child: Column(
                  children: [
                    Image.network(ship.imgLink),
                    Center(
                      child: Text('${ship.getRomanTier()} ${ship.name}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.sailing,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Text(
                                ship.battlesString,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.emoji_events,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Text(
                                ship.winRate,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.api,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              Text(
                                ship.damageAvg,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      child: LinearProgressIndicator(
                        minHeight: 10,
                        value: 1,
                        backgroundColor: ship.prColor,
                        valueColor: AlwaysStoppedAnimation<Color>(ship.prColor),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}
