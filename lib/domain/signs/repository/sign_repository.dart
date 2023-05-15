import 'package:dartz/dartz.dart';
import 'package:horoscope_ai/package/network/network_failure.dart';

import '../model/sign_model.dart';

abstract class HoroScopeRepository {
  Future<Either<HoroScopeModel, NetworkFailure>> getHoroScope(
      {required String sign,
      required String type,
      required String period,
      required String language});
}
