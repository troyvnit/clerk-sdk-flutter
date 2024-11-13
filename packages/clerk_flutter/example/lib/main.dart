import 'dart:async';
import 'dart:core';

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env.example');
  await setUpLogging(printer: const LogPrinter());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClerkAuth(
        publicKey: dotenv.env['public_key'] ?? '',
        publishableKey: dotenv.env['publishable_key'] ?? '',
        child: Scaffold(
          backgroundColor: ClerkColors.whiteSmoke,
          body: Padding(
            padding: horizontalPadding32,
            child: Center(
              child: ClerkAuthBuilder(
                signedInBuilder: (context, auth) => ClerkUserButton(),
                signedOutBuilder: (context, auth) => const ClerkAuthenticationWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LogPrinter extends Printer {
  const LogPrinter();

  @override
  void print(String output) {
    Zone.root.print(output);
  }
}
