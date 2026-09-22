// lib/widgets/exercise_image_view.dart

import 'package:flutter/material.dart';

import '../models/exercise.dart';

/// A picture of the exercise, loaded from `assets/exercises/<id>.png`.
///
/// If an image is ever missing for some exercise id, this shows a plain
/// placeholder instead of crashing.
class ExerciseImageView extends StatelessWidget {
  const ExerciseImageView({
    super.key,
    required this.exercise,
    this.height = 190,
  });

  final Exercise exercise;
  final double height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            'assets/exercises/${exercise.id}.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Icon(
                Icons.fitness_center,
                size: 48,
                color: scheme.outline,
              ),
            ),
          ),
        ),
      ),
    );
  }
}