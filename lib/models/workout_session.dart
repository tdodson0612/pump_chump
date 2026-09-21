// lib/models/workout_session.dart

/// The result of one exercise inside a finished workout.
class ExerciseResult {
  const ExerciseResult({
    required this.exerciseId,
    required this.goal,
    required this.actual,
  });

  final String exerciseId;

  /// The goal the user was aiming for at the time.
  final int goal;

  /// What the user really did. Never replaced by the goal.
  final int actual;

  bool get reachedGoal => actual >= goal;

  Map<String, dynamic> toJson() => {
        'exerciseId': exerciseId,
        'goal': goal,
        'actual': actual,
      };

  factory ExerciseResult.fromJson(Map<String, dynamic> json) => ExerciseResult(
        exerciseId: json['exerciseId'] as String,
        goal: json['goal'] as int,
        actual: json['actual'] as int,
      );
}

/// One completed workout, saved to history.
class WorkoutSession {
  const WorkoutSession({
    required this.date,
    required this.planName,
    required this.results,
  });

  final DateTime date;
  final String planName;
  final List<ExerciseResult> results;

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'planName': planName,
        'results': results.map((r) => r.toJson()).toList(),
      };

  factory WorkoutSession.fromJson(Map<String, dynamic> json) => WorkoutSession(
        date: DateTime.parse(json['date'] as String),
        planName: json['planName'] as String,
        results: (json['results'] as List<dynamic>)
            .map((r) => ExerciseResult.fromJson(r as Map<String, dynamic>))
            .toList(),
      );
}