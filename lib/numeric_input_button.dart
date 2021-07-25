import 'package:countdown_timer/main.dart';
import 'package:countdown_timer/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumericInputButton extends ConsumerWidget {
  final int value;
  const NumericInputButton(this.value);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final TimeStateNotifier time = watch(timeStateNotifier.notifier);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 5.0,
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                )
            ),
            onPressed: () {
              time.updateTime(value);
              // final t = time.state;
              // t.removeAt(0);
              // t.add(value);
              // time.state = t;
              print(value);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value.toString(),
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(40)),
          ),
        ]
    );
  }
}