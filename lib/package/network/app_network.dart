import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:dotenv/dotenv.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../config/strings.dart';
import 'network_failure.dart';

class AppNetworkClient {
  static AppNetworkClient? _instance;

  static final Dio _api = Dio(BaseOptions(receiveDataWhenStatusError: true));

  static Map<String, dynamic> commonHeader = {};
  static String baseUrl = "";

  AppNetworkClient._() {
    final env = DotEnv(includePlatformEnvironment: true);
    baseUrl = env.getOrElse("base_url", () {
      throw Exception("Base url could not be loaded");
    });
    String apiKey = env.getOrElse("api_key", () {
      throw Exception("Api key could not be loaded");
    });
    String apiHost = env.getOrElse("api_host", () {
      throw Exception("Api host could not be loaded");
    });
    commonHeader = {'X-RapidAPI-Key': apiKey, 'X-RapidAPI-Host': apiHost};
    _api.interceptors.addAll([
      DioCacheManager(
        CacheConfig(
          baseUrl: baseUrl,
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

  static Future<Either<Response<dynamic>, NetworkFailure>> get(
      String path) async {
    try {
      final res = await _api.get(
        baseUrl + path,
        options: Options(headers: commonHeader),
      );

      return Left(res);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        return Right(NetworkFailure(AppStrings.kNetworkTimeOut.tr()));
      }
      if (e.type == DioErrorType.response) {
        return Right(NetworkFailure(AppStrings.kWrongWithServer.tr(),
            statusCode: e.response!.statusCode));
      }
      return Right(NetworkFailure(AppStrings.kSomethingWentWrong.tr()));
    }
  }
}
