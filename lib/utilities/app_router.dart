import 'package:bloc_practice/screens/employee_list_page/add_new_employee_page.dart';
import 'package:bloc_practice/screens/employee_list_page/employee_list_page.dart';
import 'package:bloc_practice/screens/login_page/login_page.dart';
import 'package:bloc_practice/screens/time_log_page/emloyee_time_log.dart';
import 'package:bloc_practice/screens/time_log_page/time_log_page.dart';
import 'package:bloc_practice/state/cubits/employee_cubit.dart';
import 'package:bloc_practice/state/cubits/time_log_cubit.dart';
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
            GoRoute(
              path: TimeLogPage.route,
              name: TimeLogPage.routeName,
              builder: (_, __) => TimeLogPage(),
              routes: [
                GoRoute(
                  path: EmployeeTimeLogs.route,
                  name: EmployeeTimeLogs.routeName,
                  builder: (context, __) {
                    final employeeId = context.read<EmployeeCubit>().state.selectedEmployee?.id;
                    if (employeeId == null) return EmployeeTimeLogs();
                    context.read<TimeLogCubit>().getTimeLogs(employeeId);
                    return EmployeeTimeLogs();
                  },
                  routes: const [],
                ),
              ],
            ),
          ],
        ),

        // ShellRoute(
        //   builder: (context, state, child) {
        //     context.read<EmployeeCubit>().getEmployees();
        //     return MainPage(child: child);
        //   },
        //   routes: [
        //
        //   ],
        // ),
      ],
    ),
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
