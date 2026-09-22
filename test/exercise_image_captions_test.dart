// test/exercise_image_captions_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:pump_chump/data/exercise_image_captions.dart';
import 'package:pump_chump/data/exercise_library.dart';

void main() {
  test('every exercise has an image caption', () {
    for (final exercise in exerciseLibrary) {
      final caption = imageCaptionFor(exercise.id);
      expect(caption, isNotNull, reason: exercise.id);
      expect(caption!.length, greaterThan(15), reason: exercise.id);
    }
  });

  test('there are no captions for exercises that do not exist', () {
    for (final id in exerciseImageCaptions.keys) {
      expect(findExercise(id), isNotNull, reason: id);
    }
  });

  test('captions end with sentence-ending punctuation', () {
    final ending = RegExp(r'[.!?]$');
    for (final entry in exerciseImageCaptions.entries) {
      expect(ending.hasMatch(entry.value.trim()), isTrue, reason: entry.key);
    }
  });
}