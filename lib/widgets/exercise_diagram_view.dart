// lib/widgets/exercise_diagram_view.dart

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/exercise_diagrams.dart';
import '../models/exercise.dart';
import '../models/figure_pose.dart';

/// A small animated stick-figure drawing that shows how an exercise moves.
/// It draws nothing if the exercise has no diagram.
///
/// If the phone has "reduce motion" turned on, it shows the first and last
/// pose side by side instead of animating.
class ExerciseDiagramView extends StatefulWidget {
  const ExerciseDiagramView({
    super.key,
    required this.exercise,
    this.height = 190,
  });

  final Exercise exercise;
  final double height;

  @override
  State<ExerciseDiagramView> createState() => _ExerciseDiagramViewState();
}

class _ExerciseDiagramViewState extends State<ExerciseDiagramView>
    with TickerProviderStateMixin {
  ExerciseDiagram? _diagram;
  List<FigurePose> _sequence = const [];
  Rect _bounds = Rect.zero;
  AnimationController? _controller;

  static const Interval _pause = Interval(0.15, 0.85, curve: Curves.easeInOut);

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  @override
  void didUpdateWidget(ExerciseDiagramView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exercise.id != widget.exercise.id) {
      _controller?.dispose();
      _controller = null;
      _setUp();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _setUp() {
    final diagram = diagramFor(widget.exercise.id);
    _diagram = diagram;
    if (diagram == null) return;
    _sequence = diagram.sequence;
    _bounds = diagram.bounds;
    if (diagram.isAnimated) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000 * _sequence.length),
      )..repeat();
    }
  }

  /// The pose at animation time [t] (0 to 1). Each pair of frames gets an
  /// equal slice of time, with a short pause at each pose.
  FigurePose _poseAt(double t) {
    final count = _sequence.length;
    final scaled = math.min(t * count, count - 0.0001);
    final index = scaled.floor();
    final eased = _pause.transform(scaled - index);
    return FigurePose.lerp(
      _sequence[index],
      _sequence[(index + 1) % count],
      eased,
    );
  }

  @override
  Widget build(BuildContext context) {
    final diagram = _diagram;
    if (diagram == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final controller = _controller;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    Widget figure(FigurePose Function() poseAt, {Listenable? repaint}) {
      return RepaintBoundary(
        child: CustomPaint(
          size: Size.infinite,
          painter: _FigurePainter(
            poseAt: poseAt,
            bounds: _bounds,
            wallX: diagram.wallX,
            near: scheme.primary,
            far: scheme.primary.withValues(alpha: 0.4),
            ground: scheme.outline,
            headFill: scheme.surfaceContainerHighest,
            repaint: repaint,
          ),
        ),
      );
    }

    final Widget picture;
    if (!diagram.isAnimated) {
      picture = SizedBox(
        height: widget.height,
        width: double.infinity,
        child: figure(() => diagram.frames.first),
      );
    } else if (reduceMotion || controller == null) {
      picture = SizedBox(
        height: widget.height,
        child: Row(
          children: [
            Expanded(child: figure(() => diagram.frames.first)),
            Expanded(child: figure(() => diagram.frames.last)),
          ],
        ),
      );
    } else {
      picture = SizedBox(
        height: widget.height,
        width: double.infinity,
        child: figure(() => _poseAt(controller.value), repaint: controller),
      );
    }

    return Semantics(
      image: true,
      label: 'Diagram showing how to do the ${widget.exercise.name}',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
          child: Column(
            children: [
              picture,
              if (diagram.caption != null) ...[
                const SizedBox(height: 6),
                Text(
                  diagram.caption!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FigurePainter extends CustomPainter {
  _FigurePainter({
    required this.poseAt,
    required this.bounds,
    required this.wallX,
    required this.near,
    required this.far,
    required this.ground,
    required this.headFill,
    super.repaint,
  });

  final FigurePose Function() poseAt;
  final Rect bounds;
  final double? wallX;
  final Color near;
  final Color far;
  final Color ground;
  final Color headFill;

  @override
  void paint(Canvas canvas, Size size) {
    // Scale and center so the whole drawing fits the box.
    final scale = math.min(
      size.width / bounds.width,
      size.height / bounds.height,
    );
    final origin = Offset(
      (size.width - bounds.width * scale) / 2 - bounds.left * scale,
      (size.height - bounds.height * scale) / 2 - bounds.top * scale,
    );
    Offset map(Offset point) => point * scale + origin;

    Paint stroke(Color color, double width) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = width * scale;

    void bone(Offset from, Offset to, Paint paint) =>
        canvas.drawLine(map(from), map(to), paint);

    // Floor (and wall).
    canvas.drawLine(
      map(Offset(bounds.left, Body.floorY)),
      map(Offset(bounds.right, Body.floorY)),
      stroke(ground, 1.6),
    );
    final wall = wallX;
    if (wall != null) {
      bone(Offset(wall, bounds.top + 4), Offset(wall, Body.floorY), stroke(ground, 3));
    }

    final s = poseAt().skeleton();
    final farPaint = stroke(far, 4.5);
    final nearPaint = stroke(near, 4.5);

    // Far arm and leg first, so the near ones draw on top.
    bone(s.shoulder, s.elbowFar, farPaint);
    bone(s.elbowFar, s.handFar, farPaint);
    bone(s.hip, s.kneeFar, farPaint);
    bone(s.kneeFar, s.ankleFar, farPaint);
    bone(s.ankleFar, s.toeFar, farPaint);

    bone(s.hip, s.shoulder, stroke(near, 6));
    bone(s.shoulder, s.neck, nearPaint);

    bone(s.hip, s.kneeNear, nearPaint);
    bone(s.kneeNear, s.ankleNear, nearPaint);
    bone(s.ankleNear, s.toeNear, nearPaint);
    bone(s.shoulder, s.elbowNear, nearPaint);
    bone(s.elbowNear, s.handNear, nearPaint);

    canvas.drawCircle(map(s.head), Body.headRadius * scale, Paint()..color = headFill);
    canvas.drawCircle(map(s.head), Body.headRadius * scale, stroke(near, 3));
  }

  @override
  bool shouldRepaint(_FigurePainter oldDelegate) => true;
}