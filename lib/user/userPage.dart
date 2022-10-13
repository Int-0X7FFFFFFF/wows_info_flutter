import 'package:delayed_widget/delayed_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wows_info_flutter/common.dart';

import '../model/user.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('主账号')),
      body: userDataBody(context),
    );
  }
}

userDataBody(BuildContext context) {
  var userID = Provider.of<AccountSetting>(context).getMianAccount;
  var userServer = Provider.of<AccountSetting>(context).getMianAccountServer;
  final ships = Provider.of<ShipList>(context).getShips;
  final shipExps = Provider.of<ShipExp>(context).getShipExp;
  if (userID != "") {
    User user = User();
    user.initUser(int.parse(userID), userServer);
    return FutureBuilder(
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          UserProfile userProfile = snapshot.data ?? UserProfile();
          var crateAt =
              DateTime.fromMillisecondsSinceEpoch(userProfile.createdAt * 1000)
                  .toString()
                  .substring(0, 10);
          var lastBattle = DateTime.fromMillisecondsSinceEpoch(
                  userProfile.lastBattleTime * 1000)
              .toString()
              .substring(0, 10);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/userdata/userships',
                    arguments: {'user': userProfile});
              },
              child: const Icon(Icons.dashboard),
            ),
            body: ListView(children: [
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 50),
                  child: Center(
                    child: Text(
                      userProfile.clanTag,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  )),
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 100),
                  child: Center(
                    child: Text(
                      userProfile.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  )),
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 150),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(37, 10, 44, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '注册日期',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          '最后战斗',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ))),
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 200),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          crateAt,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          lastBattle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ))),
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 250),
                  child: SizedBox(
                    height: 30,
                    child: ColoredBox(
                      color: userProfile.prColor,
                      child: Center(
                          child: Text(
                        '${userProfile.prString} ${userProfile.prNum}',
                        style: const TextStyle(color: Colors.black),
                      )),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: FlipCard(
                  fill: Fill.fillBack,
                  front: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 10, 32, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DelayedWidget(
                                  delayDuration:
                                      const Duration(milliseconds: 300),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.sailing,
                                          size: 64,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        Text(
                                          userProfile.battles.toString(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer),
                                        )
                                      ],
                                    ),
                                  )),
                              DelayedWidget(
                                  delayDuration:
                                      const Duration(milliseconds: 370),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.emoji_events,
                                          size: 64,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        Text(
                                          userProfile.winRate.toString(),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer),
                                        )
                                      ],
                                    ),
                                  )),
                              DelayedWidget(
                                  delayDuration:
                                      const Duration(milliseconds: 400),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.api,
                                          size: 64,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        Text(
                                          userProfile.damageAvg,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 10, 32, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DelayedWidget(
                                  delayDuration:
                                      const Duration(milliseconds: 370),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.star_purple500,
                                          size: 64,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        Text(
                                          userProfile.xpAvg,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer),
                                        )
                                      ],
                                    ),
                                  )),
                              DelayedWidget(
                                  delayDuration:
                                      const Duration(milliseconds: 420),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.gavel,
                                          size: 64,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        Text(
                                          userProfile.KD,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer),
                                        )
                                      ],
                                    ),
                                  )),
                              DelayedWidget(
                                  delayDuration:
                                      const Duration(milliseconds: 450),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.network_ping,
                                          size: 64,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        Text(
                                          userProfile.accuRate,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  back: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 10, 32, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Column(
                                        children: [
                                          const Text('胜场'),
                                          Text(userProfile.wins.toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: Column(
                                        children: [
                                          const Text('击发炮弹'),
                                          Text(userProfile.shots.toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: Column(
                                        children: [
                                          const Text('航行距离'),
                                          Text(userProfile.distance.toString())
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Column(
                                        children: [
                                          const Text('平局'),
                                          Text(userProfile.draws.toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: Column(
                                        children: [
                                          const Text('摧毁战舰'),
                                          Text(userProfile.frags.toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: Column(
                                        children: [
                                          const Text('造成伤害'),
                                          Text(userProfile.damageDealt
                                              .toString())
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Column(
                                        children: [
                                          const Text('败场'),
                                          Text(userProfile.losses.toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: Column(
                                        children: [
                                          const Text('炮弹命中'),
                                          Text(userProfile.hits.toString())
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 0),
                                      child: Column(
                                        children: [
                                          const Text('获得经验'),
                                          Text(userProfile.xp.toString())
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))),
                ),
              ),
              DelayedWidget(
                delayDuration: const Duration(milliseconds: 500),
                child:
                    Center(child: maxDamageWidget(userProfile, ships, context)),
              ),
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 550),
                  child:
                      Center(child: maxXpWidget(userProfile, ships, context))),
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 600),
                  child: Center(
                      child: maxFragsWidget(userProfile, ships, context))),
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 650),
                  child: Center(
                      child: maxPlanWidget(userProfile, ships, context))),
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 700),
                  child: Center(
                      child: maxAgroWidget(userProfile, ships, context))),
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 700),
                  child: Center(
                      child: maxSpotDmgWidget(userProfile, ships, context))),
              DelayedWidget(
                  delayDuration: const Duration(milliseconds: 700),
                  child: Center(
                      child: maxSpotnumWidget(userProfile, ships, context))),
            ]),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      }),
      future: init(user, ships, shipExps),
    );
  } else {
    return Center(
      child: Column(children: const [
        Icon(
          Icons.kitesurfing,
          size: 56,
        ),
        Text("还没有主账号绑定一个？"),
      ]),
    );
  }
}

maxDamageWidget(UserProfile userProfile, Map ships, BuildContext context) {
  try {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                    ships[userProfile.maxDamageDealt[1]].imgLink.toString()),
                Text(ships[userProfile.maxDamageDealt[1]].getRomanTier() +
                    ' ' +
                    ships[userProfile.maxDamageDealt[1]].name)
              ],
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 16, 0),
              child: Column(children: [
                const Text('最大伤害'),
                Text(userProfile.maxDamageDealt[0].toString())
              ]),
            )),
          ],
        ),
      ),
    );
  } catch (e) {
    return Container();
  }
}

