import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: CounterInheritedNotifier(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(),
              MyButton(),
            ],
          ),
        ),
      ),
    );
  }
}

//------------------------------------------------------------------------------

class CounterInheritedNotifier extends InheritedNotifier<ValueNotifier<int>> {
  CounterInheritedNotifier({
    super.key,
    required super.child,
  }) : super(notifier: ValueNotifier<int>(0));
}

//------------------------------------------------------------------------------

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model =
        context.getInheritedWidgetOfExactType<CounterInheritedNotifier>();
    return TextButton(
      onPressed: () {
        model!.notifier!.value++;
      },
      child: const Text('Push'),
    );
  }
}

class MyText extends StatelessWidget {
  const MyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model =
        context.dependOnInheritedWidgetOfExactType<CounterInheritedNotifier>();
    return Text(model!.notifier!.value.toString());
  }
}
