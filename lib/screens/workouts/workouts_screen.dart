import 'package:flutter/material.dart';

import '../../data/workout_data.dart';
import '../../models/workout.dart';
import '../../theme/app_theme.dart';
import '../../widgets/skeleton_box.dart';
import '../../widgets/workout_card.dart';
import '../yoga/yoga_list_screen.dart';
import 'live_workout_screen.dart';
import 'workout_detail_screen.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  bool _isLoading = true;
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Strength',
    'HIIT',
    'Core',
    'Upper Body',
    'Lower Body',
  ];

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

  List<Workout> get _filteredWorkouts {
    if (_selectedCategory == 'All') {
      return mockWorkouts;
    }
    return mockWorkouts.where((w) {
      return w.title.toLowerCase().contains(_selectedCategory.toLowerCase());
    }).toList();
  }

  Widget _buildSkeletonLoader() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        SkeletonBox(width: double.infinity, height: 40),
        SizedBox(height: 16),
        SkeletonBox(width: double.infinity, height: 260),
        SizedBox(height: 12),
        SkeletonBox(width: double.infinity, height: 260),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final liveWorkout = mockWorkouts.firstWhere((w) => w.isLiveNow);

    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        title: const Text('Workouts', style: AppTextStyles.title),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const YogaListScreen()),
              );
            },
            icon: const Icon(
              Icons.accessibility_new_outlined,
              size: 18,
              color: AppColors.deepForest,
            ),
            label: const Text(
              'Yoga',
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w600,
                color: AppColors.deepForest,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? _buildSkeletonLoader()
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                // Live class banner highlight
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.charcoalOlive,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.terracotta,
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusSmall,
                              ),
                            ),
                            child: const Text(
                              'Live stream now',
                              style: TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.softBone,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.people_outline,
                                size: 14,
                                color: AppColors.textOnDarkSecondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${liveWorkout.participantCount} active',
                                style: AppTextStyles.labelDark,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        liveWorkout.title,
                        style: AppTextStyles.subtitleDark,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Trainer: ${liveWorkout.instructor}',
                        style: AppTextStyles.labelDark,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LiveWorkoutScreen(workout: liveWorkout),
                              ),
                            );
                          },
                          child: const Text('Join live class'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Category Chips (Radius 4 per design.md)
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategory == category;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.deepForest
                                : AppColors.warmOat,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusSmall,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            category,
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? AppColors.softBone
                                  : AppColors.deepForest,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Workout List
                ..._filteredWorkouts.map((workout) {
                  return WorkoutCard(
                    workout: workout,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WorkoutDetailScreen(workout: workout),
                        ),
                      );
                    },
                  );
                }),
                const SizedBox(height: 24),
              ],
            ),
    );
  }
}
