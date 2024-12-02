import 'package:flutter/material.dart';

class MainCircle extends StatelessWidget {
  const MainCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      width: 32,
      height: 32,
    );
  }
}
