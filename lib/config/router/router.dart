import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
        name: HomeScreen.name,
        path: '/',
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
              name: MovieScreen.name,
              path: 'movie/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? '';
                return MovieScreen(movieId: id);
              }),
        ]),
  ],
);
