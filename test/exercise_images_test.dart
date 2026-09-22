// test/exercise_images_test.dart

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pump_chump/data/exercise_library.dart';

void main() {
  test('every exercise has an image file in assets/exercises', () {
    for (final exercise in exerciseLibrary) {
      final file = File('assets/exercises/${exercise.id}.png');
      expect(file.existsSync(), isTrue, reason: '${exercise.id}.png is missing');
    }
  });

  test('there are no leftover image files for exercises that do not exist', () {
    final dir = Directory('assets/exercises');
    if (!dir.existsSync()) return;
    final knownIds = exerciseLibrary.map((e) => e.id).toSet();
    for (final entity in dir.listSync()) {
      if (entity is! File || !entity.path.endsWith('.png')) continue;
      final id = entity.uri.pathSegments.last.replaceAll('.png', '');
      expect(knownIds, contains(id), reason: '${entity.path} has no matching exercise');
    }
  });
}