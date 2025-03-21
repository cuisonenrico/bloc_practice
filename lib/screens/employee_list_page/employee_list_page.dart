import 'package:bloc_practice/screens/employee_list_page/add_new_employee_page.dart';
import 'package:bloc_practice/screens/employee_list_page/widgets/employee_tile.dart';
import 'package:bloc_practice/screens/time_log_page/time_log_page.dart';
import 'package:bloc_practice/screens/widgets/debouncing_input_field.dart';
import 'package:bloc_practice/state/cubits/employee_cubit.dart';
import 'package:bloc_practice/state/cubits/time_log_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  static const routeName = 'employee-list-page';
  static const route = 'employee-list-page';

  @override
  Widget build(BuildContext context) {
    final stateBloc = context.watch<EmployeeCubit>();

    final employeeList = stateBloc.state.queriedEmployeeList.isEmpty
        ? stateBloc.state.employeeList
        : stateBloc.state.queriedEmployeeList;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 64),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DebouncingInputField(
                        onChangeText: (query) => stateBloc.setNameQuery(query),
                        hintText: 'Search Here',
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () => context.goNamed(AddNewEmployeePage.routeName),
                      child: Icon(
                        Icons.add,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// LIST
            ...employeeList.map(
              (employee) => InkWell(
                onTap: () {
                  stateBloc.setSelectedEmployee(employee);
                  final id = employee.id;
                  if (id == null) return;
                  context.read<TimeLogCubit>().onSetEmployeeId(id);
                  context.goNamed(TimeLogPage.routeName);
                },
                child: EmployeeTile(
                  employee,
                  onDelete: () {
                    final id = employee.id;
                    if (id == null) return;
                    stateBloc.deleteEmployee(id);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
