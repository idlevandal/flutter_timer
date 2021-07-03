import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color backgroundColour;
  final Color colour;
  final double? width;
  final Icon icon;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    required this.icon,
    this.colour = Colors.white,
    this.backgroundColour = Colors.black,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        icon: icon,
        style: ElevatedButton.styleFrom(
          primary: backgroundColour,
          padding: EdgeInsets.symmetric(horizontal: 22, vertical:  16),
        ),
        label: Text(
          text,
          style: TextStyle(fontSize: 20, color: colour),
        ),
        onPressed: onClicked,
      ),
    );
  }
}
