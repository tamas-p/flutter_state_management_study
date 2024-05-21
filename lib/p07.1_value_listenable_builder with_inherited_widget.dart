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
        child: CounterInheritedWidget(
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

class CounterInheritedWidget extends InheritedWidget {
  CounterInheritedWidget({super.key, required super.child});

  final counter = ValueNotifier<int>(0);

  @override
  bool updateShouldNotify(CounterInheritedWidget oldWidget) => false;
}
//------------------------------------------------------------------------------

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model =
        context.getInheritedWidgetOfExactType<CounterInheritedWidget>();
    return TextButton(
      onPressed: () {
        model!.counter.value++;
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
        context.getInheritedWidgetOfExactType<CounterInheritedWidget>();
    print('BBB');
    return ValueListenableBuilder(
      valueListenable: model!.counter,
      builder: (context, value, child) {
        print('CCC');
        return Text(value.toString());
      },
    );
  }
}
