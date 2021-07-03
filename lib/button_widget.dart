import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color backgroundColour;
  final Color colour;
  final double? width;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    this.colour = Colors.white,
    this.backgroundColour = Colors.black,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColour,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical:  16),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: colour),
        ),
        onPressed: onClicked,
      ),
    );
  }
}
