import 'package:bloc_practice/screens/widgets/default_container.dart';
import 'package:bloc_practice/state/cubits/employee_cubit.dart';
import 'package:bloc_practice/state/cubits/time_log_cubit.dart';
import 'package:bloc_practice/utilities/extensions/date_ext.dart';
import 'package:bloc_practice/utilities/extensions/double_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmployeeTimeLogs extends StatelessWidget {
  const EmployeeTimeLogs({super.key});

  static const routeName = 'employee-time-log-page';
  static const route = 'employee-time-log-page';

  @override
  Widget build(BuildContext context) {
    final timeLogBloc = context.watch<TimeLogCubit>();
    final employeeBloc = context.read<EmployeeCubit>();

    final list = timeLogBloc.state.timeLogList;
    final totalGeneratedHours = list.fold(Duration.zero, (sum, obj) => sum + obj.timeOut!.difference(obj.timeIn!));
    final hourlyRate = employeeBloc.state.selectedEmployee?.hourlyRate;
    final totalEarnedIncome = (totalGeneratedHours.inMinutes / 60) * (hourlyRate ?? 0.0);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.chevron_left,
            color: Colors.blueAccent,
            size: 40,
          ),
        ),
      ),
      body: Column(
        children: [
          DefaultContainer(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Table(
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                TableRow(children: [
                  TableCell(child: Text('Date')),
                  TableCell(child: Text('Time in')),
                  TableCell(child: Text('Time out')),
                  TableCell(child: Text('Hours')),
                ]),
                ...list.map(
                  (timeLog) => TableRow(children: [
                    TableCell(child: Text('${timeLog.date?.toFormattedDate}')),
                    TableCell(child: Text('${timeLog.timeIn?.toFormattedTime}')),
                    TableCell(child: Text('${timeLog.timeOut?.toFormattedTime}')),
                    TableCell(child: Text('${timeLog.timeOut?.difference(timeLog.timeIn!).formatDuration} Hrs')),
                  ]),
                ),
              ],
            ),
          ),
          DefaultContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Generated Hours',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${totalGeneratedHours.formatDuration} Hours',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hourly Rate',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      (hourlyRate ?? 0.0).toFormattedCurrency,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Earned (Lifetime)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      totalEarnedIncome.toFormattedCurrency,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
