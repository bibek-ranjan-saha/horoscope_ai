import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:horoscope_ai/config/endpoints.dart';
import 'package:horoscope_ai/data/horoscope/dto/get_horoscope_dto.dart';

import '../../../config/strings.dart';
import '../../../domain/horoscope/model/horoscope_model.dart';
import '../../../package/network/app_network.dart';
import '../../../package/network/network_failure.dart';

class HoroScopeApi {
  static Future<Either<HoroScopeModel, NetworkFailure>> getHoroScope(
      {required String sign,
      required String type,
      required String period,
      required String language}) async {
    try {
      final result = await AppNetworkClient.get(EndPoints.getHoroscope);
      return result.fold((response) {
        if (response.statusCode == 200) {
          final dto = GetHoroScopeDto.fromJson(response.data);
            return Left(GetHoroScopeDto.toModel(dto));
        } else {
          return Right(NetworkFailure(AppNetworkClient.fetchMessage(response)));
        }
      }, (err) async {
        return Right(NetworkFailure(err.message));
      });
    } catch (e) {
      return Right(NetworkFailure(AppStrings.kSomethingWentWrong.tr()));
    }
  }
}
