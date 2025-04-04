import 'package:flutter/material.dart';
import 'dart:ui';

class CommunityPostAppBar extends StatelessWidget {
  final String title;

  const CommunityPostAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Widget highLightedText(String text) {
      return Stack(
        children: [
          // Outer Glow Effect
          Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.purple,
                ),
          ),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 254, 253), // Fire yellow
                Color.fromARGB(255, 223, 223, 223), // Bright orange
                Color.fromARGB(255, 158, 157, 157), // Deep red
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.orangeAccent,
                    offset: Offset(0, 0),
                  ),
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.redAccent,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: highLightedText(title),
    );
  }
}
