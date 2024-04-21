import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../auth/state.dart' as appstate;

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guildhall'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_rounded),
            onPressed: () {},
            style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Theme.of(context).canvasColor)),
          ),
          IconButton(
            onPressed: () {
              appstate.clearLocalState();
              context.go('/');
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).canvasColor,
      ),
    );
  }
}
