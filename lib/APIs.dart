// ignore: file_names
import 'dart:convert';

import 'package:dio/dio.dart';

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
