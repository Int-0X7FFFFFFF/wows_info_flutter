// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wows_info_flutter/APIs.dart';
import 'package:wows_info_flutter/common.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Future<dynamic> update() async {
    int shipListUpdateCode = Provider.of<Setting>(context).getShipListUpdate;
    int currentVersion = Provider.of<ShipList>(context).getVersion;
    int shipExpCode = Provider.of<Setting>(context).getShipExpupdate;
    var currentExp = Provider.of<ShipExp>(context).getShipExp;
    var currentTimeStamp = currentExp['time'] ?? 0;
    if (shipListUpdateCode != 3) {
      try {
        int cloudVersion = await apiVersion();
        if (cloudVersion > currentVersion) {
          Provider.of<Setting>(context, listen: false).setShipListUpdate(1);
          String shipListJson = await apiShipList();
          Provider.of<ShipList>(context, listen: false)
              .setShipList(jsonDecode(shipListJson), cloudVersion);
          Provider.of<Setting>(context, listen: false).setShipListUpdate(3);
        } else {
          Provider.of<Setting>(context, listen: false).setShipListUpdate(3);
        }
      } catch (e) {
        Provider.of<Setting>(context, listen: false).setShipListUpdate(2);
      }
    }
    if (shipExpCode != 3) {
      try {
        var cloudExp = await apiShipExp();
        var cloudTimeStamp = cloudExp['time'];
        if (DateTime.fromMillisecondsSinceEpoch(currentTimeStamp)
            .isBefore(DateTime.fromMillisecondsSinceEpoch(cloudTimeStamp))) {
          Provider.of<ShipExp>(context, listen: false).setShipExp(cloudExp);
          Provider.of<Setting>(context, listen: false).setShipExpUpdate(3);
        } else {
          Provider.of<Setting>(context, listen: false).setShipExpUpdate(3);
        }
      } catch (e) {
        Provider.of<Setting>(context, listen: false).setShipExpUpdate(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final shipListUpdateCode = Provider.of<Setting>(context).getShipListUpdate;
    final shipExpCode = Provider.of<Setting>(context).getShipExpupdate;
    var colorList = [
      Theme.of(context).colorScheme.secondary,
      Theme.of(context).colorScheme.tertiaryContainer,
      Theme.of(context).colorScheme.error,
      Theme.of(context).colorScheme.primaryContainer,
    ];
    var textColorLsit = [
      Theme.of(context).colorScheme.onSecondary,
      Theme.of(context).colorScheme.onTertiaryContainer,
      Theme.of(context).colorScheme.onError,
      Theme.of(context).colorScheme.onPrimaryContainer,
    ];
    var statText = ['未同步', '尝试同步', '错误', '已同步'];
    var stat = statText[shipListUpdateCode];
    var statExp = statText[shipExpCode];
    final currentVersion = Provider.of<ShipList>(context).getVersion;
    final currentExp = Provider.of<ShipExp>(context).getShipExp;
    var currentTimeStamp = currentExp['time'] ?? 0;
    return FutureBuilder(
      future: update(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(title: const Text("主页")),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.settings),
            onPressed: () {},
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Card(
                  color: colorList[shipListUpdateCode],
                  child: Center(
                      child: ListTile(
                    leading: const Icon(
                      Icons.directions_boat,
                      size: 56,
                    ),
                    title: Text(
                      '船只基本信息',
                      style:
                          TextStyle(color: textColorLsit[shipListUpdateCode]),
                    ),
                    subtitle: Text(
                      """$stat
当前版本: $currentVersion""",
                      style:
                          TextStyle(color: textColorLsit[shipListUpdateCode]),
                    ),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Card(
                  color: colorList[shipExpCode],
                  child: Center(
                      child: ListTile(
                    leading: const Icon(
                      Icons.checklist,
                      size: 56,
                    ),
                    title: Text(
                      '船只期望信息',
                      style: TextStyle(color: textColorLsit[shipExpCode]),
                    ),
                    subtitle: Text(
                      """$statExp
当前时间戳: $currentTimeStamp""",
                      style: TextStyle(color: textColorLsit[shipExpCode]),
                    ),
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
