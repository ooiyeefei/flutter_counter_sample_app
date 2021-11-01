import 'package:flutter/material.dart';
import 'package:counter_app/screens/home.dart';

class ResultScreen extends StatelessWidget {
  final int userCount;
  const ResultScreen({Key? key, required this.userCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var id = MyHomePageState.id;
    var machineCount = MyHomePageState.machineCount;

    precacheImage(
      const NetworkImage(
          'https://d1sb2anak0ziro.cloudfront.net/lego_background_result.jpeg'),
      context,
    );

    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.all(5.0),
        child: Text(
          '$id',
          style: const TextStyle(
            fontSize: 12.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://d1sb2anak0ziro.cloudfront.net/lego_background_result.jpeg"),
                fit: BoxFit.cover,
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
                          '$machineCount',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(50),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(20)),
                    ),
                    onPressed: () async {
                      // MyHomePageState.counter = 0;
                      // MyHomePageState.id =
                      //     int.parse(customAlphabet('1234567890', 10));
                      // MyHomePageState().createNewDdbEntry(
                      //     MyHomePageState.id, MyHomePageState.counter);
                      await Navigator.pushNamed(context, '/loading');
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
          // Stack(
          //   alignment: AlignmentDirectional.bottomCenter,
          //   children: [
          //     Column(
          //       children: [
          //         Text(
          //           '$id',
          //           style: const TextStyle(
          //             fontSize: 12.0,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
