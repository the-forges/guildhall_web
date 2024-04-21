import 'dart:js_interop';

import 'package:go_router/go_router.dart';
import 'package:guildhall_app/app/app.dart';
import 'package:guildhall_app/auth/auth.dart';
import 'package:guildhall_app/auth/state.dart' as appstate;
import 'package:web/web.dart' as web;

import 'auth/state.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AppPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        appstate.clearLocalState();
        return Auth(callback: (profile) {
        appstate.profile = profile;
        appstate.storeLocalState();
        context.go('/');
      },);
        },
    ),
    GoRoute(
      path: '/logout',
      redirect: (context, state) {
        appstate.clearLocalState();
        web.console.log('logged out' as JSAny?);
        return '/login';
      },
    )
  ],
  redirect: (context, state) {
    appstate.loadLocalState();
    if (appstate.profile != null) {
      return '/';
    }
    return '/login';
  },
);
