// test/exercise_diagrams_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pump_chump/data/exercise_diagrams.dart';
import 'package:pump_chump/data/exercise_library.dart';
import 'package:pump_chump/models/figure_pose.dart';
import 'package:pump_chump/widgets/exercise_diagram_view.dart';

double _gap(Offset a, Offset b) => (a - b).distance;

void main() {
  test('every exercise has a diagram', () {
    for (final exercise in exerciseLibrary) {
      expect(diagramFor(exercise.id), isNotNull, reason: exercise.id);
    }
  });

  test('there are no diagrams for exercises that do not exist', () {
    for (final id in exerciseDiagrams.keys) {
      expect(findExercise(id), isNotNull, reason: id);
    }
  });

  test('frames of one exercise use the same limb style and bend', () {
    exerciseDiagrams.forEach((id, diagram) {
      final first = diagram.frames.first;
      for (final frame in diagram.frames) {
        expect(frame.armNear.isPoint, first.armNear.isPoint, reason: '$id armNear');
        expect(frame.armFar.isPoint, first.armFar.isPoint, reason: '$id armFar');
        expect(frame.legNear.isPoint, first.legNear.isPoint, reason: '$id legNear');
        expect(frame.legFar.isPoint, first.legFar.isPoint, reason: '$id legFar');
        expect(frame.armNear.bend, first.armNear.bend, reason: '$id armNear bend');
        expect(frame.armFar.bend, first.armFar.bend, reason: '$id armFar bend');
        expect(frame.legNear.bend, first.legNear.bend, reason: '$id legNear bend');
        expect(frame.legFar.bend, first.legFar.bend, reason: '$id legFar bend');
      }
    });
  });

  test('bones keep their length in every frame and in-between frame', () {
    exerciseDiagrams.forEach((id, diagram) {
      final sequence = diagram.sequence;
      for (var i = 0; i < sequence.length; i++) {
        final next = sequence[(i + 1) % sequence.length];
        for (var step = 0; step <= 10; step++) {
          final s = FigurePose.lerp(sequence[i], next, step / 10).skeleton();
          void expectLength(Offset a, Offset b, double length) =>
              expect(_gap(a, b), closeTo(length, 0.05), reason: id);
          expectLength(s.hip, s.shoulder, Body.torso);
          expectLength(s.hip, s.kneeNear, Body.thigh);
          expectLength(s.kneeNear, s.ankleNear, Body.shin);
          expectLength(s.hip, s.kneeFar, Body.thigh);
          expectLength(s.kneeFar, s.ankleFar, Body.shin);
          expectLength(s.shoulder, s.elbowNear, Body.upperArm);
          expectLength(s.elbowNear, s.handNear, Body.forearm);
          expectLength(s.shoulder, s.elbowFar, Body.upperArm);
          expectLength(s.elbowFar, s.handFar, Body.forearm);
        }
      }
    });
  });

  test('every drawing stays inside the canvas and has real numbers', () {
    exerciseDiagrams.forEach((id, diagram) {
      for (final frame in diagram.frames) {
        for (final point in frame.skeleton().points) {
          expect(point.dx.isFinite && point.dy.isFinite, isTrue, reason: id);
          expect(point.dx, inInclusiveRange(-6, 166), reason: id);
          expect(point.dy, inInclusiveRange(-6, 118), reason: id);
        }
      }
      final bounds = diagram.bounds;
      expect(bounds.width, greaterThan(20), reason: id);
      expect(bounds.height, greaterThan(20), reason: id);
    });
  });

  test('animated exercises have at least two frames, timed holds may have one', () {
    for (final diagram in exerciseDiagrams.values) {
      expect(diagram.frames, isNotEmpty);
      expect(diagram.sequence.length, greaterThanOrEqualTo(diagram.frames.length));
    }
  });

  test('ping-pong plays forward and then back', () {
    final a = exerciseDiagrams['burpee']!;
    expect(a.frames, hasLength(3));
    expect(a.sequence, hasLength(4)); // A B C B, then it loops back to A
    expect(a.sequence[3], same(a.frames[1]));
  });

  test('the solver straightens a limb that is asked to reach too far', () {
    const pose = FigurePose(
      50, 50, -90, -90,
      Limb.point(500, 500, 1), Limb.point(500, 500, 1),
      Limb.point(500, 500, -1), Limb.point(500, 500, -1),
    );
    final s = pose.skeleton();
    expect((s.hip - s.ankleNear).distance, closeTo(Body.legReach, 0.1));
  });

  testWidgets('the diagram view draws for every exercise', (tester) async {
    for (final exercise in exerciseLibrary) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ExerciseDiagramView(exercise: exercise)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 700));
      expect(find.byType(CustomPaint), findsWidgets, reason: exercise.id);
      expect(tester.takeException(), isNull, reason: exercise.id);
    }
    // Remove the widget so its repeating animation stops.
    await tester.pumpWidget(const SizedBox());
  });
}