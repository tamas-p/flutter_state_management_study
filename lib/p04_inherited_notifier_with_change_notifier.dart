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

class CounterInheritedNotifier extends InheritedNotifier<CounterModel> {
  CounterInheritedNotifier({
    super.key,
    required super.child,
  }) : super(notifier: CounterModel());
}

class CounterModel with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increase() {
    _counter++;
    notifyListeners();
  }
}

//------------------------------------------------------------------------------

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model =
        context.getInheritedWidgetOfExactType<CounterInheritedNotifier>();
    return TextButton(
      onPressed: () {
        model!.notifier!.increase();
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
    return Text(model!.notifier!.counter.toString());
  }
}
