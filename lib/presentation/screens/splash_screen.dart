import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:horoscope_ai/presentation/bloc/user_bloc/user_cubit.dart';
import 'package:horoscope_ai/presentation/screens/start_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<UserCubit>().getUsers();
      await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
        context.pushReplacement(StartScreen.routeName);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Icons.home_rounded, size: 60),
      ),
    );
  }
}
