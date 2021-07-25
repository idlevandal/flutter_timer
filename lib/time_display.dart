import 'package:flutter/material.dart';

class TimeDisplay extends StatelessWidget {

  final List<int> time;

  TimeDisplay({required this.time});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('${time[0]}${time[1]}', style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w600),),
              Text('h'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('${time[2]}${time[3]}', style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w600),),
              Text('m'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('${time[4]}${time[5]}', style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w600),),
              Text('s')
            ],
          )
        ],
      ),
    );
  }
}
