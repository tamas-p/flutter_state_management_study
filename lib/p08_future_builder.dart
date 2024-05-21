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

final future = Future<int>.delayed(
  const Duration(seconds: 5),
  () => 100,
);

//------------------------------------------------------------------------------

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // counter++;
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
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text(snapshot.data.toString());
        } else {
          return const Text('waiting...');
        }
      },
    );
  }
}
