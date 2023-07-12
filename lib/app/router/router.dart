import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qwerty_app/app/app.dart';
import 'package:qwerty_app/home/home.dart';
import 'package:qwerty_app/login/login.dart';

class AppRouter {
  AppRouter(this.appBloc);

  final AppBloc appBloc;

  GoRouter get router => GoRouter(
        refreshListenable: GoRouterRefreshStream(appBloc.stream),
        redirect: (context, state) {
          final appBloc = context.read<AppBloc>();
          final appStatus = appBloc.state.status;

          if (appStatus.isUnAuthenticated && state.location == '/') {
            return '/login';
          } else if (appStatus.isAuthenticated && state.location == '/login') {
            return '/';
          }
          return null;
        },
        debugLogDiagnostics: true,
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const HomePage(),
          ),
          GoRoute(
            path: '/login',
            builder: (_, __) => const LoginPage(),
          )
        ],
      );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<AppState> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().distinct().listen((state) {
      print('GoRouterRefreshStream: $state');
      notifyListeners();
    });
  }

  late final StreamSubscription<AppState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
