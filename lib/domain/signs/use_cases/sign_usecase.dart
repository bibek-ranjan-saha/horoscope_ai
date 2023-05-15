// ignore_for_file: depend_on_referenced_packages
import 'package:horoscope_ai/domain/horoscope/repository/horoscope_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
@LazySingleton(as: HoroScopeUseCase)
class HoroScopeUseCase {
  final HoroScopeRepository repository;

  HoroScopeUseCase(this.repository);

}
