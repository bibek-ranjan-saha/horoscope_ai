// ignore_for_file: depend_on_referenced_packages
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horoscope_ai/package/storage/app_sp.dart';
import 'package:horoscope_ai/package/storage/storage_keys.dart';
import 'package:injectable/injectable.dart';

part 'user_state.dart';

@injectable
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());

  void getUsers() async {
    emit(UserLoadingState());
    List<String> usersName =
        await AppSharedPref.getStrListValue(StorageKeys.kUsers) ?? [];
    String? selectedUser =
        await AppSharedPref.getStringValue(StorageKeys.kSelectedUser);
    log("getUsers $usersName");
    emit(UserSuccessState(
        isNew: usersName.isEmpty,
        users: usersName,
        lastSelectedUser: selectedUser));
  }

  void setUser(String user) async {
    log("set User $user");
    await AppSharedPref.setValue(StorageKeys.kUsers, [user])
        .whenComplete(() => emit(UserSelectedState()));
  }

  void selectUser(String user) async {
    await AppSharedPref.setValue(StorageKeys.kSelectedUser, user)
        .whenComplete(() => emit(UserSelectedState()));
  }
}
