import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:horoscope_ai/config/strings.dart';
import 'package:horoscope_ai/package/localization/app_localization.dart';
import 'package:horoscope_ai/presentation/bloc/user_bloc/user_cubit.dart';
import 'package:horoscope_ai/presentation/screens/sign_selection_screen.dart';
import 'package:sprintf/sprintf.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = "/start_screen";

  StartScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.kWelcome.tr()),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => AppLocalization.changeLocale(context),
            icon: const Icon(Icons.language_rounded),
          )
        ],
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
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  if (!state.isNew && state.lastSelectedUser != null)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        sprintf(
                            AppStrings.kAreYou.tr(), [state.lastSelectedUser]),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      expands: false,
                      validator: (txt) {
                        if (txt == null) {
                          return AppStrings.kNameRequiredError.tr();
                        }
                        if (txt.trim().length <= 5) {
                          return AppStrings.kNameMustBe5CharError.tr();
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: _nameController,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<UserCubit>().setUser(_nameController.text);
                      }
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
                          if (state.users.length == 1) {
                            context
                                .read<UserCubit>()
                                .selectUser(state.users.first);
                          } else {
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
                          }
                        },
                        icon: const Icon(Icons.select_all_rounded),
                        label: Text(
                          AppStrings.kSelectUser.tr(),
                        ),
                      ),
                    ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
