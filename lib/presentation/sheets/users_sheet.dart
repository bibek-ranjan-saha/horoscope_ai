import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/strings.dart';
import '../bloc/user_bloc/user_cubit.dart';

class UsersSheet extends StatelessWidget {
  const UsersSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserSuccessState) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(AppStrings.kSelectUser.tr(),
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              ...state.users.map(
                (e) => RadioListTile(
                  value: e,
                  title: Text(e),
                  groupValue: state.lastSelectedUser,
                  onChanged: (String? change) {
                    if (change != null) {
                      context.read<UserCubit>().selectUser(change);
                    }
                  },
                ),
              )
            ],
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
