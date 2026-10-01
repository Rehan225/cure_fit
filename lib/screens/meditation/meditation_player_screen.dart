import 'dart:async';

import 'package:flutter/material.dart';

import '../../models/meditation.dart';
import '../../data/meditation_data.dart';
import '../../theme/app_theme.dart';

class MeditationPlayerScreen extends StatefulWidget {
  final MeditationSession session;

  const MeditationPlayerScreen({super.key, required this.session});

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> {
  bool _isPlaying = true;
  int _secondsElapsed = 0;
  late final int _totalSeconds;
  Timer? _timer;
  String _selectedAmbient = 'Rain';
  double _volume = 0.75;

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.session.durationMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPlaying && mounted) {
        setState(() {
          if (_secondsElapsed < _totalSeconds) {
            _secondsElapsed++;
          } else {
            _finishMeditation();
          }
        });
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _finishMeditation() {
    _timer?.cancel();
    _isPlaying = false;

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
                const Text('Meditation finished', style: AppTextStyles.title),
                const SizedBox(height: 8),
                Text(
                  'Mindful session completed for ${widget.session.title}.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  '${widget.session.durationMinutes} minutes of mindful presence logged.',
                  style: AppTextStyles.label,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // dialog
                      Navigator.pop(context); // screen
                    },
                    child: const Text('Back to library'),
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

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_secondsElapsed / _totalSeconds).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        backgroundColor: AppColors.deepForest,
        foregroundColor: AppColors.softBone,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(widget.session.category, style: AppTextStyles.subtitleDark),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover art / visual box
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Image.asset(
                    widget.session.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.charcoalOlive,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.spa_outlined,
                        size: 48,
                        color: AppColors.softBone,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title and description
              Text(widget.session.title, style: AppTextStyles.titleDark),
              const SizedBox(height: 6),
              Text(
                widget.session.description,
                style: const TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 13,
                  color: AppColors.textOnDarkSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Thin Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: SizedBox(
                  height: 4,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.charcoalOlive,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.teal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatTime(_secondsElapsed),
                    style: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 12,
                      color: AppColors.textOnDarkSecondary,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  Text(
                    _formatTime(_totalSeconds),
                    style: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 12,
                      color: AppColors.textOnDarkSecondary,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Play / Pause control
              Center(
                child: GestureDetector(
                  onTap: _togglePlayPause,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.teal,
                      borderRadius: BorderRadius.circular(
                        AppTheme.radiusMedium,
                      ),
                    ),
                    child: Icon(
                      _isPlaying
                          ? Icons.pause_outlined
                          : Icons.play_arrow_outlined,
                      size: 36,
                      color: AppColors.deepForest,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Ambient sound selector rows
              const Text(
                'Ambient sound',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.softBone,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.charcoalOlive,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                ),
                child: Column(
                  children: mockAmbientSounds.map((sound) {
                    final isSelected = _selectedAmbient == sound;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedAmbient = sound;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.deepForest.withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              sound,
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? AppColors.teal
                                    : AppColors.softBone,
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.radio_button_checked,
                                size: 18,
                                color: AppColors.teal,
                              )
                            else
                              const Icon(
                                Icons.radio_button_off,
                                size: 18,
                                color: AppColors.textOnDarkSecondary,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Volume Slider with teal active track
              const Text(
                'Volume',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.softBone,
                ),
              ),
              const SizedBox(height: 6),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.teal,
                  inactiveTrackColor: AppColors.charcoalOlive,
                  thumbColor: AppColors.softBone,
                  overlayColor: AppColors.teal.withOpacity(0.2),
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                  ),
                ),
                child: Slider(
                  value: _volume,
                  onChanged: (val) {
                    setState(() {
                      _volume = val;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
