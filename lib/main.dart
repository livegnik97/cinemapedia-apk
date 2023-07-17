import 'dart:io';

import 'package:flutter/material.dart';

import 'config/certificates/remove_certificate.dart';
import 'config/router/router.dart';
import 'config/theme/app_theme.dart';
import 'presentation/screens/home_screen/home_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cinemapedia',
      theme: AppTheme().themeLight(),
      darkTheme: AppTheme().themeDark(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}