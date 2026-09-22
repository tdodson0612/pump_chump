// lib/models/figure_pose.dart

import 'dart:math' as math;
import 'dart:ui';

/// Body measurements in drawing units. A standing figure is about 100 tall.
class Body {
  static const double torso = 32;
  static const double neck = 5;
  static const double headRadius = 7;
  static const double upperArm = 17;
  static const double forearm = 16;
  static const double thigh = 26;
  static const double shin = 25;
  static const double foot = 9;

  static const double armReach = upperArm + forearm;
  static const double legReach = thigh + shin;

  /// The y position of the floor line in every drawing.
  static const double floorY = 108;
}

Offset _direction(double degrees) {
  final radians = degrees * math.pi / 180;
  return Offset(math.cos(radians), math.sin(radians));
}

/// One arm or one leg, described by where the hand or ankle goes.
///
/// Two styles:
/// - [Limb.point]: the hand/ankle sits at a fixed spot (for example planted on
///   the floor). a = x, b = y.
/// - [Limb.polar]: the limb points in a direction. a = angle in degrees,
///   b = how far it reaches (1 = fully straight).
///
/// [bend] is +1 or -1 and picks which way the elbow or knee bulges.
/// [foot] is the angle of the foot (legs only).
class Limb {
  const Limb.point(this.a, this.b, this.bend, [this.foot = 0]) : isPoint = true;
  const Limb.polar(this.a, this.b, this.bend, [this.foot = 0]) : isPoint = false;

  final double a;
  final double b;
  final double bend;
  final double foot;
  final bool isPoint;

  Offset target(Offset root, double reach) =>
      isPoint ? Offset(a, b) : root + _direction(a) * (b * reach);

  /// Blends two limbs. Both must use the same style; if they do not
  /// (a test checks the data never does this) the first one is kept.
  static Limb lerp(Limb p, Limb q, double t) {
    if (p.isPoint != q.isPoint) return p;
    double mix(double x, double y) => x + (y - x) * t;
    return p.isPoint
        ? Limb.point(mix(p.a, q.a), mix(p.b, q.b), mix(p.bend, q.bend), mix(p.foot, q.foot))
        : Limb.polar(mix(p.a, q.a), mix(p.b, q.b), mix(p.bend, q.bend), mix(p.foot, q.foot));
  }
}

/// Every joint of the figure, ready to draw.
class Skeleton {
  const Skeleton({
    required this.hip,
    required this.shoulder,
    required this.neck,
    required this.head,
    required this.elbowNear,
    required this.handNear,
    required this.elbowFar,
    required this.handFar,
    required this.kneeNear,
    required this.ankleNear,
    required this.toeNear,
    required this.kneeFar,
    required this.ankleFar,
    required this.toeFar,
  });

  final Offset hip;
  final Offset shoulder;
  final Offset neck;

  /// Center of the head circle.
  final Offset head;
  final Offset elbowNear;
  final Offset handNear;
  final Offset elbowFar;
  final Offset handFar;
  final Offset kneeNear;
  final Offset ankleNear;
  final Offset toeNear;
  final Offset kneeFar;
  final Offset ankleFar;
  final Offset toeFar;

  List<Offset> get points => [
        hip, shoulder, neck, head,
        elbowNear, handNear, elbowFar, handFar,
        kneeNear, ankleNear, toeNear, kneeFar, ankleFar, toeFar,
      ];
}

/// Two-bone limb solver ("inverse kinematics"). Given the start of the limb
/// and where the end should go, it finds where the elbow or knee sits so both
/// bones keep their exact length. If the target is too far, the limb just
/// straightens as far as it can.
(Offset, Offset) _solveLimb(
  Offset root,
  Offset target,
  double length1,
  double length2,
  double bend,
) {
  final dx = target.dx - root.dx;
  final dy = target.dy - root.dy;
  final distance = math.sqrt(dx * dx + dy * dy);
  final ux = distance < 1e-9 ? 1.0 : dx / distance;
  final uy = distance < 1e-9 ? 0.0 : dy / distance;

  final shortest = (length1 - length2).abs() + 0.01;
  final longest = length1 + length2 - 0.01;
  final d = math.min(math.max(distance, shortest), longest);

  final along = (length1 * length1 - length2 * length2 + d * d) / (2 * d);
  final out = math.sqrt(math.max(length1 * length1 - along * along, 0.0));

  final joint = Offset(
    root.dx + ux * along + (-uy) * bend * out,
    root.dy + uy * along + ux * bend * out,
  );
  final end = Offset(root.dx + ux * d, root.dy + uy * d);
  return (joint, end);
}

