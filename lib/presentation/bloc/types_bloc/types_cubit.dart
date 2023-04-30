// ignore_for_file: depend_on_referenced_packages
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';


part 'types_state.dart';

@injectable
class TypesCubit extends Cubit<TypesState> {
  TypesCubit() : super(TypesInitialState());
}