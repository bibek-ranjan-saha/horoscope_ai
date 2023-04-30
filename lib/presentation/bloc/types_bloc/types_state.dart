// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'types_cubit.dart';

abstract class TypesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TypesInitialState extends TypesState {}

class TypesLoadingState extends TypesState {}

class TypesSuccessState extends TypesState {}

class TypesFailureState extends TypesState {}
