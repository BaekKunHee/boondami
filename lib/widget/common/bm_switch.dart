import 'package:flutter/material.dart';

class BMSwitch extends StatefulWidget {
  final bool disabled;
  const BMSwitch({super.key, required this.disabled});

  @override
  BMSwitchState createState() => BMSwitchState();
}

class BMSwitchState extends State<BMSwitch>
    with SingleTickerProviderStateMixin {
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.disabled) {
          setState(() {
            isMale = !isMale;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 40,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isMale ? Colors.blue : Colors.pink,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              left: isMale ? 0 : 20,
              right: isMale ? 20 : 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    isMale ? '남' : '여',
                    style: TextStyle(
                      color: isMale ? Colors.blue : Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
