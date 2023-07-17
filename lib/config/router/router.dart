import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: '/home',
      builder: (context, state) => HomeScreen(),
    ),
  ],
);