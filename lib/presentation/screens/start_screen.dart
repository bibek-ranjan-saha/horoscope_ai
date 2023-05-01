import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:horoscope_ai/config/strings.dart';
import 'package:horoscope_ai/presentation/bloc/user_bloc/user_cubit.dart';
import 'package:horoscope_ai/presentation/screens/sign_selection_screen.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = "/start_screen";

  StartScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.kWelcome.tr()),
        centerTitle: true,
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSelectedState) {
            context.pushReplacementNamed(SignSelectorScreen.routeName);
          }
        },
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserSuccessState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(!state.isNew)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                        "Are you ${state.lastSelectedUser}!",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    TextField(
                      expands: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (nameController.text.trim().isNotEmpty) {
                          context
                              .read<UserCubit>()
                              .setUser(nameController.text);
                        } else {}
                      },
                      icon: const Icon(Icons.start),
                      label: Text(
                        AppStrings.kStart.tr(),
                      ),
                    ),
                    if (state.users.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (ctx) {
                                return Card(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(AppStrings.kSelectUser.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium),
                                      ),
                                      ...state.users.map(
                                        (e) => RadioListTile(
                                          value: e,
                                          title: Text(e),
                                          groupValue: state.lastSelectedUser,
                                          onChanged: (String? change) {
                                            if (change != null) {
                                              context
                                                  .read<UserCubit>()
                                                  .selectUser(change);
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.select_all_rounded),
                          label: Text(
                            AppStrings.kSelectUser.tr(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          } else {
            log(state.toString());
            return const SizedBox();
          }
        },
      ),
    );
  }
}
