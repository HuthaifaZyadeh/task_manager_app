import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_do/app/auth/presentation/bloc/auth_bloc.dart';
import 'package:simple_do/app/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:simple_do/app/tasks/presentation/pages/tasks_screen.dart';
import 'package:simple_do/app/welcome/welcome_screen.dart';
import 'package:simple_do/src/di/services_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/auth/presentation/pages/login_screen.dart';
import 'fallback_screen.dart';
import 'routes.dart';

import 'custom_navigation_observer.dart';

class AppRouter {
  final GoRouter goRouter;

  static late AppRouter _appRouter;

  static init() {
    _appRouter = AppRouter();
  }

  AppRouter() : goRouter = _getRouter;

  static GoRouter get getRouter => _appRouter.goRouter;

  static get _getRouter => GoRouter(
        initialLocation: Routes.welcome,
        observers: [BotToastNavigatorObserver(), CustomNavigationObserver()],
        errorBuilder: (context, state) => const FallbackScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: Routes.welcome,
            builder: (context, state) {
              return const WelcomeScreen();
            },
          ),
          GoRoute(
            path: Routes.login,
            builder: (context, state) {
              return BlocProvider<AuthBloc>(
                create: (_) => getIt<AuthBloc>(),
                child: const LoginScreen(),
              );
            },
          ),
          GoRoute(
            path: Routes.tasks,
            builder: (context, state) {
              return BlocProvider<TasksBloc>(
                create: (_) => getIt<TasksBloc>()..add(const GetTasksEvent()),
                child: const TasksScreen(),
              );
            },
          ),
        ],
      );
}

extension GoRouterPopUntil on GoRouter {
  void popUntil(String routePath) {
    List routeStacks = [...routerDelegate.currentConfiguration.routes];
    for (int i = routeStacks.length - 1; i >= 0; i--) {
      RouteBase route = routeStacks[i];
      if (route is GoRoute) {
        if (route.path == routePath) break;
        if (i != 0 && routeStacks[i - 1] is ShellRoute) {
          RouteMatchList matchList = routerDelegate.currentConfiguration;
          restore(matchList.remove(matchList.matches.last));
        } else {
          pop();
        }
      }
    }
  }
}
