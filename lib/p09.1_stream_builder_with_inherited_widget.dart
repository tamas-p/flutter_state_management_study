import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('AAA');
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
  CounterInheritedWidget({required super.child, super.key});

  final counterStreamCreator = CounterStreamCreator();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class CounterStreamCreator {
  final _streamController = StreamController<int>();
  Stream<int> get stream => _streamController.stream;

  int counter = 0;
  void increase() {
    _streamController.sink.add(++counter);
  }
}

//------------------------------------------------------------------------------

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final counterStreamCreator = context
        .getInheritedWidgetOfExactType<CounterInheritedWidget>()!
        .counterStreamCreator;
    return TextButton(
      onPressed: () {
        counterStreamCreator.increase();
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
    final counterStreamCreator = context
        .getInheritedWidgetOfExactType<CounterInheritedWidget>()!
        .counterStreamCreator;
    return StreamBuilder(
      stream: counterStreamCreator.stream,
      initialData: 0,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('CCC-hasData');
          return Text(
            snapshot.data.toString(),
          );
        } else if (snapshot.hasError) {
          print('CCC-hasError');
          return const Text('Error.');
        } else {
          print('CCC-waiting');
          return const Text('Waiting...');
        }
      },
    );
  }
}
