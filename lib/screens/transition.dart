import 'package:counter_app/screens/loading.dart';
import 'package:counter_app/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:counter_app/screens/home.dart';

class TransitionView extends StatefulWidget {
  final bool processComplete;
  const TransitionView({Key? key, required this.processComplete})
      : super(key: key);
  @override
  State<TransitionView> createState() => _TransitionView();
}

class _TransitionView extends State<TransitionView> {
  bool processComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: processComplete
            ? ResultScreen(userCount: MyHomePageState.userCount)
            : LoadingView());
  }
}
