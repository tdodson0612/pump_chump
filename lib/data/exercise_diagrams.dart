// lib/data/exercise_diagrams.dart
//
// GENERATED DRAWING DATA. Each exercise has 1 to 4 poses ("frames") and the app
// animates between them. This file is numbers, not logic. To add or fix a
// drawing, ask for a new pose rather than editing numbers by hand.
//
// A frame reads like this:
//   FigurePose(hipX, hipY, torsoAngle, headAngle,
//     armNear, armFar,
//     legNear, legFar)
//
// Angles are in degrees: 0 = right, 90 = down, -90 = up. The figure faces right.
//   Limb.point(x, y, bend, [foot])    hand or ankle at a fixed spot (planted on the floor)
//   Limb.polar(angle, reach, bend, [foot])   limb pointing at an angle; reach 1 = fully straight
// bend is +1 or -1 (which way the elbow or knee bulges).

import '../models/figure_pose.dart';

const List<FigurePose> _pushUpFrames = [
  FigurePose(
    74.4, 84.8, -17.4, -6,
    Limb.point(104.9, 108, 1), Limb.point(109.9, 108, 1),
    Limb.point(26.2, 99.8, -1, 65), Limb.point(22.2, 99.8, -1, 65),
  ),
  FigurePose(
    76.5, 95.9, -4.5, -10,
    Limb.point(104.9, 108, 1), Limb.point(109.9, 108, 1),
    Limb.point(26.2, 99.8, -1, 65), Limb.point(22.2, 99.8, -1, 65),
  ),
];

