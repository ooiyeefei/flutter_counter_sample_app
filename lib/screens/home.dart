import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  void resetCount() {
    setState(() => counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event.isKeyPressed(LogicalKeyboardKey.enter) ||
              event.isKeyPressed(LogicalKeyboardKey.numpadEnter)) {
            _incrementCounter();
          }

          if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
            _decrementCounter();
          }
        },
        autofocus: true,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/lego_background.jpeg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Number of defects:',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Text(
                        '$counter',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(20)),
                          ),
                          label: const Text(
                            'Revert',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: _decrementCounter,
                          icon: const Icon(Icons.backspace),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(20)),
                          ),
                          label: const Text(
                            'Defect!',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: _incrementCounter,
                          icon: const Icon(Icons.sentiment_very_dissatisfied),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(20)),
                      ),
                      label: const Text(
                        'End',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/result');
                      },
                      icon: const Icon(Icons.published_with_changes),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    //child: StepperTouch(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: resetCount,
        tooltip: 'Reset',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
