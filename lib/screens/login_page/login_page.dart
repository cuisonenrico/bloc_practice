import 'package:bloc_practice/screens/employee_list_page/employee_list_page.dart';
import 'package:bloc_practice/screens/widgets/debouncing_input_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = 'login-page';
  static const route = '/login-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email: cabic60931@onlcool.com
              // PW: E4ts&4H-
              // API: https://www.yahshuapayroll.com/api/api-auth/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DebouncingInputField(
                  // onChangeText: (user) => loginFormBloc.onSetUser(user),
                  hintText: 'User', onChangeText: (String value) {},
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DebouncingInputField(
                  // onChangeText: (password) => loginFormBloc.onSetPassword(password),
                  hintText: 'Password',
                  obscureText: true, onChangeText: (String value) {},
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.goNamed(EmployeeListPage.routeName),
                child: Text('Login'),
              ),
              // Text(
              //   '${loginFormBloc.state.user}\n${loginFormBloc.state.password}',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
