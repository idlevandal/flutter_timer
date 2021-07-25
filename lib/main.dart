import 'dart:async';
import 'dart:ui';

import 'package:countdown_timer/time.dart';
import 'package:countdown_timer/time_display.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'button_widget.dart';
import 'numeric_input_button.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final timeProvider = StateProvider<List<int>>((_) {
  return [0, 0, 0, 0, 0, 0];
});

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
      body: SlidingUpPanel(
        onPanelClosed: () {
          print('reset array to all zeros');
        },
        minHeight: 70.0,
        parallaxEnabled: true,
        parallaxOffset: 0.4,
        panel: Container(
          padding: EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border(
              top: BorderSide(width: 2.0, color: Colors.blue.shade600),
            ),
          ),
          child: Consumer(builder: (context, watch, _) {
            final timeList = watch(timeStateNotifier);
            final TimeStateNotifier tsn = watch(timeStateNotifier.notifier);
            return Column(
              children: [
                TimeDisplay(time: timeList),
                SizedBox(height: 20.0,),

                buildRow(1, 2, 3),
                buildRow(4, 5, 6),
                buildRow(7, 8, 9),
                SizedBox(height: 20.0,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Container()),
                      Expanded(child: NumericInputButton(0)),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 40.0),
                          child: IconButton(
                              onPressed: () {
                                tsn.deleteTime();
                                // final array = timeList.state;
                                // array.removeLast();
                                // array.insert(0, 0);
                                // timeList.state = array;
                                print('deleting...');
                              },
                              icon: Icon(Icons.backspace_outlined, color: Colors.blue, size: 30.0,)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        ),
        collapsed: Container(
          padding: EdgeInsets.only(top: 10.0),
          color: Colors.blue.shade600,
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Set time',
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
          ),
        ),
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
          ),
        ),
      )
    );
  }

  Widget buildRow(int a, int b, int c) {
    return Column(
      children: [
        SizedBox(height: 20.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumericInputButton(a),
            NumericInputButton(b),
            NumericInputButton(c),
          ],
        )
      ],
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  icon: Icon(
                    isRunning ? Icons.pause : Icons.play_arrow,
                    color: Colors.blue.shade100,
                  ),
                  text: isRunning ? 'Pause' : 'Resume',
                  width: 160,
                  onClicked: () {
                    isRunning
                        ? stopTimer(reset: false)
                        : startTimer(reset: false);
                  }),
              SizedBox(
                width: 10.0,
              ),
              ButtonWidget(
                icon: Icon(
                  Icons.stop,
                  color: Colors.blue.shade100,
                ),
                text: 'Cancel',
                width: 160,
                onClicked: stopTimer,
              ),
            ],
          )
        : ButtonWidget(
            icon: Icon(
              Icons.play_arrow,
              color: Colors.blue.shade200,
            ),
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
            // valueColor: AlwaysStoppedAnimation(Colors.white),
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
      return Icon(
        Icons.done,
        color: Colors.blue.shade200,
        size: 100.0,
      );
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


