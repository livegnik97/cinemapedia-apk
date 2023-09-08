import 'package:flutter/material.dart';

import '../../views/views.dart';
import '../../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {

  static const name = 'home-screen';

  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  late PageController pageController;

  final viewRoutes = const <Widget>[
    HomeView(),
    CategoryView(),
    FavoriteView(),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Future.delayed(const Duration(milliseconds: 0), () {
        if (pageController.hasClients) {
        pageController.animateToPage(
          widget.pageIndex,
          curve: Curves.easeInOut,
          duration: const Duration( milliseconds: 250),
        );
      }
    });

    return Scaffold(
      body: PageView(
        //para evitar que scroll horizontalmente
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: viewRoutes,
      ),
      // body: IndexedStack(
      //   index: pageIndex,
      //   children: viewRoutes,
      // ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: widget.pageIndex),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
