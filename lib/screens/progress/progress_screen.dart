import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../data/progress_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/section_header.dart';
import '../../widgets/skeleton_box.dart';
import '../../widgets/stat_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool _isLoading = true;
  int _selectedDay = 15; // default selected day: 15 Sep

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Widget _buildSkeletonLoader() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        SkeletonBox(width: double.infinity, height: 100),
        SizedBox(height: 16),
        SkeletonBox(width: double.infinity, height: 240),
        SizedBox(height: 16),
        SkeletonBox(width: double.infinity, height: 160),
        SizedBox(height: 16),
        SkeletonBox(width: double.infinity, height: 200),
      ],
    );
  }

  Widget _buildCalendar() {
    final weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          // Month Title with static previous and next arrow icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('September 2026', style: AppTextStyles.subtitle),
              Row(
                children: const [
                  Icon(
                    Icons.chevron_left_outlined,
                    size: 24,
                    color: AppColors.deepForest,
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right_outlined,
                    size: 24,
                    color: AppColors.deepForest,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays.map((day) {
              return SizedBox(
                width: 32,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.label.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),

          // Calendar days grid: Sep 2026 starts on Tuesday (offset 1)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 1.0,
            ),
            itemCount: 35, // 5 weeks
            itemBuilder: (context, index) {
              final dayNumber = index; // 1st is Tuesday
              if (dayNumber < 1 || dayNumber > 30) {
                return const SizedBox.shrink();
              }

              final isSelected = dayNumber == _selectedDay;
              final hasWorkout = mockLoggedWorkoutDays.contains(dayNumber);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDay = dayNumber;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.teal : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$dayNumber',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontSize: 12,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? AppColors.deepForest
                              : AppColors.deepForest,
                        ),
                      ),
                      // Logged workout marker: single solid sage dot beneath number
                      if (hasWorkout)
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.deepForest
                                : AppColors.sage,
                            shape: BoxShape.circle,
                          ),
                        )
                      else
                        const SizedBox(height: 6),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),

          // Logged status label
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.sage,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text('Workout logged', style: AppTextStyles.label),
              const SizedBox(width: 16),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.teal,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 6),
              const Text('Selected date', style: AppTextStyles.label),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart({
    required String title,
    required List<WeeklyDataPoint> points,
    required String unit,
    required double maxValue,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.subtitle),
          const SizedBox(height: 16),
          // Chart bars: solid sage bars, today in teal. 1px solid gridlines in warmOat
          SizedBox(
            height: 130,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: points.map((p) {
                final barHeight = (p.value / maxValue * 100).clamp(12.0, 100.0);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${p.value.toInt()}',
                      style: const TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 10,
                        color: AppColors.textSecondary,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 22,
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: p.isToday ? AppColors.teal : AppColors.sage,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusSmall,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      p.dayLabel,
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 11,
                        fontWeight: p.isToday
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: AppColors.deepForest,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeforeAfterComparison() {
    final beforePhoto = mockProgressPhotos.firstWhere((p) => p.isBefore);
    final afterPhoto = mockProgressPhotos.firstWhere((p) => p.isAfter);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Visual progression', style: AppTextStyles.subtitle),
              // Weight change shown as a tag in warmOat per design.md Section 7.5
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.warmOat,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: const Text(
                  '5 kg lost',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.deepForest,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Before and after side by side with simple static divider
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Image.asset(
                          beforePhoto.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: AppColors.warmOat,
                                child: const Icon(Icons.person_outline),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Before (Day 1)',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.deepForest,
                      ),
                    ),
                    Text(beforePhoto.dateStamp, style: AppTextStyles.label),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(width: 1, height: 180, color: AppColors.border),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                      child: AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Image.asset(
                          afterPhoto.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: AppColors.sage,
                                child: const Icon(Icons.person_outline),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Current (Month 3)',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.deepForest,
                      ),
                    ),
                    Text(afterPhoto.dateStamp, style: AppTextStyles.label),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Progress & History', style: AppTextStyles.title),
      ),
      body: _isLoading
          ? _buildSkeletonLoader()
          : AnimatedBuilder(
              animation: appState,
              builder: (context, child) {
                return ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  children: [
                    // Overview Stat Cards
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            icon: Icons.fitness_center_outlined,
                            value: '${appState.completedWorkoutsCount}',
                            unit: 'sessions',
                            label: 'Workouts',
                            accentColor: AppColors.deepForest,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            icon: Icons.local_fire_department_outlined,
                            value: '${appState.totalCaloriesBurned}',
                            unit: 'kcal',
                            label: 'Burned',
                            accentColor: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            icon: Icons.timer_outlined,
                            value: '${appState.workoutMinutes}',
                            unit: 'mins',
                            label: 'Total time',
                            accentColor: AppColors.deepForest,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            icon: Icons.repeat_outlined,
                            value: '${appState.currentStreak}',
                            unit: 'days',
                            label: 'Streak',
                            accentColor: AppColors.teal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Calendar
                    SectionHeader(title: 'Workout calendar'),
                    _buildCalendar(),
                    const SizedBox(height: 24),

                    // Weekly Calories Chart
                    _buildWeeklyChart(
                      title: 'Weekly calories burned',
                      points: mockWeeklyCalories,
                      unit: 'kcal',
                      maxValue: 700,
                    ),
                    const SizedBox(height: 20),

                    // Weekly Duration Chart
                    _buildWeeklyChart(
                      title: 'Weekly active minutes',
                      points: mockWeeklyDurationMinutes,
                      unit: 'min',
                      maxValue: 70,
                    ),
                    const SizedBox(height: 24),

                    // Before / After Comparison
                    SectionHeader(title: 'Progress timeline'),
                    _buildBeforeAfterComparison(),
                    const SizedBox(height: 16),

                    // Progress Timeline Cards
                    ...mockProgressPhotos.map((photo) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusLarge,
                          ),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusSmall,
                              ),
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.asset(
                                  photo.imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: AppColors.warmOat,
                                        child: const Icon(Icons.photo_outlined),
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        photo.title,
                                        style: AppTextStyles.subtitle.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${photo.weightKg} kg',
                                        style: const TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.deepForest,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    photo.dateStamp,
                                    style: AppTextStyles.label,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    photo.note,
                                    style: AppTextStyles.body.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                  ],
                );
              },
            ),
    );
  }
}
