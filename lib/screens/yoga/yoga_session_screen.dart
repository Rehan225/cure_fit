import 'dart:async';

import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../models/yoga_session.dart';
import '../../theme/app_theme.dart';

class YogaSessionScreen extends StatefulWidget {
  final YogaSession session;

  const YogaSessionScreen({super.key, required this.session});

  @override
  State<YogaSessionScreen> createState() => _YogaSessionScreenState();
}

class _YogaSessionScreenState extends State<YogaSessionScreen> {
  int _currentPoseIndex = 0;
  int _secondsLeft = 30;
  Timer? _timer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _resetPoseTimer();
  }

  void _resetPoseTimer() {
    _timer?.cancel();
    _secondsLeft = widget.session.poses[_currentPoseIndex].durationSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && mounted) {
        setState(() {
          if (_secondsLeft > 0) {
            _secondsLeft--;
          } else {
            _nextPose();
          }
        });
      }
    });
  }

  void _nextPose() {
    if (_currentPoseIndex < widget.session.poses.length - 1) {
      setState(() {
        _currentPoseIndex++;
      });
      _resetPoseTimer();
    } else {
      _finishYogaSession();
    }
  }

  void _previousPose() {
    if (_currentPoseIndex > 0) {
      setState(() {
        _currentPoseIndex--;
      });
      _resetPoseTimer();
    }
  }

  void _finishYogaSession() {
    _timer?.cancel();
    appState.completeWorkout(
      calories: 140,
      minutes: widget.session.durationMinutes,
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
                const Text('Yoga session complete', style: AppTextStyles.title),
                const SizedBox(height: 8),
                Text(
                  'Completed all poses in ${widget.session.title}.',
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
                          '${widget.session.durationMinutes} min',
                          style: AppTextStyles.metric.copyWith(fontSize: 26),
                        ),
                        const Text('Duration', style: AppTextStyles.label),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.session.poses.length}',
                          style: AppTextStyles.metric.copyWith(fontSize: 26),
                        ),
                        const Text('Poses held', style: AppTextStyles.label),
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
                    child: const Text('Back to yoga library'),
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
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPose = widget.session.poses[_currentPoseIndex];
    final progress = (_currentPoseIndex + 1) / widget.session.poses.length;
    final hasNext = _currentPoseIndex < widget.session.poses.length - 1;

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        backgroundColor: AppColors.deepForest,
        foregroundColor: AppColors.softBone,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(widget.session.title, style: AppTextStyles.subtitleDark),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: SizedBox(
                  height: 6,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.charcoalOlive,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.teal,
                    ),
                  ),
                ),
              ),
            ),

            // Pose content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    // Pose counter
                    Text(
                      'Pose ${_currentPoseIndex + 1} of ${widget.session.poses.length}',
                      style: AppTextStyles.labelDark,
                    ),
                    const SizedBox(height: 6),
                    Text(currentPose.name, style: AppTextStyles.titleDark),
                    const SizedBox(height: 16),

                    // Visual placeholder with simulated camera alignment overlay
                    Container(
                      width: double.infinity,
                      height: 200,
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
                            child: Icon(
                              Icons.accessibility_new_outlined,
                              size: 80,
                              color: AppColors.warmOat.withOpacity(0.4),
                            ),
                          ),
                          // Simulated alignment status chips
                          Positioned(
                            top: 12,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.deepForest.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusSmall,
                                ),
                                border: Border.all(
                                  color: AppColors.teal,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Pose detection active',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.teal,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.deepForest.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusSmall,
                                ),
                              ),
                              child: Text(
                                currentPose.alignmentStatus,
                                style: const TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.softBone,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Timer display
                    Center(
                      child: Column(
                        children: [
                          Text(
                            '$_secondsLeft',
                            style: AppTextStyles.metricDark.copyWith(
                              fontSize: 54,
                            ),
                          ),
                          const Text(
                            'Seconds remaining',
                            style: AppTextStyles.labelDark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Instructions box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.charcoalOlive,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusLarge,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Instructions',
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.softBone,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            currentPose.instructions,
                            style: const TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 13,
                              color: AppColors.softBone,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tip: ',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.teal,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  currentPose.tip,
                                  style: const TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 12,
                                    color: AppColors.textOnDarkSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Next pose label
                    if (hasNext)
                      Text(
                        'Up next: ${widget.session.poses[_currentPoseIndex + 1].name}',
                        style: AppTextStyles.labelDark,
                      ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Controls
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.deepForest,
                border: Border(
                  top: BorderSide(color: AppColors.charcoalOlive, width: 1),
                ),
              ),
              child: Row(
                children: [
                  if (_currentPoseIndex > 0)
                    IconButton(
                      onPressed: _previousPose,
                      icon: const Icon(
                        Icons.skip_previous_outlined,
                        color: AppColors.softBone,
                        size: 28,
                      ),
                    ),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.softBone,
                        side: const BorderSide(
                          color: AppColors.softBone,
                          width: 1,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPaused = !_isPaused;
                        });
                      },
                      child: Text(_isPaused ? 'Resume' : 'Pause'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextPose,
                      child: Text(hasNext ? 'Next pose' : 'Finish'),
                    ),
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
