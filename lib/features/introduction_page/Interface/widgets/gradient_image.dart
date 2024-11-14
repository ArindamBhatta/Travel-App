import 'package:flutter/material.dart';

class GradientImage extends StatelessWidget {
  final String? imageUrl;

  GradientImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                ],
                stops: [0.7, 0.85, 1],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Image.asset(
              imageUrl ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Spacer(),
        Expanded(
          flex: 2,
          child: Container(),
        ),
      ],
    );
  }
}
