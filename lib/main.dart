import 'package:counter_app/screens/loading.dart';
import 'package:counter_app/screens/result.dart';
import 'package:counter_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Re:Invent 2021 Builders\' Fair',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/loading',
      routes: {
        '/': (context) =>
            const MyHomePage(title: 'Re:Invent 2021 Finding Lego'),
        '/result': (context) => ResultScreen(
              userCount: MyHomePageState.userCount,
            ),
        '/loading': (context) => LoadingView(),
        // '/transition': (context) =>
        //     TransitionView(processComplete: MyHomePageState.processComplete),
      },
    );
  }
}
