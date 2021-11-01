import 'package:flutter/material.dart';
import 'dart:async';
import 'package:counter_app/screens/home.dart';
import 'package:nanoid/nanoid.dart';
import 'package:dio/dio.dart';

// ignore: use_key_in_widget_constructors
class LoadingView extends StatefulWidget {
  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  static const int _kDuration = 3;
  int seconds = _kDuration;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        seconds--;
      });
    });
  }

  Future<void> closeActiveDdbSession() async {
    var dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      var customHeaders = {
        'request-source': 'application/flutter/close',
        // other headers
      };
      options.headers.addAll(customHeaders);
      return handler.next(options);
    }));

    Response response = await dio.post(
        'https://jfcdnq64m6.execute-api.us-east-1.amazonaws.com/prod/flutter',
        data: {
          'isActive': false,
        });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("successfully close existing active session");
      // return SessionResult.fromJson(jsonDecode(response.data));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update DDB.');
    }
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(
      const NetworkImage(
          'https://d1sb2anak0ziro.cloudfront.net/lego_background.jpeg'),
      context,
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://d1sb2anak0ziro.cloudfront.net/lego_background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$seconds',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                  ),
                  onPressed: () {
                    closeActiveDdbSession();
                    MyHomePageState.counter = 0;
                    MyHomePageState.id =
                        int.parse(customAlphabet('1234567890', 10));
                    MyHomePageState().createNewDdbEntry(
                        MyHomePageState.id, MyHomePageState.counter);
                    startTimer();
                    Timer(Duration(seconds: 3),
                        () => Navigator.pushNamed(context, '/'));
                  },
                  child: Text(
                    'Start',
                    style: TextStyle(fontSize: 20),
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
