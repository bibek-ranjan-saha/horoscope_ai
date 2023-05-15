// ignore_for_file: depend_on_referenced_packages
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;
const _envKey = 'Prod';

@pragma('vm:entry-point')
@InjectableInit()
Future configureInjection() async {
  $initGetIt(
    getIt,
    environment: _envKey,
  );
}
