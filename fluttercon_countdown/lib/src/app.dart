import 'package:flutter/material.dart';
import 'package:fluttercon_countdown/src/screens/countdown_screen.dart';
import 'package:fluttercon_countdown/src/utils/app_constants.dart';

/// The root widget of the Fluttercon Countdown application.
///
/// This widget sets up the [MaterialApp], defining the theme and
/// the home screen.
class FlutterconCountdownApp extends StatelessWidget {
  /// Creates an instance of [FlutterconCountdownApp].
  const FlutterconCountdownApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      themeMode: ThemeMode.system, // Respect system theme settings
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const CountdownScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
