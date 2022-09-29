// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wows_info_flutter/APIs.dart';
import 'package:wows_info_flutter/common.dart';
import 'package:wows_info_flutter/model/user.dart';

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
            child: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
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

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<User> searchTerms = [];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  searchUser(String query, String server) async {
    var res = await apiUserNameSearch(query, server);
    List<User> matchQuery = [];
    if (res['status'] == 'ok') {
      for (var userJson in res['data']) {
        User user = User();
        user.setUser(userJson['account_id'], userJson['nickname'], server);
        matchQuery.add(user);
      }
    }
    return matchQuery;
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    var server = Provider.of<Setting>(context).getApiServer;
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<User>? matchQuery = (snapshot.data ?? []) as List<User>?;
          return ListView.builder(
            itemCount: matchQuery?.length,
            itemBuilder: (context, index) {
              var result = matchQuery![index];
              return GestureDetector(
                child: Card(
                  child: ListTile(
                    title: Text(result.getName),
                    subtitle: Text(result.getId.toString()),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/userdata',
                      arguments: {'user': result});
                },
              );
            },
          );
        } else {
          List<User> matchQuery = [];
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return GestureDetector(
                child: Card(
                  child: ListTile(
                    title: Text(result.getName),
                    subtitle: Text(result.getId.toString()),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/userdata',
                      arguments: {'user': result});
                },
              );
            },
          );
        }
      },
      future: searchUser(query, server),
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    var server = Provider.of<Setting>(context).getApiServer;
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<User>? matchQuery = (snapshot.data ?? []) as List<User>?;
          return ListView.builder(
            itemCount: matchQuery?.length,
            itemBuilder: (context, index) {
              var result = matchQuery![index];
              return GestureDetector(
                child: Card(
                  child: ListTile(
                    title: Text(result.getName),
                    subtitle: Text(result.getId.toString()),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/userdata',
                      arguments: {'user': result});
                },
              );
            },
          );
        } else {
          List<User> matchQuery = [];
          return ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return GestureDetector(
                child: Card(
                  child: ListTile(
                    title: Text(result.getName),
                    subtitle: Text(result.getId.toString()),
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/userdata',
                      arguments: {'user': result});
                },
              );
            },
          );
        }
      },
      future: searchUser(query, server),
    );
  }
}
