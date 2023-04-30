// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';


part 'periods_state.dart';

@injectable
class PeriodsCubit extends Cubit<PeriodsState> {
  PeriodsCubit() : super(PeriodsInitialState());
}