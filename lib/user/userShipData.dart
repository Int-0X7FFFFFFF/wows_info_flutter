import 'package:delayed_widget/delayed_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:wows_info_flutter/model/ship.dart';

class ShipDataPage extends StatefulWidget {
  const ShipDataPage({super.key});

  @override
  State<ShipDataPage> createState() => _ShipDataPageState();
}

class _ShipDataPageState extends State<ShipDataPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    ShipData ship = arguments['ship'];
    return Scaffold(body: shipBody(ship));
  }

  shipBody(ShipData ship) {
    String lastBattle =
        DateTime.fromMillisecondsSinceEpoch(ship.lastBattleTime * 1000)
            .toString()
            .substring(0, 10);
    return ListView(children: [
      DelayedWidget(
          delayDuration: const Duration(milliseconds: 50),
          child: Center(child: Image.network(ship.imgLink))),
      DelayedWidget(
          delayDuration: const Duration(milliseconds: 100),
          child: Center(
            child: Text(
              "${ship.getRomanTier()} ${ship.name}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )),
      DelayedWidget(
          delayDuration: const Duration(milliseconds: 250),
          child: SizedBox(
            height: 30,
            child: ColoredBox(
              color: ship.prColor,
              child: Center(
                  child: Text(
                '${ship.prString} ${ship.prNum}',
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
                          delayDuration: const Duration(milliseconds: 300),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.sailing,
                                  size: 64,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  ship.battles.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                )
                              ],
                            ),
                          )),
                      DelayedWidget(
                          delayDuration: const Duration(milliseconds: 370),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.emoji_events,
                                  size: 64,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  ship.winRate.toString(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                )
                              ],
                            ),
                          )),
                      DelayedWidget(
                          delayDuration: const Duration(milliseconds: 400),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.api,
                                  size: 64,
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
                          delayDuration: const Duration(milliseconds: 370),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.star_purple500,
                                  size: 64,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  ship.xpAvg,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                )
                              ],
                            ),
                          )),
                      DelayedWidget(
                          delayDuration: const Duration(milliseconds: 420),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.gavel,
                                  size: 64,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  ship.KD,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                )
                              ],
                            ),
                          )),
                      DelayedWidget(
                          delayDuration: const Duration(milliseconds: 450),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.network_ping,
                                  size: 64,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                Text(
                                  ship.accuRate,
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
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(
                                children: [
                                  const Text('胜场'),
                                  Text(ship.wins.toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                children: [
                                  const Text('击发炮弹'),
                                  Text(ship.shots.toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                children: [
                                  const Text('航行距离'),
                                  Text(ship.distance.toString())
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
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(
                                children: [
                                  const Text('平局'),
                                  Text((ship.battles - ship.wins - ship.losses)
                                      .toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                children: [
                                  const Text('摧毁战舰'),
                                  Text(ship.frags.toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                children: [
                                  const Text('造成伤害'),
                                  Text(ship.damageDealt.toString())
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
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(
                                children: [
                                  const Text('败场'),
                                  Text(ship.losses.toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                children: [
                                  const Text('炮弹命中'),
                                  Text(ship.hits.toString())
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Column(
                                children: [
                                  const Text('获得经验'),
                                  Text(ship.xp.toString())
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
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: Icon(
                    Icons.center_focus_weak_sharp,
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 128, 16),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "最大伤害",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        ship.maxDamageDealt.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )),
                )
              ],
            )),
      )),
      DelayedWidget(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: Icon(
                    Icons.star_rate,
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 128, 16),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "最多经验",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        ship.maxXp.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )),
                ),
              ],
            )),
      )),
      DelayedWidget(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: Icon(
                    Icons.whatshot,
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 128, 16),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "最大击杀",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        ship.maxFrags.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )),
                ),
              ],
            )),
      )),
      DelayedWidget(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: Icon(
                    Icons.cancel_schedule_send_sharp,
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 107, 16),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "最大飞机击落",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        ship.maxPlanesKilled.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )),
                ),
              ],
            )),
      )),
      DelayedWidget(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: Icon(
                    Icons.kitesurfing,
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 107, 16),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "最大潜在伤害",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        ship.maxTotalAgro.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )),
                ),
              ],
            )),
      )),
      DelayedWidget(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: Icon(
                    Icons.lightbulb_outline,
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 107, 16),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "最大侦察伤害",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        ship.maxDamageScouting.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )),
                ),
              ],
            )),
      )),
      DelayedWidget(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                  child: Icon(
                    Icons.access_time_filled,
                    color: Theme.of(context).colorScheme.primary,
                    size: 64,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 107, 16),
                  child: Center(
                      child: Column(
                    children: [
                      Text(
                        "上次战斗时间",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        lastBattle,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  )),
                ),
              ],
            )),
      )),
    ]);
  }
}
