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
    return const MaterialApp(
      home: Material(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(),
            MyButton(),
          ],
        ),
      ),
    );
  }
}

//------------------------------------------------------------------------------

final streamCreator = CounterStreamCreator();

class CounterStreamCreator {
  CounterStreamCreator() {
    // _streamController.onListen = () => _streamController.sink.add(counter);
  }

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
    return TextButton(
      onPressed: () {
        streamCreator.increase();
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
    return StreamBuilder(
      stream: streamCreator.stream,
      initialData: 0,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('CCC-hasData');
          return Text(snapshot.data.toString());
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
