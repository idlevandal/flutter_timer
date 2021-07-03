import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'button_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const maxSeconds = 60000;
  int seconds = maxSeconds;
  Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(Duration(milliseconds: 20), (_) {
      if (seconds > 0) {
        setState(() => seconds -= 20);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTimer(),
          const SizedBox(
            height: 80,
          ),
          buildButtons(),
        ],
      )),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted =  seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                icon: Icon(isRunning ? Icons.pause : Icons.play_arrow, color: Colors.blue.shade100,),
                  text: isRunning ? 'Pause' : 'Resume',
                  width: 160,
                  onClicked: () {
                    isRunning ? stopTimer(reset: false) : startTimer(reset: false);
                  }),
              SizedBox(width: 10.0,),
              ButtonWidget(
                icon: Icon(Icons.stop, color: Colors.blue.shade100,),
                text: 'Cancel',
                width: 160,
                onClicked: stopTimer,
              ),
            ],
          )
        : ButtonWidget(
            icon: Icon(Icons.play_arrow, color: Colors.blue.shade200,),
            text: 'Start Timer!',
            colour: Colors.black87,
            backgroundColour: Colors.white,
            onClicked: () {
              startTimer();
            },
          );
  }

  Widget buildTimer() {
    return SizedBox(
      height: 200.0,
      width: 200.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: seconds / maxSeconds,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 12,
            backgroundColor: Colors.blue.shade200,
          ),
          Center(child: buildTime()),
        ],
      ),
    );
  }

  Widget buildTime() {
    if (seconds == 0) {
      return Icon(Icons.done, color: Colors.blue.shade200, size: 100.0,);
    } else
    return Text(
      '${(seconds / 1000).round()}',
      style: TextStyle(
        fontFeatures: [
          FontFeature.tabularFigures(),
        ],
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 80,
      ),
    );
  }
}
