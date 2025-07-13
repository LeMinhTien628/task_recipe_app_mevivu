import 'package:flutter/material.dart';

class AppRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double fontSize;

  const AppRoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.amber,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.fromLTRB(40, 0, 40, 0),
    this.borderRadius = 30,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 0,
        padding: padding,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
