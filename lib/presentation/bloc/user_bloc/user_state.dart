// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final bool isNew;
  final List<String> users;
  final String? lastSelectedUser;

  UserSuccessState(
      {required this.isNew, required this.users, this.lastSelectedUser});

  UserSuccessState copyWith(
      {bool? isNew, List<String>? users, String? lastSelectedUser}) {
    return UserSuccessState(
        isNew: isNew ?? this.isNew,
        users: users ?? this.users,
        lastSelectedUser: lastSelectedUser ?? this.lastSelectedUser);
  }
}

class UserSelectedState extends UserState {}

class UserFailureState extends UserState {}
