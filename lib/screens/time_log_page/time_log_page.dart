import 'package:bloc_practice/screens/time_log_page/emloyee_time_log.dart';
import 'package:bloc_practice/screens/widgets/default_container.dart';
import 'package:bloc_practice/state/cubits/employee_cubit.dart';
import 'package:bloc_practice/state/cubits/time_log_cubit.dart';
import 'package:bloc_practice/utilities/extensions/date_ext.dart';
import 'package:bloc_practice/utilities/extensions/double_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TimeLogPage extends StatelessWidget {
  const TimeLogPage({super.key});

  static const routeName = 'time-log-page';
  static const route = 'time-log-page';

  @override
  Widget build(BuildContext context) {
    final employeeBloc = context.read<EmployeeCubit>();
    final timeLogBloc = context.read<TimeLogCubit>();

    final selectedEmployee = employeeBloc.state.selectedEmployee;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.read<EmployeeCubit>().disposeSelectedEmployee();
            context.pop();
          },
          child: Icon(
            Icons.chevron_left,
            color: Colors.blueAccent,
            size: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DefaultContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${selectedEmployee?.firstName} ${selectedEmployee?.lastName}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${selectedEmployee?.birthDate?.toFormattedDate}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${selectedEmployee?.hourlyRate?.toFormattedCurrency}/hour',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 32,
                      )
                    ],
                  )
                ],
              ),
            ),
            DefaultContainer(
              child: Row(
                children: [
                  InkWell(
                    onTap: () => context.goNamed(EmployeeTimeLogs.routeName),
                    child: Text(
                      'See more Time Logs',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
            DefaultContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date Logged',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (date) => timeLogBloc.onChangeDate(date),
                    ),
                  )
                ],
              ),
            ),
            DefaultContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time in
                  Text(
                    'Time In',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 100,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (timeIn) => timeLogBloc.onChangeTimeIn(timeIn),
                    ),
                  ),
                  // Time out
                ],
              ),
            ),
            DefaultContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time Out',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 100,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (timeOut) => timeLogBloc.onChangeTimeOut(timeOut),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              // Implement logging of time sheet
              onTap: () {
                final selectedTimeLog = timeLogBloc.state.selectedTimeLog;
                final employeeId = employeeBloc.state.selectedEmployee?.id;
                if (selectedTimeLog == null || employeeId == null) return;
                timeLogBloc.saveTimeLog(selectedTimeLog, employeeId);
              },
              child: DefaultContainer(
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    'Log',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
