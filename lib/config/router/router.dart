import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: "/home/0",
  routes: [
    GoRoute(
        name: HomeScreen.name,
        path: '/home/:page',
        builder: (context, state) {
          final page = int.parse(state.pathParameters['page'] ?? '0') % 3;
          return HomeScreen(pageIndex: page);
        },
        routes: [
          GoRoute(
              name: MovieScreen.name,
              path: 'movie/:id',
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? '';
                return MovieScreen(movieId: id);
              }),
        ]),

      GoRoute(
        path: '/',
        redirect: (_, __) => '/home/0',
      ),
  ],
);
