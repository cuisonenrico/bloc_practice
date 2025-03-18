import 'package:bloc_practice/screens/employee_list_page/add_new_employee_page.dart';
import 'package:bloc_practice/screens/employee_list_page/employee_list_page.dart';
import 'package:bloc_practice/screens/login_page/login_page.dart';
import 'package:bloc_practice/state/cubits/employee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');

final router = GoRouter(
  observers: [routeObservers],
  initialLocation: LoginPage.route,
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: LoginPage.route,
      name: LoginPage.routeName,
      builder: (_, __) => LoginPage(),
      routes: [
        GoRoute(
          path: EmployeeListPage.route,
          name: EmployeeListPage.routeName,
          builder: (context, __) {
            context.read<EmployeeCubit>().getEmployees();
            return EmployeeListPage();
          },
          routes: [
            GoRoute(
              path: AddNewEmployeePage.route,
              name: AddNewEmployeePage.routeName,
              builder: (_, __) => AddNewEmployeePage(),
              routes: const [],
            ),
          ],
        ),
      ],
    ),
    // GoRoute(
    //   path: MainPage.route,
    //   name: MainPage.routeName,
    //   builder: (_, __) => MainPage(),
    //   redirect: (context, routerState) {
    //     final state = context.read<StateCubit>().state;
    //     final isLoggedIn = state.isLoggedIn;
    //
    //     return isLoggedIn ? MainPage.routeName : LoginPage.route;
    //   },
    //   routes: [
    //
    //   ],
    // ),
  ],
);

// Register the RouteObserver as a navigation observer.
final RouteObserver<ModalRoute<void>> routeObservers = RouteObserver<ModalRoute<void>>();

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child),
    );
