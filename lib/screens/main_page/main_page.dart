import 'package:bloc_practice/screens/widgets/debouncing_input_field.dart';
import 'package:bloc_practice/state/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  static const String routeName = 'my-page';
  static const String route = '/my-page';

  @override
  Widget build(BuildContext context) {
    final stateBloc = context.watch<StateCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bloc Practice App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${stateBloc.state.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Divider(),
            const Text(
              'You have entered this word:',
            ),
            Text(
              stateBloc.state.text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DebouncingInputField(
                hintText: 'Change Text here!',
                onChangeText: (text) {
                  if (text.isEmpty) {
                    stateBloc.setText('None');
                  } else {
                    stateBloc.setText(text);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => stateBloc.increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
