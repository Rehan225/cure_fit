import 'dart:async';

import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../models/workout.dart';
import '../../theme/app_theme.dart';

class WorkoutTrackingScreen extends StatefulWidget {
  final Workout workout;

  const WorkoutTrackingScreen({super.key, required this.workout});

  @override
  State<WorkoutTrackingScreen> createState() => _WorkoutTrackingScreenState();
}

class _WorkoutTrackingScreenState extends State<WorkoutTrackingScreen> {
  Timer? _timer;
  int _secondsElapsed = 0;
  int _reps = 0;
  final int _targetReps = 15;
  bool _isTracking = false;
  int _caloriesBurned = 0;

  // Status tips that alternate locally
  int _tipIndex = 0;
  final List<List<Map<String, String>>> _statusRotations = [
    [
      {
        'title': 'Spine alignment',
        'status': 'Good',
        'tip': 'Keep back straight throughout the movement.',
      },
      {
        'title': 'Knee positioning',
        'status': 'Good',
        'tip': 'Knees stay tracking over mid-toes.',
      },
      {
        'title': 'Shoulder retraction',
        'status': 'Adjust',
        'tip': 'Roll shoulders down and back away from ears.',
      },
    ],
    [
      {
        'title': 'Spine alignment',
        'status': 'Good',
        'tip': 'Core brace maintained nicely.',
      },
      {
        'title': 'Knee positioning',
        'status': 'Adjust',
        'tip': 'Avoid letting knees cave inward on ascent.',
      },
      {
        'title': 'Shoulder retraction',
        'status': 'Good',
        'tip': 'Upper back engagement is solid.',
      },
    ],
    [
      {
        'title': 'Spine alignment',
        'status': 'Adjust',
        'tip': 'Avoid rounding lower back near the bottom.',
      },
      {
        'title': 'Knee positioning',
        'status': 'Good',
        'tip': 'Depth is parallel with good hip hinge.',
      },
      {
        'title': 'Shoulder retraction',
        'status': 'Good',
        'tip': 'Chest proud and neck neutral.',
      },
    ],
  ];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTracking() {
    if (_isTracking) {
      _timer?.cancel();
      setState(() {
        _isTracking = false;
      });
    } else {
      setState(() {
        _isTracking = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _secondsElapsed++;
          if (_secondsElapsed % 2 == 0 && _reps < _targetReps) {
            _reps++;
            _caloriesBurned += 3;
          }
          if (_secondsElapsed % 4 == 0) {
            _tipIndex = (_tipIndex + 1) % _statusRotations.length;
          }
          if (_reps >= _targetReps) {
            _finishExercise();
          }
        });
      });
    }
  }

  void _finishExercise() {
    _timer?.cancel();
    _isTracking = false;
    final minutes = (_secondsElapsed / 60).ceil();
    appState.completeWorkout(
      calories: _caloriesBurned > 0 ? _caloriesBurned : 45,
      minutes: minutes > 0 ? minutes : 1,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.softBone,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            side: const BorderSide(color: AppColors.border, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Set completed', style: AppTextStyles.title),
                const SizedBox(height: 8),
                Text(
                  'Great execution on ${widget.workout.exercises.first}.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_reps / $_targetReps',
                          style: AppTextStyles.metric.copyWith(fontSize: 28),
                        ),
                        const Text(
                          'Target reps met',
                          style: AppTextStyles.label,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_caloriesBurned',
                          style: AppTextStyles.metric.copyWith(fontSize: 28),
                        ),
                        const Text(
                          'Calories (kcal)',
                          style: AppTextStyles.label,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // dialog
                      Navigator.pop(context); // screen
                    },
                    child: const Text('Continue workout'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tips = _statusRotations[_tipIndex];

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        backgroundColor: AppColors.deepForest,
        foregroundColor: AppColors.softBone,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          widget.workout.exercises.first,
          style: AppTextStyles.subtitleDark,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Upper Camera Placeholder & Simulated Pose Overlay
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                color: AppColors.charcoalOlive,
                child: Stack(
                  children: [
                    // Background placeholder image
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/pose_placeholder.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: AppColors.charcoalOlive),
                      ),
                    ),

                    // Custom painted teal pose overlay lines and joint dots
                    Positioned.fill(
                      child: CustomPaint(painter: PoseOverlayPainter()),
                    ),

                    // Top Left Status Badge: "Pose detected"
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.charcoalOlive.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall,
                          ),
                          border: Border.all(color: AppColors.teal, width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 14,
                              color: AppColors.teal,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Pose detected',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.softBone,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Top Right Timer
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.charcoalOlive.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall,
                          ),
                        ),
                        child: Text(
                          '${(_secondsElapsed ~/ 60).toString().padLeft(2, '0')}:${(_secondsElapsed % 60).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.softBone,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                      ),
                    ),

                    // Bottom Right Rep Counter in Metric style
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.deepForest.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusMedium,
                          ),
                          border: Border.all(
                            color: AppColors.warmOat.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$_reps / $_targetReps',
                              style: AppTextStyles.metricDark.copyWith(
                                fontSize: 32,
                              ),
                            ),
                            const Text(
                              'Reps',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textOnDarkSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Panel: Form Correction Tips in charcoalOlive
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.charcoalOlive,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppTheme.radiusLarge),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Form correction tips',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.softBone,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.separated(
                        itemCount: tips.length,
                        separatorBuilder: (context, index) =>
                            Divider(color: AppColors.warmOat.withOpacity(0.15)),
                        itemBuilder: (context, index) {
                          final item = tips[index];
                          final isGood = item['status'] == 'Good';
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}.',
                                  style: const TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textOnDarkSecondary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title']!,
                                        style: const TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.softBone,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item['tip']!,
                                        style: const TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontSize: 12,
                                          color: AppColors.textOnDarkSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isGood
                                        ? AppColors.sage
                                        : AppColors.terracotta,
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.radiusSmall,
                                    ),
                                  ),
                                  child: Text(
                                    item['status']!,
                                    style: const TextStyle(
                                      fontFamily: 'WorkSans',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.softBone,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _toggleTracking,
                        child: Text(
                          _isTracking ? 'Pause tracking' : 'Start exercise',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CustomPainter drawing 2px teal pose overlay lines and joint dots
class PoseOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.teal
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = AppColors.teal
      ..style = PaintingStyle.fill;

    // Simulated stick skeleton normalized to size
    final head = Offset(size.width * 0.50, size.height * 0.22);
    final neck = Offset(size.width * 0.50, size.height * 0.30);
    final leftShoulder = Offset(size.width * 0.40, size.height * 0.33);
    final rightShoulder = Offset(size.width * 0.60, size.height * 0.33);
    final leftElbow = Offset(size.width * 0.34, size.height * 0.45);
    final rightElbow = Offset(size.width * 0.66, size.height * 0.45);
    final leftWrist = Offset(size.width * 0.36, size.height * 0.56);
    final rightWrist = Offset(size.width * 0.64, size.height * 0.56);

    final midHip = Offset(size.width * 0.50, size.height * 0.58);
    final leftHip = Offset(size.width * 0.43, size.height * 0.58);
    final rightHip = Offset(size.width * 0.57, size.height * 0.58);

    final leftKnee = Offset(size.width * 0.42, size.height * 0.74);
    final rightKnee = Offset(size.width * 0.58, size.height * 0.74);
    final leftAnkle = Offset(size.width * 0.41, size.height * 0.90);
    final rightAnkle = Offset(size.width * 0.59, size.height * 0.90);

    // Draw torso & head
    canvas.drawLine(head, neck, linePaint);
    canvas.drawLine(neck, midHip, linePaint);

    // Draw arms
    canvas.drawLine(neck, leftShoulder, linePaint);
    canvas.drawLine(neck, rightShoulder, linePaint);
    canvas.drawLine(leftShoulder, leftElbow, linePaint);
    canvas.drawLine(leftElbow, leftWrist, linePaint);
    canvas.drawLine(rightShoulder, rightElbow, linePaint);
    canvas.drawLine(rightElbow, rightWrist, linePaint);

    // Draw legs
    canvas.drawLine(midHip, leftHip, linePaint);
    canvas.drawLine(midHip, rightHip, linePaint);
    canvas.drawLine(leftHip, leftKnee, linePaint);
    canvas.drawLine(leftKnee, leftAnkle, linePaint);
    canvas.drawLine(rightHip, rightKnee, linePaint);
    canvas.drawLine(rightKnee, rightAnkle, linePaint);

    // Draw joint dots (radius 4)
    final joints = [
      head,
      neck,
      leftShoulder,
      rightShoulder,
      leftElbow,
      rightElbow,
      leftWrist,
      rightWrist,
      leftHip,
      rightHip,
      leftKnee,
      rightKnee,
      leftAnkle,
      rightAnkle,
    ];

    for (final pt in joints) {
      canvas.drawCircle(pt, 4.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
