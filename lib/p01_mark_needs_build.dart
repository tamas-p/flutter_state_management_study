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

int counter = 0;
BuildContext? myTextContext;

//------------------------------------------------------------------------------

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        counter++;
        (myTextContext! as Element).markNeedsBuild();
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
    myTextContext = context;
    return Text(counter.toString());
  }
}
