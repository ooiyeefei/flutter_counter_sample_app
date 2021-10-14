import 'package:flutter/material.dart';
import 'package:counter_app/screens/home.dart';
import 'package:nanoid/nanoid.dart';

class ResultScreen extends StatelessWidget {
  final int userCount;
  const ResultScreen({Key? key, required this.userCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var id = MyHomePageState.id;
    var machineCount = MyHomePageState.machineCount;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/lego_background_result.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Your Count:',
                          style: TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                        Text(
                          '$userCount',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(30.0),
                    ),
                    Column(
                      children: [
                        const Text(
                          'Machine Count:',
                          style: TextStyle(
                            fontSize: 40.0,
                          ),
                        ),
                        Text(
                          '$id count = $machineCount',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(100),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(20)),
                    ),
                    onPressed: () async {
                      MyHomePageState.counter = 0;
                      MyHomePageState.id =
                          int.parse(customAlphabet('1234567890', 10));
                      MyHomePageState().createNewDdbEntry(
                          MyHomePageState.id, MyHomePageState.counter);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                              title: 'Re:Invent 2021 Finding Lego'),
                        ),
                      );
                    },
                    label: const Text(
                      'Restart',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    icon: const Icon(Icons.restart_alt),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
