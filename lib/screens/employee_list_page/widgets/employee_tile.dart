import 'package:bloc_practice/screens/employee_list_page/add_new_employee_page.dart';
import 'package:bloc_practice/state/cubits/employee_cubit.dart';
import 'package:bloc_practice/state/models/employee_model/employee.dart';
import 'package:bloc_practice/utilities/extensions/date_ext.dart';
import 'package:bloc_practice/utilities/extensions/double_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmployeeTile extends StatelessWidget {
  const EmployeeTile(
    this.employee, {
    required this.onDelete,
    super.key,
  });

  final Employee employee;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(
          color: Colors.black.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${employee.firstName} ${employee.lastName}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: onDelete,
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        context.read<EmployeeCubit>().setSelectedEmployee(employee);
                        context.goNamed(AddNewEmployeePage.routeName);
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'Birthdate',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              '${employee.birthDate?.toFormattedDate}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Rate',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              '${employee.hourlyRate?.toFormattedCurrency}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
