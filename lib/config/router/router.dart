import 'package:Cinemapedia/config/router/router_path.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: RouterPath.HOME_PAGE,
  routes: [
    GoRoute(
        name: HomeScreen.name,
        path: RouterPath.HOME_PAGE_PATH,
        builder: (context, state) {
          final page = int.parse(state.pathParameters['page'] ?? '0') % 3;
          return HomeScreen(pageIndex: page);
        },
        routes: [
          GoRoute(
              name: MovieScreen.name,
              path: RouterPath.MOVIE_PAGE_PATH,
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? '';
                return MovieScreen(movieId: id);
              }),
        ]),

      GoRoute(
        path: '/',
        redirect: (_, __) => RouterPath.HOME_PAGE,
      ),
  ],
);
