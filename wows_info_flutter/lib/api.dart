import 'package:dio/dio.dart';

class WowsApi {
  static final WowsApi _instance = WowsApi._internal();
  late Dio _dio;

  factory WowsApi() {
    return _instance;
  }

  WowsApi._internal() {
    _dio = Dio();
    // base URL
    setBaseUrl("https://default-url.com");
  }

  /// A function to change base URL
  void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  Dio get dio => _dio;
}
