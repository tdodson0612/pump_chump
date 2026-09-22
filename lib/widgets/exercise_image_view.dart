// lib/widgets/exercise_image_view.dart

import 'package:flutter/material.dart';

import '../data/exercise_image_captions.dart';
import '../models/exercise.dart';

/// A picture of the exercise, loaded from `assets/exercises/<id>.png`, with
/// a short caption underneath explaining what the picture shows.
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final caption = imageCaptionFor(exercise.id);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        child: Column(
          children: [
            SizedBox(
              height: height,
              width: double.infinity,
              child: Image.asset(
                'assets/exercises/${exercise.id}.png',
                fit: BoxFit.contain,
                semanticLabel: 'Diagram showing how to do the ${exercise.name}',
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(
                    Icons.fitness_center,
                    size: 48,
                    color: scheme.outline,
                  ),
                ),
              ),
            ),
            if (caption != null) ...[
              const SizedBox(height: 8),
              Text(
                caption,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}