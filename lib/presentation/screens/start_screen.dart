import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horoscope_ai/config/strings.dart';
import 'package:horoscope_ai/presentation/screens/sign_selection_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                expands: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  context.pushReplacementNamed(SignSelectorScreen.routeName);
                },
                icon: const Icon(Icons.start),
                label: Text(
                  AppStrings.kStart.tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
