import 'package:flutter/material.dart';

import 'disc.dart';

class MyDisc extends StatelessWidget {
  const MyDisc({required this.disc, super.key});

  final Disc disc;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final biggerRadius = constraints.maxHeight * 0.15;
      final smallerRadius = constraints.maxHeight * 0.1;
      final color = disc.color;

      return Hero(
        tag: disc.name,
        child: Container(
          decoration: BoxDecoration(
            gradient: SweepGradient(
              center: Alignment.center,
              startAngle: 0.0,
              endAngle: 6.28,
              colors: [
                color.withOpacity(0.3),
                color.withOpacity(0.7),
                color,
                color.withOpacity(0.5),
                Colors.white.withOpacity(0.4),
                color.withOpacity(0.8),
                color.withOpacity(0.4),
                color,
                color.withOpacity(0.6),
                Colors.white.withOpacity(0.3),
                color.withOpacity(0.9),
                color.withOpacity(0.5),
                color.withOpacity(0.3),
              ],
              stops: const [
                0.0,
                0.08,
                0.16,
                0.24,
                0.32,
                0.40,
                0.48,
                0.56,
                0.64,
                0.72,
                0.80,
                0.88,
                1.0,
              ],
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Center(
            child: Container(
              width: biggerRadius * 2,
              height: biggerRadius * 2,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: smallerRadius * 2,
                  height: smallerRadius * 2,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
