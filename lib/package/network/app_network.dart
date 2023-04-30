import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:horoscope_ai/config/config.dart';

class AppNetworkClient {
  static AppNetworkClient? _instance;

  Dio api = Dio();

  AppNetworkClient._() {
    api.interceptors.addAll([
      DioCacheManager(
        CacheConfig(
          baseUrl: Config.baseUrl,
          defaultMaxAge: const Duration(days: 7),
          defaultMaxStale: const Duration(days: 10),
        ),
      ).interceptor,
    ]);
  }

  static AppNetworkClient get instance {
    _instance ??= AppNetworkClient._();
    return _instance!;
  }
}
