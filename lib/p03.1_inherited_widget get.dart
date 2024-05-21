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
        child: CounterWidget(
          child: Row(
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

class CounterWidget extends StatefulWidget {
  const CounterWidget({required this.child, super.key});

  final Widget child;

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
    print('_CounterWidgetState built.');
    return CounterModel(
      counter: counter,
      increase: _increase,
      child: widget.child,
    );
  }
}

class CounterModel extends InheritedWidget {
  const CounterModel({
    required this.counter,
    required this.increase,
    required super.child,
    super.key,
  });

  final int counter;
  final void Function() increase;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      counter != (oldWidget as CounterModel).counter;
}

//------------------------------------------------------------------------------

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.getInheritedWidgetOfExactType<CounterModel>();
    return TextButton(
      onPressed: () {
        model!.increase.call();
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
    print('MyText built.');
    final model = context.dependOnInheritedWidgetOfExactType<CounterModel>();
    return Text(model!.counter.toString());
  }
}