maxSpotnumWidget(UserProfile userProfile, Map ships, BuildContext context) {
  try {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                    ships[userProfile.maxShipsSpotted[1]].imgLink.toString()),
                Text(ships[userProfile.maxShipsSpotted[1]].getRomanTier() +
                    ' ' +
                    ships[userProfile.maxShipsSpotted[1]].name)
              ],
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 16, 0),
              child: Column(children: [
                const Text('最多探测'),
                Text(userProfile.maxShipsSpotted[0].toString())
              ]),
            )),
          ],
        ),
      ),
    );
  } catch (e) {
    return Container();
  }
}

maxSpotDmgWidget(UserProfile userProfile, Map ships, BuildContext context) {
  try {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                    ships[userProfile.maxDamageScouting[1]].imgLink.toString()),
                Text(ships[userProfile.maxDamageScouting[1]].getRomanTier() +
                    ' ' +
                    ships[userProfile.maxDamageScouting[1]].name)
              ],
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 16, 0),
              child: Column(children: [
                const Text('最大侦察伤害'),
                Text(userProfile.maxDamageScouting[0].toString())
              ]),
            )),
          ],
        ),
      ),
    );
  } catch (e) {
    return Container();
  }
}

maxAgroWidget(UserProfile userProfile, Map ships, BuildContext context) {
  try {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                    ships[userProfile.maxTotalAgro[1]].imgLink.toString()),
                Text(ships[userProfile.maxTotalAgro[1]].getRomanTier() +
                    ' ' +
                    ships[userProfile.maxTotalAgro[1]].name)
              ],
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 16, 0),
              child: Column(children: [
                const Text('最大潜在'),
                Text(userProfile.maxTotalAgro[0].toString())
              ]),
            )),
          ],
        ),
      ),
    );
  } catch (e) {
    return Container();
  }
}

maxPlanWidget(UserProfile userProfile, Map ships, BuildContext context) {
  try {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                    ships[userProfile.maxPlanesKilled[1]].imgLink.toString()),
                Text(ships[userProfile.maxPlanesKilled[1]].getRomanTier() +
                    ' ' +
                    ships[userProfile.maxPlanesKilled[1]].name)
              ],
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 16, 0),
              child: Column(children: [
                const Text('最佳防空'),
                Text(userProfile.maxPlanesKilled[0].toString())
              ]),
            )),
          ],
        ),
      ),
    );
  } catch (e) {
    return Container();
  }
}

maxFragsWidget(UserProfile userProfile, Map ships, BuildContext context) {
  try {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                    ships[userProfile.maxFrags[1]].imgLink.toString()),
                Text(ships[userProfile.maxFrags[1]].getRomanTier() +
                    ' ' +
                    ships[userProfile.maxFrags[1]].name)
              ],
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 16, 0),
              child: Column(children: [
                const Text('最多击杀'),
                Text(userProfile.maxFrags[0].toString())
              ]),
            )),
          ],
        ),
      ),
    );
  } catch (e) {
    return Container();
  }
}

maxXpWidget(UserProfile userProfile, Map ships, BuildContext context) {
  try {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(ships[userProfile.maxXp[1]].imgLink.toString()),
                Text(ships[userProfile.maxXp[1]].getRomanTier() +
                    ' ' +
                    ships[userProfile.maxXp[1]].name)
              ],
            ),
            Center(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 16, 0),
              child: Column(children: [
                const Text('最多经验'),
                Text(userProfile.maxXp[0].toString())
              ]),
            )),
          ],
        ),
      ),
    );
  } catch (e) {
    return Container();
  }
}

Future<UserProfile> init(User user, var ships, var shipExp) async {
  UserProfile userProfile = UserProfile();
  await userProfile.initUser(user.getId, user.getServer);
  await userProfile.initShips(ships, shipExp);
  return userProfile;
}
