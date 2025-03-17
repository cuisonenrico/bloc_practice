import 'package:bloc_practice/utilities/app_router.dart';
import 'package:flutter/material.dart';

class BlocPractice extends StatelessWidget {
  const BlocPractice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bloc Practice App',
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
