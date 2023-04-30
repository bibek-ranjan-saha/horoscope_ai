// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signs_cubit.dart';

abstract class SignsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignsInitialState extends SignsState {}

class SignsLoadingState extends SignsState {}

class SignsSuccessState extends SignsState {}

class SignsFailureState extends SignsState {}
