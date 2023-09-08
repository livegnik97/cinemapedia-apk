import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {

  static const String name = "category-view";

  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories view"),
      ),
      body: Placeholder(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}