/// One pose of the stick figure.
///
/// Angles are in degrees: 0 = right, 90 = down, -90 = up. The figure faces
/// right. [torso] is the direction from the hip to the shoulder and [head]
/// is the direction from the shoulder to the head.
class FigurePose {
  const FigurePose(
    this.hipX,
    this.hipY,
    this.torso,
    this.head,
    this.armNear,
    this.armFar,
    this.legNear,
    this.legFar,
  );

  final double hipX;
  final double hipY;
  final double torso;
  final double head;
  final Limb armNear;
  final Limb armFar;
  final Limb legNear;
  final Limb legFar;

  static FigurePose lerp(FigurePose p, FigurePose q, double t) {
    double mix(double x, double y) => x + (y - x) * t;
    return FigurePose(
      mix(p.hipX, q.hipX),
      mix(p.hipY, q.hipY),
      mix(p.torso, q.torso),
      mix(p.head, q.head),
      Limb.lerp(p.armNear, q.armNear, t),
      Limb.lerp(p.armFar, q.armFar, t),
      Limb.lerp(p.legNear, q.legNear, t),
      Limb.lerp(p.legFar, q.legFar, t),
    );
  }

  Skeleton skeleton() {
    final hip = Offset(hipX, hipY);
    final shoulder = hip + _direction(torso) * Body.torso;
    final headDirection = _direction(head);
    final neck = shoulder + headDirection * Body.neck;
    final headCenter = shoulder + headDirection * (Body.neck + Body.headRadius);

    final (elbowNear, handNear) = _solveLimb(
      shoulder,
      armNear.target(shoulder, Body.armReach),
      Body.upperArm,
      Body.forearm,
      armNear.bend,
    );
    final (elbowFar, handFar) = _solveLimb(
      shoulder,
      armFar.target(shoulder, Body.armReach),
      Body.upperArm,
      Body.forearm,
      armFar.bend,
    );
    final (kneeNear, ankleNear) = _solveLimb(
      hip,
      legNear.target(hip, Body.legReach),
      Body.thigh,
      Body.shin,
      legNear.bend,
    );
    final (kneeFar, ankleFar) = _solveLimb(
      hip,
      legFar.target(hip, Body.legReach),
      Body.thigh,
      Body.shin,
      legFar.bend,
    );

    return Skeleton(
      hip: hip,
      shoulder: shoulder,
      neck: neck,
      head: headCenter,
      elbowNear: elbowNear,
      handNear: handNear,
      elbowFar: elbowFar,
      handFar: handFar,
      kneeNear: kneeNear,
      ankleNear: ankleNear,
      toeNear: ankleNear + _direction(legNear.foot) * Body.foot,
      kneeFar: kneeFar,
      ankleFar: ankleFar,
      toeFar: ankleFar + _direction(legFar.foot) * Body.foot,
    );
  }
}

/// The animated drawing for one exercise: a few poses that the app
/// blends between, over and over.
class ExerciseDiagram {
  const ExerciseDiagram({
    required this.frames,
    this.caption,
    this.wallX,
    this.pingPong = true,
  });

  final List<FigurePose> frames;

  /// One short line shown under the drawing.
  final String? caption;

  /// If set, a wall is drawn at this x position (wall sit, shin raise).
  final double? wallX;

  /// true: play the frames forward, then backward (A B C B A B C ...).
  /// false: play them in a loop (A B C A B C ...).
  final bool pingPong;

  bool get isAnimated => frames.length > 1;

  /// The order the animation plays the frames. It repeats forever.
  List<FigurePose> get sequence {
    if (!pingPong || frames.length < 3) return frames;
    return [...frames, ...frames.reversed.skip(1).take(frames.length - 2)];
  }

  /// A rectangle that contains every pose, so the drawing can be scaled
  /// to fill its box no matter how big or small the exercise is.
  Rect get bounds {
    var left = double.infinity;
    var right = -double.infinity;
    var top = double.infinity;
    var bottom = Body.floorY;
    for (final frame in frames) {
      final skeleton = frame.skeleton();
      for (final point in skeleton.points) {
        left = math.min(left, point.dx);
        right = math.max(right, point.dx);
        top = math.min(top, point.dy);
        bottom = math.max(bottom, point.dy);
      }
      left = math.min(left, skeleton.head.dx - Body.headRadius);
      right = math.max(right, skeleton.head.dx + Body.headRadius);
      top = math.min(top, skeleton.head.dy - Body.headRadius);
    }
    if (wallX != null) {
      left = math.min(left, wallX! - 4);
      top = math.min(top, 8);
    }
    return Rect.fromLTRB(left - 12, top - 10, right + 12, bottom + 6);
  }
}