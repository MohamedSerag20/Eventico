import 'package:flutter/material.dart';

class EVSigns extends StatelessWidget {
  EVSigns({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.centerLeft,
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(width: 5, color: Colors.white10),
          borderRadius: BorderRadius.circular(15),
          gradient: RadialGradient(colors: [
            color.withOpacity(0.02),
            color.withOpacity(0.03),
            color.withOpacity(0.04),
            color.withOpacity(0.05),
            color.withOpacity(0.6),
          ])),
      child: Text(text),
    );
  }
}
