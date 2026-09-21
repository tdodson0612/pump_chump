// lib/models/exercise_progress.dart

import 'dart:math';

import 'exercise.dart';

/// What happened after the user logged a result.
class GoalUpdate {
  const GoalUpdate({
    required this.progress,
    required this.previousGoal,
    required this.goalReached,
    required this.newPersonalBest,
  });

  final ExerciseProgress progress;
  final int previousGoal;
  final bool goalReached;
  final bool newPersonalBest;
}

/// Tracks ONE exercise: its current goal and personal best.
/// Immutable: applyResult returns a new object instead of changing this one.
class ExerciseProgress {
  const ExerciseProgress({
    required this.exerciseId,
    required this.currentGoal,
    this.personalBest = 0,
    this.timesLogged = 0,
  });

  factory ExerciseProgress.initial(Exercise exercise) => ExerciseProgress(
        exerciseId: exercise.id,
        currentGoal: exercise.startingGoal,
      );

  final String exerciseId;
  final int currentGoal;
  final int personalBest;
  final int timesLogged;

  /// Rules:
  /// - The ACTUAL number is always what gets recorded (never the goal).
  /// - If actual >= goal, the goal goes up by exactly one step (+5 by default).
  ///   Example: goal 15, did 17 -> record 17, next goal 20.
  /// - If actual < goal, the goal stays the same.
  GoalUpdate applyResult(int actual, Exercise exercise) {
    final reached = actual >= currentGoal;
    final isBest = actual > personalBest;
    final next = ExerciseProgress(
      exerciseId: exerciseId,
      currentGoal:
          reached ? currentGoal + exercise.progressionAmount : currentGoal,
      personalBest: max(personalBest, actual),
      timesLogged: timesLogged + 1,
    );
    return GoalUpdate(
      progress: next,
      previousGoal: currentGoal,
      goalReached: reached,
      newPersonalBest: isBest,
    );
  }

  Map<String, dynamic> toJson() => {
        'exerciseId': exerciseId,
        'currentGoal': currentGoal,
        'personalBest': personalBest,
        'timesLogged': timesLogged,
      };

  factory ExerciseProgress.fromJson(Map<String, dynamic> json) =>
      ExerciseProgress(
        exerciseId: json['exerciseId'] as String,
        currentGoal: json['currentGoal'] as int,
        personalBest: json['personalBest'] as int? ?? 0,
        timesLogged: json['timesLogged'] as int? ?? 0,
      );
}