import 'package:flutter/material.dart';

import 'magnifier/magnifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return CustomMagnifier(
      size: screenSize,
      child: Scaffold(
          body: Column(
        children: [
          Row(
            children: [
              Container(
                color: Colors.orange,
                width: screenSize.width * .5,
                height: screenSize.height * .5,
              ),
              Container(
                color: Colors.purple,
                width: screenSize.width * .5,
                height: screenSize.height * .5,
              )
            ],
          ),
          Row(
            children: [
              Container(
                color: Colors.green,
                width: screenSize.width * .5,
                height: screenSize.height * .5,
              ),
              Container(
                color: Colors.red,
                width: screenSize.width * .5,
                height: screenSize.height * .5,
              )
            ],
          ),
        ],
      )),
    );
  }
}
