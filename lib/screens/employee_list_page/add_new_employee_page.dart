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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 64),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DebouncingInputField(
                  onChangeText: (firstName) => stateBloc.setFirstName(firstName),
                  hintText: 'First name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DebouncingInputField(
                  onChangeText: (lastName) => stateBloc.setLastName(lastName),
                  hintText: 'Last name',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DebouncingInputField(
                  keyboardInput: TextInputType.number,
                  onChangeText: (hourlyRate) => stateBloc.setHourlyRate(double.parse(hourlyRate)),
                  hintText: 'Hourly Rate',
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
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final employee = stateBloc.state.selectedEmployee;
                  if (employee == null) return;
                  stateBloc.saveEmployee(employee);
                  if (context.mounted) context.pop();
                },
                child: Text('Add new Employee'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
