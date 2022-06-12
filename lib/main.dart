import 'package:flutter/material.dart';

import 'package:nfevent/constants.dart';
import 'package:nfevent/pages/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFEVENT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldColor,
        fontFamily: 'zona',
      ),
      home: const HomePage(),
    );
  }
}
