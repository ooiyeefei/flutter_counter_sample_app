import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanoid/nanoid.dart';
import 'package:dio/dio.dart';
import 'dart:async';

// class SessionResult {
//   static int id = 0;
//   static int user_count = 0;
//   static int machine_count = 0;

//   SessionResult({
//     required this.id,
//     required this.user_count,
//     required this.machine_count,
//   });

//   factory SessionResult.fromJson(Map<String, dynamic> json) {
//     return SessionResult(
//       id: json['id'],
//       user_count: json['user_count'],
//       // machine_count: json['machine_count'],
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static int counter = 0;
  static int userCount = 0;
  static int machineCount = 0;
  static var id = int.parse(customAlphabet('1234567890', 10));

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
    setState(() {
      counter = 0;
      id = int.parse(customAlphabet('1234567890', 10));
    });
    createNewDdbEntry(id, counter);
  }

  void updateFromResponse(Response response) {
    setState(() {
      machineCount = response.data['machine_count'];
      userCount = response.data['user_count'];
    });
  }

  Future<void> updateDdb(var id, int counter) async {
    var dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      var customHeaders = {
        'request-source': 'application/flutter'
        // other headers
      };
      options.headers.addAll(customHeaders);
      return handler.next(options);
    }));

    Response response = await dio.post(
        'https://jfcdnq64m6.execute-api.us-east-1.amazonaws.com/prod',
        data: {
          'id': '$id',
          'user_count': '$counter',
          'isActive': false,
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      updateFromResponse(response);
      // return SessionResult.fromJson(jsonDecode(response.data));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update DDB.');
    }
  }

  Future<void> createNewDdbEntry(var id, int counter) async {
    var dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      var customHeaders = {
        'request-source': 'application/flutter'
        // other headers
      };
      options.headers.addAll(customHeaders);
      return handler.next(options);
    }));

    Response response = await dio.post(
        'https://jfcdnq64m6.execute-api.us-east-1.amazonaws.com/prod',
        data: {
          'id': '$id',
          'user_count': '$counter',
          'isActive': true,
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("successfully created new DDB item");
      // return SessionResult.fromJson(jsonDecode(response.data));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to create new DDB item.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  image: NetworkImage(
                      'https://d1sb2anak0ziro.cloudfront.net/lego_background.jpeg'),
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
                      onPressed: () async {
                        await updateDdb(id, counter);
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
