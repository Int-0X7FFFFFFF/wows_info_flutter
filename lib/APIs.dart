// ignore: file_names
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

apiVersion() async {
  var api =
      'https://raw.githubusercontent.com/Int-0X7FFFFFFF/wows_info_flutter/master/lib/json/josn_version.json';
  var dio = Dio();
  Response response;
  response = await dio.get(api);
  var res = json.decode(response.data.toString());
  return res['wows_ship_list'];
}

apiShipList() async {
  var api =
      'https://raw.githubusercontent.com/Int-0X7FFFFFFF/wows_info_flutter/master/lib/json/wows_ship_list.json';
  var dio = Dio();
  Response response;
  response = await dio.get(api);
  return response.data.toString();
}

apiShipExp() async {
  var api =
      'https://raw.githubusercontent.com/Int-0X7FFFFFFF/wows_info_flutter/master/lib/json/wows_exp.json';
  var dio = Dio();
  Response response;
  response = await dio.get(api);
  var res = json.decode(response.data.toString());
  return res;
}

apiPersonData(int accountId, String server) async {
  var applicationId = json.decode(await rootBundle
      .loadString('lib/json/wows_applications_key.json'))['key'];
  var api = 'https://api.worldofwarships.$server/wows/account/info/';
  var dio = Dio();
  var response = await dio.get(api, queryParameters: {
    'application_id': applicationId,
    'account_id': accountId.toString(),
  });
  var res = response.data;
  return res;
}

apiUserNameSearch(String userName, String server) async {
  var applicationId = json.decode(await rootBundle
      .loadString('lib/json/wows_applications_key.json'))['key'];
  var api = 'https://api.worldoftanks.$server/wgn/account/list/';
  var dio = Dio();
  var response = await dio.get(api, queryParameters: {
    'application_id': applicationId,
    'game': 'wows',
    'search': userName,
  });
  return response.data;
}

apiUserShipList(String accountId, String server) async {
  var applicationId = json.decode(await rootBundle
      .loadString('lib/json/wows_applications_key.json'))['key'];
  var api = 'https://api.worldofwarships.$server/wows/ships/stats/';
  var dio = Dio();
  var response = await dio.get(api, queryParameters: {
    'application_id': applicationId,
    'account_id': accountId,
  });
  return response.data;
}

apiUserClanData(String accountId, String server) async {
  var applicationId = json.decode(await rootBundle
      .loadString('lib/json/wows_applications_key.json'))['key'];
  var api = 'https://api.worldofwarships.$server/wows/clans/accountinfo/';
  var dio = Dio();
  var response = await dio.get(api, queryParameters: {
    'application_id': applicationId,
    'account_id': accountId,
  });
  return response.data;
}

apiClanData(String clanId, String server) async {
  var applicationId = json.decode(await rootBundle
      .loadString('lib/json/wows_applications_key.json'))['key'];
  var api = 'https://api.worldofwarships.$server/wows/clans/info/';
  var dio = Dio();
  var response = await dio.get(api, queryParameters: {
    'application_id': applicationId,
    'clan_id': clanId,
  });
  return response.data;
}
