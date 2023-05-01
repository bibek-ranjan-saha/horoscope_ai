import 'dart:developer';
import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horoscope_ai/package/routes/app_router.dart';
import 'package:horoscope_ai/package/storage/app_sp.dart';
import 'package:horoscope_ai/presentation/bloc/horoscope_bloc/horoscope_cubit.dart';
import 'package:horoscope_ai/presentation/bloc/periods_bloc/periods_cubit.dart';
import 'package:horoscope_ai/presentation/bloc/signs_bloc/signs_cubit.dart';
import 'package:horoscope_ai/presentation/bloc/types_bloc/types_cubit.dart';
import 'package:horoscope_ai/presentation/bloc/user_bloc/user_cubit.dart';

import 'package/localization/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DotEnv(includePlatformEnvironment: true).load();
  AppSharedPref.initialize();
  if (kDebugMode) {
    handleErrors();
  }
  Paint.enableDithering = true;
  runApp(
    EasyLocalization(
      supportedLocales: const [AppLocalization.english, AppLocalization.hindi],
      path: 'assets/translations',
      fallbackLocale: AppLocalization.english,
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

void handleErrors() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    log("Flutter error Report -> ${details.context}");
    log("Flutter error Exception -> ${details.exception}");
    log("Flutter error silent ? -> ${details.silent}");
    log("Flutter error Library -> ${details.library}");
    log("Flutter error -> ${details.informationCollector} ${details.stackFilter}");
    debugPrintStack(stackTrace: details.stack);
    if (kReleaseMode) {
      exit(1);
    }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrintStack(stackTrace: stack);
    log("Platform Error -> $error");
    if (kReleaseMode) {
      exit(1);
    }
    return true;
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HoroscopeCubit>(
          create: (BuildContext context) => HoroscopeCubit(),
        ),
        BlocProvider<PeriodsCubit>(
          create: (BuildContext context) => PeriodsCubit(),
        ),
        BlocProvider<SignsCubit>(
          create: (BuildContext context) => SignsCubit(),
        ),
        BlocProvider<TypesCubit>(
          create: (BuildContext context) => TypesCubit(),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Horoscope AI',
        theme: ThemeData(useMaterial3: true, primaryColor: Colors.orange),
        darkTheme: ThemeData.dark(useMaterial3: true),
        routerConfig: AppRouter.router,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: AppLocalization.english,
      ),
    );
  }
}
