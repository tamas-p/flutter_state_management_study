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

final counter = ValueNotifier<int>(0);

//------------------------------------------------------------------------------

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        counter.value++;
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
    print('BBB');
    return ValueListenableBuilder(
      valueListenable: counter,
      builder: (context, value, child) {
        print('CCC');
        return Text(value.toString());
      },
    );
  }
}
