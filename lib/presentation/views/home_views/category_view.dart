import 'package:flutter/material.dart';

class CategoryView extends StatelessWidget {

  static const String name = "category-view";

  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories view"),
      ),
      body: Placeholder(),
    );
  }
}