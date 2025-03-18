import 'package:bloc_practice/screens/widgets/debouncing_input_field.dart';
import 'package:bloc_practice/state/cubits/employee_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddNewEmployeePage extends StatelessWidget {
  const AddNewEmployeePage({super.key});

  static const routeName = 'add-employee-page';
  static const route = 'add-employee-page';

  @override
  Widget build(BuildContext context) {
    final stateBloc = context.read<EmployeeCubit>();

    final dateNow = DateTime.now();
    final datePickerInitialDate = DateTime(dateNow.year - 18, dateNow.month, dateNow.day);

    final selectedEmployee = stateBloc.state.selectedEmployee;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            stateBloc.disposeSelectedEmployee();
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add/Edit Employee',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DebouncingInputField(
                  onChangeText: (firstName) => stateBloc.setFirstName(firstName),
                  hintText: 'First name',
                  initialValue: selectedEmployee?.firstName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DebouncingInputField(
                  onChangeText: (lastName) => stateBloc.setLastName(lastName),
                  hintText: 'Last name',
                  initialValue: selectedEmployee?.lastName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DebouncingInputField(
                  keyboardInput: TextInputType.number,
                  onChangeText: (hourlyRate) => stateBloc.setHourlyRate(double.parse(hourlyRate)),
                  hintText: 'Hourly Rate',
                  initialValue: selectedEmployee?.hourlyRate?.toString(),
                ),
              ),
              Text(
                'Birthdate:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 150,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: CupertinoDatePicker(
                  onDateTimeChanged: (birthDate) => stateBloc.setBirthDate(birthDate),
                  initialDateTime: selectedEmployee?.birthDate ?? datePickerInitialDate,
                  maximumDate: datePickerInitialDate,
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
              InkWell(
                onTap: () {
                  final employee = stateBloc.state.selectedEmployee;
                  if (employee == null) return;
                  stateBloc.saveEmployee(employee);
                  stateBloc.disposeSelectedEmployee();
                  if (context.mounted) context.pop();
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Add/Edit Employee',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
