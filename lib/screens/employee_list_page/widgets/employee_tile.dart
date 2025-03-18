import 'package:bloc_practice/state/models/employee_model/employee.dart';
import 'package:flutter/material.dart';

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
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${employee.firstName} ${employee.lastName}'),
                ElevatedButton(
                  onPressed: () => onDelete.call(),
                  child: Text('Delete'),
                ),
              ],
            ),
            Text('Birthdate: ${employee.birthDate}'),
            Text('Rate: PHP${employee.hourlyRate}'),
          ],
        ),
      ),
    );
  }
}
