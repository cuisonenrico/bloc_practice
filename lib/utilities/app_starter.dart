import 'dart:async';

import 'package:bloc_practice/bloc_practice_app.dart';
import 'package:bloc_practice/state/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> startApp() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(
        BlocProvider(
          create: (_) => StateCubit(),
          child: BlocPractice(),
        ),
      );
    },
    (error, stack) async => {},
  );
}
