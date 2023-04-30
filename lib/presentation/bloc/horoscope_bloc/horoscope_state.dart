// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'horoscope_cubit.dart';

abstract class HoroscopeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HoroscopeInitialState extends HoroscopeState {}

class HoroscopeLoadingState extends HoroscopeState {}

class HoroscopeSuccessState extends HoroscopeState {}

class HoroscopeFailureState extends HoroscopeState {}
