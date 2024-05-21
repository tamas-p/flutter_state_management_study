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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextA(),
                  MyButtonA(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextB(),
                  MyButtonB(),
                ],
              ),
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
  int a = 0;
  void _increaseA() {
    setState(() {
      a++;
    });
  }

  int b = 0;
  void _increaseB() {
    setState(() {
      b++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterInheritedModel(
      a: a,
      increaseA: _increaseA,
      b: b,
      increaseB: _increaseB,
      child: widget.child,
    );
  }
}

enum Aspects { a, b }

class CounterInheritedModel extends InheritedModel<Aspects> {
  const CounterInheritedModel({
    required this.a,
    required this.increaseA,
    required this.b,
    required this.increaseB,
    super.key,
    required super.child,
  });

  final int a;
  final void Function() increaseA;

  final int b;
  final void Function() increaseB;

  @override
  bool updateShouldNotify(covariant CounterInheritedModel oldWidget) =>
      a != oldWidget.a || b != oldWidget.b;

  @override
  bool updateShouldNotifyDependent(
    covariant CounterInheritedModel oldWidget,
    Set<Aspects> dependencies,
  ) =>
      dependencies.contains(Aspects.a) && a != oldWidget.a ||
      dependencies.contains(Aspects.b) && b != oldWidget.b;
}

//------------------------------------------------------------------------------

class MyButtonA extends StatelessWidget {
  const MyButtonA({super.key});

  @override
  Widget build(BuildContext context) {
    final model =
        context.getInheritedWidgetOfExactType<CounterInheritedModel>();
    return TextButton(
      onPressed: () {
        model!.increaseA();
      },
      child: const Text('Push A'),
    );
  }
}

class MyButtonB extends StatelessWidget {
  const MyButtonB({super.key});

  @override
  Widget build(BuildContext context) {
    final model =
        context.getInheritedWidgetOfExactType<CounterInheritedModel>();
    return TextButton(
      onPressed: () {
        model!.increaseB();
      },
      child: const Text('Push B'),
    );
  }
}

class MyTextA extends StatelessWidget {
  const MyTextA({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('Rebuild A');
    final model = InheritedModel.inheritFrom<CounterInheritedModel>(
      context,
      aspect: Aspects.a,
    );
    return Text(model!.a.toString());
  }
}

class MyTextB extends StatelessWidget {
  const MyTextB({super.key});

  @override
  Widget build(BuildContext context) {
    print('Rebuild B');
    final model = InheritedModel.inheritFrom<CounterInheritedModel>(
      context,
      aspect: Aspects.b,
    );
    return Text(model!.b.toString());
  }
}