const Map<String, ExerciseDiagram> exerciseDiagrams = {
  'push_up': ExerciseDiagram(
    frames: _pushUpFrames,
  ),
  'wide_push_up': ExerciseDiagram(
    frames: _pushUpFrames,
    caption: 'Side view. Your hands would be wider than your shoulders.',
  ),
  'diamond_push_up': ExerciseDiagram(
    frames: _pushUpFrames,
    caption: 'Side view. Your hands would be close together under your chest.',
  ),
  'close_grip_push_up': ExerciseDiagram(
    frames: _pushUpFrames,
    caption: 'Side view. Your hands would be under your shoulders.',
  ),
  'pike_push_up': ExerciseDiagram(
    frames: [
      FigurePose(
        53.2, 58.5, 31.7, 55,
        Limb.point(80.4, 108, 1), Limb.point(84.4, 108, 1),
        Limb.point(24.2, 99.8, -1, 65), Limb.point(20.2, 99.8, -1, 65),
      ),
      FigurePose(
        59.9, 64.1, 55, 70,
        Limb.point(80.4, 108, 1), Limb.point(84.4, 108, 1),
        Limb.point(24.2, 99.8, -1, 65), Limb.point(20.2, 99.8, -1, 65),
      ),
    ],
  ),
  'shoulder_tap_plank': ExerciseDiagram(
    frames: [
      FigurePose(
        74.4, 84.8, -17.4, -6,
        Limb.point(104.9, 108, 1), Limb.point(109.9, 108, 1),
        Limb.point(26.2, 99.8, -1, 65), Limb.point(22.2, 99.8, -1, 65),
      ),
      FigurePose(
        74.4, 84.8, -17.4, -6,
        Limb.point(111.9, 86.2, 1), Limb.point(109.9, 108, 1),
        Limb.point(26.2, 99.8, -1, 65), Limb.point(22.2, 99.8, -1, 65),
      ),
    ],
    caption: 'One rep is a tap with each hand.',
  ),
  'prone_iyt_raise': ExerciseDiagram(
    frames: [
      FigurePose(
        63, 106.5, 0, -28,
        Limb.polar(0, 1, 1), Limb.polar(0, 1, 1),
        Limb.polar(180, 1, -1, 180), Limb.polar(180, 1, -1, 180),
      ),
      FigurePose(
        63, 106.5, -12, -30,
        Limb.polar(-32, 1, 1), Limb.polar(-32, 1, 1),
        Limb.polar(190, 1, -1, 180), Limb.polar(190, 1, -1, 180),
      ),
    ],
    caption: 'Your arms lift into an I, then a Y, then a T.',
  ),
  'superman_pull': ExerciseDiagram(
    frames: [
      FigurePose(
        63, 106.5, -28, -34,
        Limb.polar(-38, 1, 1), Limb.polar(-38, 1, 1),
        Limb.polar(192, 1, -1, 180), Limb.polar(192, 1, -1, 180),
      ),
      FigurePose(
        63, 106.5, -28, -34,
        Limb.polar(51, 0.2, 1), Limb.polar(51, 0.2, 1),
        Limb.polar(192, 1, -1, 180), Limb.polar(192, 1, -1, 180),
      ),
    ],
    caption: 'Reach forward, then pull your elbows back to your ribs.',
  ),
  'reverse_snow_angel': ExerciseDiagram(
    frames: [
      FigurePose(
        63, 106.5, -12, -20,
        Limb.polar(190, 1, 1), Limb.polar(190, 1, 1),
        Limb.polar(190, 1, -1, 180), Limb.polar(190, 1, -1, 180),
      ),
      FigurePose(
        63, 106.5, -12, -20,
        Limb.polar(340, 1, 1), Limb.polar(340, 1, 1),
        Limb.polar(190, 1, -1, 180), Limb.polar(190, 1, -1, 180),
      ),
    ],
    caption: 'Sweep your arms in a wide arc, keeping them off the floor.',
  ),
  'superman_hold': ExerciseDiagram(
    frames: [
      FigurePose(
        63, 106.5, -14, -22,
        Limb.polar(-22, 1, 1), Limb.polar(-22, 1, 1),
        Limb.polar(194, 1, -1, 180), Limb.polar(194, 1, -1, 180),
      ),
    ],
    caption: 'Lift up, then hold the top position.',
  ),
  'self_resisted_curl': ExerciseDiagram(
    frames: [
      FigurePose(
        80, 54.9, -90, -90,
        Limb.polar(78, 1, 1), Limb.point(88, 49.9, 1),
        Limb.point(80, 104, -1, 15), Limb.point(76, 104, -1, 15),
      ),
      FigurePose(
        80, 54.9, -90, -90,
        Limb.polar(21, 0.4, 1), Limb.point(94, 31.9, 1),
        Limb.point(80, 104, -1, 15), Limb.point(76, 104, -1, 15),
      ),
    ],
    caption: 'Your other hand presses down on your wrist.',
  ),
  'plank': ExerciseDiagram(
    frames: [
      FigurePose(
        76.2, 92.8, -8, -8,
        Limb.point(123.9, 107, 1), Limb.point(127.9, 107, 1),
        Limb.point(26.2, 99.8, -1, 65), Limb.point(22.2, 99.8, -1, 65),
      ),
    ],
    caption: 'Hold this position.',
  ),
  'crunch': ExerciseDiagram(
    frames: [
      FigurePose(
        66, 106.5, 0, -28,
        Limb.polar(-28, 0.3, -1), Limb.polar(-28, 0.3, -1),
        Limb.point(40, 106.5, 1, -5), Limb.point(37, 106.5, 1, -5),
      ),
      FigurePose(
        66, 106.5, -28, -42,
        Limb.polar(-42, 0.3, -1), Limb.polar(-42, 0.3, -1),
        Limb.point(40, 106.5, 1, -5), Limb.point(37, 106.5, 1, -5),
      ),
    ],
  ),
  'mountain_climber': ExerciseDiagram(
    frames: [
      FigurePose(
        74.4, 84.8, -17.4, -6,
        Limb.point(104.9, 108, 1), Limb.point(109.9, 108, 1),
        Limb.polar(162.6, 1, -1, 65), Limb.polar(90, 0.3, -1, 100),
      ),
      FigurePose(
        74.4, 84.8, -17.4, -6,
        Limb.point(104.9, 108, 1), Limb.point(109.9, 108, 1),
        Limb.polar(165, 0.5, -1, 60), Limb.polar(165, 0.5, -1, 60),
      ),
      FigurePose(
        74.4, 84.8, -17.4, -6,
        Limb.point(104.9, 108, 1), Limb.point(109.9, 108, 1),
        Limb.polar(90, 0.3, -1, 100), Limb.polar(162.6, 1, -1, 65),
      ),
      FigurePose(
        74.4, 84.8, -17.4, -6,
        Limb.point(104.9, 108, 1), Limb.point(109.9, 108, 1),
        Limb.polar(165, 0.5, -1, 60), Limb.polar(165, 0.5, -1, 60),
      ),
    ],
    caption: 'Switch legs, like running in place.',
    pingPong: false,
  ),
  'bicycle_crunch': ExerciseDiagram(
    frames: [
      FigurePose(
        66, 106.5, -25, -30,
        Limb.polar(-30, 0.3, -1), Limb.polar(-30, 0.3, -1),
        Limb.polar(244, 0.6, 1, 200), Limb.polar(195, 1, 1, 180),
      ),
      FigurePose(
        66, 106.5, -25, -30,
        Limb.polar(-30, 0.3, -1), Limb.polar(-30, 0.3, -1),
        Limb.polar(195, 1, 1, 180), Limb.polar(244, 0.6, 1, 200),
      ),
    ],
    caption: 'Turn the opposite elbow toward the knee that comes in.',
  ),
  'lying_leg_raise': ExerciseDiagram(
    frames: [
      FigurePose(
        66, 106.5, 0, -28,
        Limb.polar(180, 1, 1), Limb.polar(180, 1, 1),
        Limb.polar(187, 1, -1, 180), Limb.polar(187, 1, -1, 180),
      ),
      FigurePose(
        66, 106.5, 0, -28,
        Limb.polar(180, 1, 1), Limb.polar(180, 1, 1),
        Limb.polar(270, 1, -1, 180), Limb.polar(270, 1, -1, 180),
      ),
    ],
  ),
  'side_plank': ExerciseDiagram(
    frames: [
      FigurePose(
        80.4, 101, -22, -26,
        Limb.point(126.1, 107, 1), Limb.polar(-80, 1, 1),
        Limb.point(30, 104, -1), Limb.point(31, 103, -1),
      ),
      FigurePose(
        79.7, 94.8, -10.5, -14.5,
        Limb.point(127.1, 107, 1), Limb.polar(-80, 1, 1),
        Limb.point(30, 104, -1), Limb.point(31, 103, -1),
      ),
    ],
    caption: 'Front view. Lift your hips, then hold.',
  ),
  'hollow_hold': ExerciseDiagram(
    frames: [
      FigurePose(
        66, 106.5, 0, -28,
        Limb.polar(-28, 1, 1), Limb.polar(-28, 1, 1),
        Limb.polar(180, 1, -1, 180), Limb.polar(180, 1, -1, 180),
      ),
      FigurePose(
        66, 106.5, -22, -34,
        Limb.polar(-30, 1, 1), Limb.polar(-30, 1, 1),
        Limb.polar(202, 1, -1, 200), Limb.polar(202, 1, -1, 200),
      ),
    ],
    caption: 'Move into the hollow shape, then hold.',
  ),
  'bird_dog': ExerciseDiagram(
    frames: [
      FigurePose(
        65, 79, -7, -10,
        Limb.polar(90, 1, 1), Limb.point(100.8, 108, 1),
        Limb.point(40.5, 105, -1, 180), Limb.polar(136.6, 0.7, -1, 180),
      ),
      FigurePose(
        65, 79, -7, -10,
        Limb.polar(-3, 1, 1), Limb.point(100.8, 108, 1),
        Limb.point(40.5, 105, -1, 180), Limb.polar(180, 1, -1, 180),
      ),
    ],
    caption: 'Then switch sides.',
  ),
  'glute_bridge': ExerciseDiagram(
    frames: [
      FigurePose(
        63, 106.5, 0, -28,
        Limb.point(62.5, 107, 1), Limb.point(62.5, 107, 1),
        Limb.point(43, 106.5, 1, 5), Limb.point(40, 106.5, 1, 5),
      ),
      FigurePose(
        65.8, 93.5, 24, -28,
        Limb.point(62.5, 107, 1), Limb.point(62.5, 107, 1),
        Limb.point(43, 106.5, 1, 5), Limb.point(40, 106.5, 1, 5),
      ),
    ],
  ),
  'single_leg_glute_bridge': ExerciseDiagram(
    frames: [
      FigurePose(
        63, 106.5, 0, -28,
        Limb.point(62.5, 107, 1), Limb.point(62.5, 107, 1),
        Limb.point(43, 106.5, 1, 5), Limb.polar(204, 1, -1, 200),
      ),
      FigurePose(
        65.8, 93.5, 24, -28,
        Limb.point(62.5, 107, 1), Limb.point(62.5, 107, 1),
        Limb.point(43, 106.5, 1, 5), Limb.polar(204, 1, -1, 200),
      ),
    ],
    caption: 'Do all reps on one side, then switch.',
  ),
  'bodyweight_squat': ExerciseDiagram(
    frames: [
      FigurePose(
        80, 54.9, -90, -90,
        Limb.polar(0, 1, 1), Limb.polar(0, 1, 1),
        Limb.point(80, 105.7, -1, 15), Limb.point(76, 105.7, -1, 15),
      ),
      FigurePose(
        58, 80, -55, -62,
        Limb.polar(0, 1, 1), Limb.polar(0, 1, 1),
        Limb.point(80, 105.7, -1, 15), Limb.point(76, 105.7, -1, 15),
      ),
    ],
  ),
  'reverse_lunge': ExerciseDiagram(
    frames: [
      FigurePose(
        100, 54.9, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(100, 105.7, -1, 15), Limb.point(94, 105.7, -1, 15),
      ),
      FigurePose(
        74, 80.7, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(100, 105.7, -1, 15), Limb.point(32.2, 99.8, -1, 65),
      ),
    ],
    caption: 'Step back, lower, then stand up.',
  ),
  'split_squat': ExerciseDiagram(
    frames: [
      FigurePose(
        78.5, 59, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(100, 105.7, -1, 15), Limb.point(48.2, 99.8, -1, 65),
      ),
      FigurePose(
        77, 80, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(100, 105.7, -1, 15), Limb.point(48.2, 99.8, -1, 65),
      ),
    ],
    caption: 'Do all reps on one side, then switch.',
  ),
  'wall_sit': ExerciseDiagram(
    frames: [
      FigurePose(
        36, 80.7, -90, -90,
        Limb.point(54, 77, -1), Limb.point(57, 77, -1),
        Limb.point(62, 104, -1, 15), Limb.point(65, 104, -1, 15),
      ),
    ],
    caption: 'Hold this position.',
    wallX: 28,
  ),
  'single_leg_rdl': ExerciseDiagram(
    frames: [
      FigurePose(
        86, 54.9, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(85, 105.7, -1, 15), Limb.polar(105, 1, -1, 170),
      ),
      FigurePose(
        81, 56.5, 3, 12,
        Limb.polar(90, 1, 1), Limb.polar(90, 1, 1),
        Limb.point(85, 105.7, -1, 15), Limb.polar(180, 1, -1, 170),
      ),
    ],
    caption: 'Then switch legs.',
  ),
  'bridge_walkout': ExerciseDiagram(
    frames: [
      FigurePose(
        65.8, 93.5, 24, -28,
        Limb.point(62.5, 107, 1), Limb.point(62.5, 107, 1),
        Limb.point(43, 106.5, 1, -25), Limb.point(40, 106.5, 1, -25),
      ),
      FigurePose(
        65.8, 93.5, 24, -28,
        Limb.point(62.5, 107, 1), Limb.point(62.5, 107, 1),
        Limb.point(18, 106.5, 1, -25), Limb.point(15, 106.5, 1, -25),
      ),
    ],
  ),
  'calf_raise': ExerciseDiagram(
    frames: [
      FigurePose(
        80, 54.9, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(80, 105.7, -1, 15), Limb.point(76, 105.7, -1, 15),
      ),
      FigurePose(
        84.9, 49, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(84.9, 99.8, -1, 65), Limb.point(80.9, 99.8, -1, 65),
      ),
    ],
  ),
  'single_leg_calf_raise': ExerciseDiagram(
    frames: [
      FigurePose(
        80, 54.9, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(80, 105.7, -1, 15), Limb.polar(134, 0.7, -1, 150),
      ),
      FigurePose(
        84.9, 49, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(84.9, 99.8, -1, 65), Limb.polar(134, 0.7, -1, 150),
      ),
    ],
    caption: 'Then switch legs.',
  ),
  'tibialis_wall_raise': ExerciseDiagram(
    frames: [
      FigurePose(
        47, 56, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(59, 104.5, -1, 15), Limb.point(62, 104.5, -1, 15),
      ),
      FigurePose(
        47, 56, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(59, 104.5, -1, -45), Limb.point(62, 104.5, -1, -45),
      ),
    ],
    caption: 'Lift your toes toward your shins.',
    wallX: 42,
  ),
  'burpee': ExerciseDiagram(
    frames: [
      FigurePose(
        80, 54.9, -90, -90,
        Limb.polar(92, 1, 1), Limb.polar(92, 1, 1),
        Limb.point(80, 105.7, -1, 15), Limb.point(76, 105.7, -1, 15),
      ),
      FigurePose(
        56, 86, -10, -30,
        Limb.polar(75, 0.9, 1), Limb.polar(75, 0.9, 1),
        Limb.point(80, 105.7, -1, 15), Limb.point(76, 105.7, -1, 15),
      ),
      FigurePose(
        74.4, 84.8, -17.4, -6,
        Limb.polar(90, 1, 1), Limb.polar(90, 1, 1),
        Limb.point(26.2, 99.8, -1, 65), Limb.point(22.2, 99.8, -1, 65),
      ),
    ],
  ),
};

/// The drawing for an exercise, or null if it has none.
ExerciseDiagram? diagramFor(String exerciseId) => exerciseDiagrams[exerciseId];