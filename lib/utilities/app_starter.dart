import 'dart:async';

import 'package:bloc_practice/bloc_practice_app.dart';
import 'package:bloc_practice/state/cubits/cubits.dart';
import 'package:bloc_practice/state/cubits/employee_cubit.dart';
import 'package:bloc_practice/state/models/employee_model/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> startApp() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // Register the Employee adapter
      Hive.registerAdapter(EmployeeImplAdapter());

      await Hive.initFlutter();

      runApp(MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeCubit>(
            create: (_) => EmployeeCubit(),
          ),
          BlocProvider<StateCubit>(
            create: (_) => StateCubit(),
          ),
        ],
        child: BlocPractice(),
      ));
    },
    (error, stack) async => {},
  );
}
