import 'dart:math';
import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';

class AnimatedBottomWaves extends StatefulWidget {
  const AnimatedBottomWaves({super.key});

  @override
  State<AnimatedBottomWaves> createState() => _AnimatedBottomWavesState();
}

class _AnimatedBottomWavesState extends State<AnimatedBottomWaves>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _AnimatedWavesPainter(
              animationValue: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

class _AnimatedWavesPainter extends CustomPainter {
  final double animationValue;

  _AnimatedWavesPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Back wave (lighter)
    _drawWave(
      canvas,
      size,
      color: AppColors.primary.withOpacity(0.15),
      amplitude: 18,
      baseY: 70,
      phaseShift: animationValue * 2 * pi,
      frequency: 1.5,
    );

    // Front wave (darker pink)
    _drawWave(
      canvas,
      size,
      color: AppColors.primary.withOpacity(0.15),
      amplitude: 22,
      baseY: 110,
      phaseShift: animationValue * 2 * pi + pi * 0.6,
      frequency: 1.2,
    );
  }

  void _drawWave(
      Canvas canvas,
      Size size, {
        required Color color,
        required double amplitude,
        required double baseY,
        required double phaseShift,
        required double frequency,
      }) {
    final paint = Paint()..color = color;
    final path = Path();

    path.moveTo(0, baseY);

    for (double x = 0; x <= size.width; x++) {
      final y = baseY +
          amplitude *
              sin((x / size.width * 2 * pi * frequency) + phaseShift);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_AnimatedWavesPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}