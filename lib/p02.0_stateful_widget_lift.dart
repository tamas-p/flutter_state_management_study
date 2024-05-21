import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Material(
        child: CounterWidget(),
      ),
    );
  }
}

//------------------------------------------------------------------------------

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;

  void _increase() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('_CounterWidgetState');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(counter: counter),
        MyButton(increase: _increase),
      ],
    );
  }
}

//------------------------------------------------------------------------------

class MyButton extends StatelessWidget {
  const MyButton({
    required void Function() increase,
    super.key,
  }) : _increase = increase;

  final void Function() _increase;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _increase();
      },
      child: const Text('Push'),
    );
  }
}

class MyText extends StatelessWidget {
  const MyText({
    required this.counter,
    super.key,
  });

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Text(counter.toString());
  }
}
