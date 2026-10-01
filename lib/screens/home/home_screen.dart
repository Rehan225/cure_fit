import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../data/meal_data.dart';
import '../../data/workout_data.dart';
import '../../models/achievement.dart';
import '../../theme/app_theme.dart';
import '../../widgets/achievement_card.dart';
import '../../widgets/challenge_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/skeleton_box.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/workout_card.dart';
import '../challenges/challenges_screen.dart';
import '../meditation/meditation_list_screen.dart';
import '../nutrition/meal_detail_screen.dart';
import '../nutrition/nutrition_screen.dart';
import '../workouts/live_workout_screen.dart';
import '../workouts/workout_detail_screen.dart';
import '../workouts/workouts_screen.dart';
import '../yoga/yoga_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? onSwitchTab;

  const HomeScreen({super.key, this.onSwitchTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulated skeleton loader delay (600 ms) per plan.md & design.md
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _showAchievementDialog(Achievement achievement) {
    showDialog(
      context: context,
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
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: achievement.isUnlocked
                            ? AppColors.sage
                            : AppColors.warmOat,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusMedium,
                        ),
                      ),
                      child: Icon(
                        achievement.isUnlocked
                            ? Icons.military_tech_outlined
                            : Icons.lock_outline,
                        color: AppColors.deepForest,
                        size: 24,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(context),
                      color: AppColors.deepForest,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(achievement.title, style: AppTextStyles.subtitle),
                const SizedBox(height: 6),
                Text(achievement.description, style: AppTextStyles.body),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    border: Border.all(color: AppColors.border, width: 1),
                  ),
                  child: Text(
                    'Condition: ${achievement.unlockCondition}',
                    style: AppTextStyles.label,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showNotificationsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.softBone,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLarge),
        ),
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.warmOat,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Notifications', style: AppTextStyles.subtitle),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'Live session with Arjun Sharma begins in 15 minutes.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 6),
                const Text('Today at 06:45 AM', style: AppTextStyles.label),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'Meal planner reminder: log your dinner calories.',
                  style: AppTextStyles.body,
                ),
                const SizedBox(height: 6),
                const Text('Yesterday at 08:30 PM', style: AppTextStyles.label),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonLoader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 16),
          SkeletonBox(width: double.infinity, height: 130),
          SizedBox(height: 12),
          SkeletonBox(width: double.infinity, height: 110),
          SizedBox(height: 12),
          SkeletonBox(width: double.infinity, height: 120),
          SizedBox(height: 24),
          SkeletonBox(width: 140, height: 20),
          SizedBox(height: 12),
          SkeletonBox(width: double.infinity, height: 200),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBone,
      appBar: AppBar(
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Cure.fit',
              style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.deepForest,
              ),
            ),
            Text('Fitness and Wellness', style: AppTextStyles.label),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showNotificationsSheet,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  size: 24,
                  color: AppColors.deepForest,
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.teal,
              child: const Text(
                'R',
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepForest,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? _buildSkeletonLoader()
          : AnimatedBuilder(
              animation: appState,
              builder: (context, child) {
                final liveWorkout = mockWorkouts.firstWhere((w) => w.isLiveNow);
                final recommendedWorkout = mockWorkouts[1];
                final recommendedMeal = mockMeals[0];
                final activeChallenge = appState.challenges.first;
                final achievement = appState.achievements[1]; // Workout warrior

                return ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  children: [
                    // Greeting and short date
                    Text(
                      'Good morning, Rehan',
                      style: AppTextStyles.subtitle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 2),
                    const Text('15 September 2026', style: AppTextStyles.label),
                    const SizedBox(height: 16),

                    // Three module cards stacked vertically at full width
                    // 1. Activity (Teal fill, deepForest text)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.teal,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusLarge,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Activity',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepForest,
                                ),
                              ),
                              Icon(
                                Icons.directions_run_outlined,
                                size: 20,
                                color: AppColors.deepForest,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '8,420',
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.deepForest,
                                      ),
                                    ),
                                    Text(
                                      'Steps today',
                                      style: AppTextStyles.label.copyWith(
                                        color: AppColors.deepForest.withOpacity(
                                          0.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: AppColors.deepForest.withOpacity(0.2),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${appState.totalCaloriesBurned}',
                                      style: const TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.deepForest,
                                      ),
                                    ),
                                    Text(
                                      'Calories burned',
                                      style: AppTextStyles.label.copyWith(
                                        color: AppColors.deepForest.withOpacity(
                                          0.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 2. Nutrition (Terracotta fill, softBone text)
                    GestureDetector(
                      onTap: () {
                        if (widget.onSwitchTab != null) {
                          widget.onSwitchTab!(2);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NutritionScreen(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.terracotta,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusLarge,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  'Nutrition',
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.softBone,
                                  ),
                                ),
                                Icon(
                                  Icons.restaurant_outlined,
                                  size: 20,
                                  color: AppColors.softBone,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${appState.plannedMeals.length} / 4 meals logged',
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.softBone,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${appState.totalPlannedCalories} kcal planned today',
                              style: const TextStyle(
                                fontFamily: 'WorkSans',
                                fontSize: 12,
                                color: AppColors.softBone,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: SizedBox(
                                height: 6,
                                child: LinearProgressIndicator(
                                  value: (appState.plannedMeals.length / 4.0)
                                      .clamp(0.0, 1.0),
                                  backgroundColor: AppColors.deepForest
                                      .withOpacity(0.2),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        AppColors.softBone,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 3. Wellness (Sage fill with two inner tiles in softBone)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.sage,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusLarge,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Wellness',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deepForest,
                                ),
                              ),
                              Icon(
                                Icons.self_improvement_outlined,
                                size: 20,
                                color: AppColors.deepForest,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MeditationListScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.softBone,
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusMedium,
                                      ),
                                      border: Border.all(
                                        color: AppColors.border,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.spa_outlined,
                                          size: 20,
                                          color: AppColors.deepForest,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Meditation',
                                          style: TextStyle(
                                            fontFamily: 'WorkSans',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.deepForest,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const YogaListScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.softBone,
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusMedium,
                                      ),
                                      border: Border.all(
                                        color: AppColors.border,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.accessibility_new_outlined,
                                          size: 20,
                                          color: AppColors.deepForest,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Yoga',
                                          style: TextStyle(
                                            fontFamily: 'WorkSans',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.deepForest,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Section 3: Daily stats (Calories, Workout mins, Current heart rate)
                    SectionHeader(title: 'Today overview'),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            icon: Icons.local_fire_department_outlined,
                            value: '420',
                            unit: 'kcal',
                            label: 'Calories',
                            accentColor: AppColors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            icon: Icons.timer_outlined,
                            value: '${appState.workoutMinutes}',
                            unit: 'min',
                            label: 'Active time',
                            accentColor: AppColors.deepForest,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            icon: Icons.favorite_outline,
                            value: '${appState.currentHeartRate}',
                            unit: 'BPM',
                            label: 'Heart rate',
                            accentColor: AppColors.terracotta,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Section 4: Live workout card
                    SectionHeader(
                      title: 'Live now',
                      actionText: 'See all',
                      onAction: () {
                        if (widget.onSwitchTab != null) {
                          widget.onSwitchTab!(1);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WorkoutsScreen(),
                            ),
                          );
                        }
                      },
                    ),
                    WorkoutCard(
                      workout: liveWorkout,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LiveWorkoutScreen(workout: liveWorkout),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Section 5: Recommended workout
                    SectionHeader(
                      title: 'Recommended workout',
                      actionText: 'Explore',
                      onAction: () {
                        if (widget.onSwitchTab != null) {
                          widget.onSwitchTab!(1);
                        }
                      },
                    ),
                    WorkoutCard(
                      workout: recommendedWorkout,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkoutDetailScreen(
                              workout: recommendedWorkout,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Section 6: Meal recommendation
                    SectionHeader(
                      title: 'Recommended meal',
                      actionText: 'Meal menu',
                      onAction: () {
                        if (widget.onSwitchTab != null) {
                          widget.onSwitchTab!(2);
                        }
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MealDetailScreen(meal: recommendedMeal),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusLarge,
                          ),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusSmall,
                              ),
                              child: SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.asset(
                                  recommendedMeal.imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: AppColors.warmOat,
                                        child: const Icon(
                                          Icons.restaurant_outlined,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.warmOat,
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusSmall,
                                      ),
                                    ),
                                    child: Text(
                                      recommendedMeal.category,
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
                                    recommendedMeal.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.subtitle,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${recommendedMeal.calories} kcal, ${recommendedMeal.protein}g protein',
                                    style: AppTextStyles.label,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Section 7: Current challenge
                    SectionHeader(
                      title: 'Current challenge',
                      actionText: 'All challenges',
                      onAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChallengesScreen(),
                          ),
                        );
                      },
                    ),
                    ChallengeCard(
                      challenge: activeChallenge,
                      onToggleJoin: () {
                        appState.toggleChallengeJoin(activeChallenge.id);
                      },
                    ),
                    const SizedBox(height: 24),

                    // Section 8: Achievement preview
                    SectionHeader(
                      title: 'Next achievement',
                      actionText: 'View badges',
                      onAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ChallengesScreen(initialTabIndex: 1),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 120,
                      child: AchievementCard(
                        achievement: achievement,
                        onTap: () => _showAchievementDialog(achievement),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                );
              },
            ),
    );
  }
}
