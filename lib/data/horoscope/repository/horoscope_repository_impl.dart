// ignore_for_file: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:horoscope_ai/data/horoscope/remote/horoscope_api.dart';
import 'package:horoscope_ai/domain/horoscope/repository/horoscope_repository.dart';
import 'package:horoscope_ai/package/network/network_failure.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/horoscope/model/horoscope_model.dart';

@LazySingleton(as: HoroScopeRepository)
class HoroScopeRepositoryImpl implements HoroScopeRepository {
  @override
  Future<Either<HoroScopeModel, NetworkFailure>> getHoroScope(
      {required String sign,
      required String type,
      required String period,
      required String language}) {
    return HoroScopeApi.getHoroScope(sign: sign, type: type, period: period, language: language);
  }
}
