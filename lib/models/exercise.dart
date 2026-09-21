// lib/models/exercise.dart

enum BodyRegion {
  chest('Chest'),
  shoulders('Shoulders'),
  triceps('Triceps'),
  biceps('Biceps'),
  back('Back'),
  core('Core'),
  glutes('Glutes'),
  quads('Quads'),
  hamstrings('Hamstrings'),
  calves('Calves'),
  shins('Shins'),
  fullBody('Full Body');

  const BodyRegion(this.label);
  final String label;
}

enum ExerciseType {
  reps('reps'),
  time('sec');

  const ExerciseType(this.unit);
  final String unit;
}

enum Difficulty { beginner, intermediate }

/// One exercise in the library. Instances are constants and never change.
class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    required this.region,
    required this.targetMuscles,
    required this.instructions,
    this.type = ExerciseType.reps,
    this.startingGoal = 10,
    this.progressionAmount = 5,
    this.difficulty = Difficulty.beginner,
    this.perSide = false,
    this.sets = 2,
    this.note,
  });

  final String id;
  final String name;
  final BodyRegion region;
  final String targetMuscles;
  final String instructions;
  final ExerciseType type;
  final int startingGoal;
  final int progressionAmount;
  final Difficulty difficulty;

  /// True for one-sided moves (lunges, side planks). Goal applies to each side.
  final bool perSide;

  /// How many sets to do. Only your best set is recorded.
  final int sets;

  /// Honest limitation (for example "indirect stimulus"). Shown in the app.
  final String? note;

  String get unit => type.unit;

  String goalLabel(int goal) => perSide ? '$goal $unit each side' : '$goal $unit';
}