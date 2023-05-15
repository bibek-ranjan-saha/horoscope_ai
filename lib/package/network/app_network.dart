import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
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
    final options = CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(),

      // All subsequent fields are optional.

      // Default.
      policy: CachePolicy.request,
      // Returns a cached response on error but for statuses 401 & 403.
      // Also allows to return a cached response on network errors (e.g. offline usage).
      // Defaults to [null].
      hitCacheOnErrorExcept: [401, 403],
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behaviour is desired.
      // Defaults to [null].
      maxStale: const Duration(days: 7),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: false,
    );

    // Added cache interceptor
    _api.interceptors.add(DioCacheInterceptor(options: options));
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

  static fetchMessage(Response<dynamic> response) {
    return response.data["message"];
  }
}
