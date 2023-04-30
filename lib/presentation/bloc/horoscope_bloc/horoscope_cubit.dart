// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';


part 'horoscope_state.dart';

@injectable
class HoroscopeCubit extends Cubit<HoroscopeState> {
  HoroscopeCubit() : super(HoroscopeInitialState());
}