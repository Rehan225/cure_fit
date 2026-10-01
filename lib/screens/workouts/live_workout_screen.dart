import 'dart:async';

import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../data/participant_data.dart';
import '../../models/workout.dart';
import '../../theme/app_theme.dart';

class LiveWorkoutScreen extends StatefulWidget {
  final Workout workout;

  const LiveWorkoutScreen({super.key, required this.workout});

  @override
  State<LiveWorkoutScreen> createState() => _LiveWorkoutScreenState();
}

class _LiveWorkoutScreenState extends State<LiveWorkoutScreen> {
  Timer? _timer;
  int _secondsElapsed = 0;
  int _reps = 0;
  int _caloriesBurned = 14;
  int _heartRate = 142;
  bool _isPaused = false;
  bool _isWearableSyncing = false;
  bool _isWearableSynced = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          _secondsElapsed++;
          if (_secondsElapsed % 3 == 0) {
            _reps++;
          }
          if (_secondsElapsed % 4 == 0) {
            _caloriesBurned += 2;
          }
          // Fluctuate heart rate realistically
          if (_secondsElapsed % 5 == 0) {
            _heartRate = 138 + (_secondsElapsed % 25);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  // Zone 1: <115, Zone 2: 115-135, Zone 3: 136-155, Zone 4: 156-175, Zone 5: >175
  int get _currentZone {
    if (_heartRate < 115) return 1;
    if (_heartRate <= 135) return 2;
    if (_heartRate <= 155) return 3;
    if (_heartRate <= 175) return 4;
    return 5;
  }

  String get _zoneName {
    switch (_currentZone) {
      case 1:
        return 'Zone 1 - Recovery';
      case 2:
        return 'Zone 2 - Fat Burn';
      case 3:
        return 'Zone 3 - Cardio';
      case 4:
        return 'Zone 4 - Peak';
      case 5:
        return 'Zone 5 - Maximum';
      default:
        return 'Zone 3 - Cardio';
    }
  }

  void _syncWearable() {
    setState(() {
      _isWearableSyncing = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _isWearableSyncing = false;
          _isWearableSynced = true;
          _heartRate = 148;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Wearable synced: heart rate monitor connected.',
              style: TextStyle(
                fontFamily: 'WorkSans',
                color: AppColors.softBone,
              ),
            ),
            backgroundColor: AppColors.deepForest,
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _endWorkout() {
    _timer?.cancel();
    final minutes = (_secondsElapsed / 60).ceil();
    appState.completeWorkout(
      calories: _caloriesBurned,
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
                const Text('Workout completed', style: AppTextStyles.title),
                const SizedBox(height: 12),
                Text(widget.workout.title, style: AppTextStyles.subtitle),
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
                          '$_caloriesBurned',
                          style: AppTextStyles.metric.copyWith(fontSize: 28),
                        ),
                        const Text(
                          'Calories (kcal)',
                          style: AppTextStyles.label,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatTime(_secondsElapsed),
                          style: AppTextStyles.metric.copyWith(fontSize: 28),
                        ),
                        const Text('Total time', style: AppTextStyles.label),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_reps',
                          style: AppTextStyles.metric.copyWith(fontSize: 28),
                        ),
                        const Text('Total reps', style: AppTextStyles.label),
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
                    child: const Text('Back to workouts'),
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
    final zone = _currentZone;

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        backgroundColor: AppColors.deepForest,
        foregroundColor: AppColors.softBone,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(widget.workout.title, style: AppTextStyles.subtitleDark),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.terracotta,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: const Text(
              'Live',
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.softBone,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top: Instructor Area & Participants Grid
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Exercise and Timer Header
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.workout.exercises.first,
                                style: AppTextStyles.subtitleDark,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Instructor: ${widget.workout.instructor}',
                                style: AppTextStyles.labelDark,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.charcoalOlive,
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusSmall,
                              ),
                            ),
                            child: Text(
                              _formatTime(_secondsElapsed),
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.softBone,
                                fontFeatures: [FontFeature.tabularFigures()],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Instructor Video Placeholder Area
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: AppColors.charcoalOlive,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusLarge,
                        ),
                        border: Border.all(
                          color: AppColors.warmOat.withOpacity(0.2),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.play_circle_outline,
                                  size: 48,
                                  color: AppColors.softBone,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Instructor Stream (Simulated)',
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 13,
                                    color: AppColors.textOnDarkSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.deepForest.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusSmall,
                                ),
                              ),
                              child: Text(
                                widget.workout.instructor,
                                style: const TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 11,
                                  color: AppColors.softBone,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Participant grid (mock participant squares)
                    const Text(
                      'Live Participants',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.softBone,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.0,
                          ),
                      itemCount: mockParticipants.length,
                      itemBuilder: (context, index) {
                        final p = mockParticipants[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.charcoalOlive,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusSmall,
                            ),
                            border: Border.all(
                              color: AppColors.warmOat.withOpacity(0.15),
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: AppColors.warmOat,
                                child: Text(
                                  p.avatarText,
                                  style: const TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.deepForest,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                p.name.split(' ').first,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 10,
                                  color: AppColors.softBone,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom panel in softBone with top border and radius 8 at top corners
            Container(
              decoration: const BoxDecoration(
                color: AppColors.softBone,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusLarge),
                ),
                border: Border(
                  top: BorderSide(color: AppColors.border, width: 1),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Reps, Calories, Heart Rate stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Heart Rate
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '$_heartRate',
                                style: AppTextStyles.metric.copyWith(
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text('BPM', style: AppTextStyles.label),
                            ],
                          ),
                          Text(
                            _zoneName,
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deepForest,
                            ),
                          ),
                        ],
                      ),
                      // Calories
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '$_caloriesBurned',
                                style: AppTextStyles.metric.copyWith(
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text('kcal', style: AppTextStyles.label),
                            ],
                          ),
                          const Text('Calories', style: AppTextStyles.label),
                        ],
                      ),
                      // Reps
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '$_reps',
                                style: AppTextStyles.metric.copyWith(
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text('reps', style: AppTextStyles.label),
                            ],
                          ),
                          const Text('Rep counter', style: AppTextStyles.label),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Five-segment solid heart rate zone bar
                  Row(
                    children: [
                      // Zone 1: Recovery (sage)
                      Expanded(
                        child: Container(
                          height: zone == 1 ? 8 : 4,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            color: zone == 1
                                ? AppColors.sage
                                : AppColors.sage.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // Zone 2: Fat Burn (teal)
                      Expanded(
                        child: Container(
                          height: zone == 2 ? 8 : 4,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            color: zone == 2
                                ? AppColors.teal
                                : AppColors.teal.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // Zone 3: Cardio (ochre)
                      Expanded(
                        child: Container(
                          height: zone == 3 ? 8 : 4,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            color: zone == 3
                                ? AppColors.ochre
                                : AppColors.ochre.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // Zone 4: Peak (orange)
                      Expanded(
                        child: Container(
                          height: zone == 4 ? 8 : 4,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                            color: zone == 4
                                ? AppColors.orange
                                : AppColors.orange.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // Zone 5: Maximum (terracotta)
                      Expanded(
                        child: Container(
                          height: zone == 5 ? 8 : 4,
                          decoration: BoxDecoration(
                            color: zone == 5
                                ? AppColors.terracotta
                                : AppColors.terracotta.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Wearable sync button / status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _isWearableSynced
                                ? Icons.watch_outlined
                                : Icons.phonelink_ring_outlined,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _isWearableSynced
                                ? 'Wearable synced'
                                : 'Wearable not synced',
                            style: AppTextStyles.label,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: _isWearableSyncing ? null : _syncWearable,
                        child: Text(
                          _isWearableSyncing
                              ? 'Syncing...'
                              : (_isWearableSynced
                                    ? 'Re-sync'
                                    : 'Sync wearable'),
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.deepForest,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Pause and End workout controls
                  Row(
                    children: [
                      // Pause (Secondary button: 1px deepForest border)
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _isPaused = !_isPaused;
                              });
                            },
                            child: Text(_isPaused ? 'Resume' : 'Pause'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // End workout (Destructive button: 1px terracotta border, label terracotta)
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.terracotta,
                              side: const BorderSide(
                                color: AppColors.terracotta,
                                width: 1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusMedium,
                                ),
                              ),
                            ),
                            onPressed: _endWorkout,
                            child: const Text('End workout'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
