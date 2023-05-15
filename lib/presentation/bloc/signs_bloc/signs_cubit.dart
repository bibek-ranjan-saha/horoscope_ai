// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';


part 'signs_state.dart';

@injectable
class SignsCubit extends Cubit<SignsState> {
  SignsCubit() : super(SignsInitialState());

  void getSigns()
  {

  }
}