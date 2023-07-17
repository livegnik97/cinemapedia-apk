import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screnn';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinemapedia'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}