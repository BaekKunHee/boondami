import 'package:flutter/material.dart';

class JmButton extends StatelessWidget {
  const JmButton({super.key, required this.onPressed, required this.text});

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
