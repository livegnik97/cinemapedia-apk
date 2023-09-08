import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/router/router_path.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index){
    if(currentIndex == index) return;
    // context.go('/home/${index}');
    switch(index){
      case 0:
        context.go(RouterPath.HOME_PAGE);
      break;
      case 1:
        context.go(RouterPath.CATEGORY_PAGE);
      break;
      case 2:
        context.go(RouterPath.FAVORITE_PAGE);
      break;
      default:
        context.go(RouterPath.HOME_PAGE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: "Inicio"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: "Categorías"
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: "Favoritos"
        ),
      ],
    );
  }
}