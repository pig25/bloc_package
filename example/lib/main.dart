import 'package:flutter/material.dart';

import 'combobox/combobox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Package Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  Widget createBtn(BuildContext context, String text, Widget child) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => child,
            ),
          );
        },
        child: Text(text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            createBtn(context, 'Combobox', ComBoBoxView()),
          ],
        ),
      ),
    );
  }
}
