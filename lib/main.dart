import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/certificates/remove_certificate.dart';
import 'config/router/router.dart';
import 'config/theme/app_theme.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cinemapedia',
      theme: AppTheme(selectedColor: 3).themeDark(),
      darkTheme: AppTheme(selectedColor: 3).themeDark(),
      themeMode: ThemeMode.dark,
      routerConfig: appRouter,
    );
  }
}