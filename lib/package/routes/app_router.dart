import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horoscope_ai/presentation/screens/horoscope_screen.dart';
import 'package:horoscope_ai/presentation/screens/period_selector_screen.dart';
import 'package:horoscope_ai/presentation/screens/sign_selection_screen.dart';
import 'package:horoscope_ai/presentation/screens/start_screen.dart';
import 'package:horoscope_ai/presentation/screens/type_selector_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      name: "/",
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const StartScreen();
      },
    ),
    GoRoute(
      name: HoroScopeScreen.routeName,
      path: HoroScopeScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const HoroScopeScreen();
      },
    ),
    GoRoute(
      name: PeriodSelectorScreen.routeName,
      path: PeriodSelectorScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const PeriodSelectorScreen();
      },
    ),
    GoRoute(
      name: SignSelectorScreen.routeName,
      path: SignSelectorScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const SignSelectorScreen();
      },
    ),
    GoRoute(
      name: TypeSelectorScreen.routeName,
      path: TypeSelectorScreen.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const TypeSelectorScreen();
      },
    ),
  ]);
}
