// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'periods_cubit.dart';

abstract class PeriodsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PeriodsInitialState extends PeriodsState {}

class PeriodsLoadingState extends PeriodsState {}

class PeriodsSuccessState extends PeriodsState {}

class PeriodsFailureState extends PeriodsState {}
